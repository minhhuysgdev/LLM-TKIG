#!/usr/bin/env python3
"""
Script to classify threat intelligence articles using Mixtral-8x7B-Instruct-v0.1.
Enhanced with reasoning capabilities from Mistral AI.
"""

import os
import json
import torch
import datetime
from pathlib import Path
from typing import List, Dict, Any
from transformers import AutoTokenizer, AutoModel, AutoModelForCausalLM, pipeline
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report
import numpy as np
import gc
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Try to import bitsandbytes for 8-bit loading
try:
    import bitsandbytes
except ImportError:
    print("bitsandbytes not installed - 8-bit loading unavailable")


def load_data(input_file: str) -> List[Dict[str, Any]]:
    """
    Load threat intelligence data from JSON file.
    """
    try:
        print(f"📖 Loading data from: {input_file}")
        with open(input_file, 'r', encoding='utf-8') as f:
            data = json.load(f)
        print(f"✅ Loaded {len(data)} articles")
        return data
    except Exception as e:
        print(f"❌ Error loading data: {e}")
        return []


def setup_model():
    """
    Setup Mistral-7B-Instruct model for classification.
    """
    try:
        print("🤖 Setting up Mistral-7B-Instruct model...")
        
        # Get token from environment variable
        hf_token = os.getenv('HUGGINGFACE_TOKEN')
        if not hf_token:
            print("⚠️ HUGGINGFACE_TOKEN not found in environment variables")
            print("   Please set HUGGINGFACE_TOKEN in your .env file")
            print("   You can get your token from: https://huggingface.co/settings/tokens")
        
        # Check device availability
        use_cuda = os.getenv('USE_CUDA', 'true').lower() == 'true'
        use_mps = os.getenv('USE_MPS', 'true').lower() == 'true'
        
        if use_cuda and torch.cuda.is_available():
            device = 'cuda'
            print("🔥 Using CUDA")
        elif use_mps and hasattr(torch.backends, 'mps') and torch.backends.mps.is_available():
            device = 'mps'
            print("🍎 Using Apple Silicon MPS")
        else:
            device = 'cpu'
            print("💻 Using CPU")
        
        # Get model name from environment or use default
        model_name = os.getenv('MODEL_NAME', "mistralai/Mistral-7B-Instruct-v0.2")
        print(f"📦 Loading model: {model_name}")
        
        try:
            from transformers import AutoModelForCausalLM
            
            # Load tokenizer with token if available
            if hf_token:
                tokenizer = AutoTokenizer.from_pretrained(
                    model_name,
                    token=hf_token,
                    trust_remote_code=True
                )
            else:
                tokenizer = AutoTokenizer.from_pretrained(
                    model_name,
                    trust_remote_code=True
                )
            
            # Load model with token if available
            if hf_token:
                model = AutoModelForCausalLM.from_pretrained(
                    model_name,
                    token=hf_token,
                    torch_dtype=torch.float16 if device != 'cpu' else torch.float32,
                    device_map='auto' if device != 'cpu' else None,
                    trust_remote_code=True
                )
            else:
                model = AutoModelForCausalLM.from_pretrained(
                    model_name,
                    torch_dtype=torch.float16 if device != 'cpu' else torch.float32,
                    device_map='auto' if device != 'cpu' else None,
                    trust_remote_code=True
                )
            
            if device == 'cpu':
                model = model.to(device)
            
            # Set pad token if not exists
            if tokenizer.pad_token is None:
                tokenizer.pad_token = tokenizer.eos_token
            
            print(f"✅ {model_name} loaded successfully on {device}")
            
            return {
                'model': model,
                'tokenizer': tokenizer,
                'device': device,
                'model_type': 'mistral_instruct'
            }
            
        except Exception as e:
            print(f"⚠️ Could not load {model_name} (may need auth or resources): {e}")
            print("🔄 Trying alternative open model...")
            
            # Fallback to open access instruction model
            fallback_model = os.getenv('FALLBACK_MODEL', "microsoft/DialoGPT-large")
            print(f"📦 Loading fallback model: {fallback_model}")
            
            try:
                if hf_token:
                    tokenizer = AutoTokenizer.from_pretrained(
                        fallback_model,
                        token=hf_token
                    )
                    model = AutoModelForCausalLM.from_pretrained(
                        fallback_model,
                        token=hf_token,
                        torch_dtype=torch.float16 if device != 'cpu' else torch.float32,
                        device_map='auto' if device != 'cpu' else None
                    )
                else:
                    tokenizer = AutoTokenizer.from_pretrained(fallback_model)
                    model = AutoModelForCausalLM.from_pretrained(
                        fallback_model,
                        torch_dtype=torch.float16 if device != 'cpu' else torch.float32,
                        device_map='auto' if device != 'cpu' else None
                    )
                
                if device == 'cpu':
                    model = model.to(device)
                
                if tokenizer.pad_token is None:
                    tokenizer.pad_token = tokenizer.eos_token
                
                print(f"✅ {fallback_model} loaded successfully on {device}")
                
                return {
                    'model': model,
                    'tokenizer': tokenizer,
                    'device': device,
                    'model_type': 'dialogpt_instruct'
                }
                
            except Exception as e2:
                print(f"❌ Could not load fallback {fallback_model} model: {e2}")
                return None
        
    except Exception as e:
        print(f"❌ Error setting up model: {e}")
        return None


def classify_with_mistral(title: str, content: str, model_info: Dict) -> Dict[str, Any]:
    """
    Enhanced classification using Mistral-7B instruction following capabilities.
    """
    if model_info is None or 'instruct' not in model_info.get('model_type', ''):
        # Fallback to rule-based if model not available
        return classify_with_rules(title, content)
    
    try:
        model = model_info['model']
        tokenizer = model_info['tokenizer']
        device = model_info['device']
        
        # Create a structured prompt for threat classification using Mistral format
        prompt = f"""[INST] You are a cybersecurity expert specialized in threat intelligence analysis. Analyze the given article and classify it.

Instructions:
1. Determine if this is a cybersecurity threat report (yes/no)
2. If yes, identify the main category and specific object
3. Provide confidence score (0.0-1.0)

Categories:
- Malware: ransomware, trojans, viruses, backdoors, etc.
- Vulnerability: CVEs, exploits, security flaws
- Tool: security tools, attack frameworks, software
- Technique: attack methods, tactics, procedures
- Actor: threat groups, APTs, cybercriminals

Article:
Title: {title}
Content: {content[:1500]}...

Please respond in this exact format:
THREAT: yes/no
CATEGORY: [category name]
OBJECT: [specific name/identifier]
CONFIDENCE: [0.0-1.0] [/INST]

Looking at this cybersecurity article, I'll analyze it systematically:

"""

        # Get max length from environment or use default
        max_length = int(os.getenv('MAX_LENGTH', '3000'))
        
        # Tokenize input
        inputs = tokenizer(
            prompt,
            max_length=max_length,
            truncation=True,
            return_tensors='pt'
        ).to(device)
        
        # Get generation parameters from environment or use defaults
        max_new_tokens = int(os.getenv('MAX_TOKENS', '200'))
        temperature = float(os.getenv('TEMPERATURE', '0.1'))
        
        # Generate response
        with torch.no_grad():
            outputs = model.generate(
                **inputs,
                max_new_tokens=max_new_tokens,
                do_sample=False,
                temperature=temperature,
                pad_token_id=tokenizer.eos_token_id,
                eos_token_id=tokenizer.eos_token_id
            )
        
        # Decode response
        response = tokenizer.decode(outputs[0][inputs['input_ids'].shape[1]:], skip_special_tokens=True)
        
        # Parse response
        is_threat = False
        category = "unknown"
        object_name = "unknown"
        confidence = 0.5
        
        lines = response.strip().split('\n')
        for line in lines:
            line = line.strip().upper()
            if line.startswith('THREAT:'):
                is_threat = 'YES' in line
            elif line.startswith('CATEGORY:'):
                category = line.split(':', 1)[1].strip().lower()
            elif line.startswith('OBJECT:'):
                object_name = line.split(':', 1)[1].strip()
            elif line.startswith('CONFIDENCE:'):
                try:
                    confidence = float(line.split(':', 1)[1].strip())
                except:
                    confidence = 0.5
        
        main_object = f"{category.title()}: {object_name}" if is_threat else ""
        
        return {
            'is_threat_report': is_threat,
            'main_object': main_object,
            'confidence': confidence,
            'mistral_response': response[:300] + "..." if len(response) > 300 else response
        }
        
    except Exception as e:
        print(f"⚠️ Mistral classification failed: {e}")
        # Fallback to rule-based classification
        return classify_with_rules(title, content)


def extract_features(text: str, model_info: Dict) -> np.ndarray:
    """
    Extract basic features for future use (simplified for generative models).
    """
    if model_info is None:
        return np.array([])
        
    try:
        # For generative models, we'll just return text length as a simple feature
        # This can be expanded later with more sophisticated feature extraction
        features = [
            len(text),
            len(text.split()),
            text.lower().count('malware'),
            text.lower().count('attack'),
            text.lower().count('vulnerability')
        ]
        
        return np.array(features, dtype=np.float32)
        
    except Exception as e:
        print(f"❌ Error extracting features: {e}")
        return np.array([])





def classify_with_rules(title: str, content: str) -> Dict[str, Any]:
    """
    Enhanced rule-based classification for threat intelligence with comprehensive coverage.
    """
    # Combine title and content for analysis
    text = f"{title} {content}".lower()
    
    # Comprehensive threat indicators with weighted scoring
    threat_indicators = {
        'malware': {
            'high_priority': ['ransomware', 'trojan', 'virus', 'backdoor', 'rootkit', 'worm', 'botnet', 'keylogger', 'spyware', 'adware'],
            'medium_priority': ['malware', 'malicious', 'infected', 'payload', 'dropper', 'loader'],
            'low_priority': ['threat', 'attack', 'compromise']
        },
        'vulnerability': {
            'high_priority': ['cve-', 'zero-day', 'zero day', 'exploit', 'vulnerability', 'security flaw', 'buffer overflow', 'sql injection'],
            'medium_priority': ['patch', 'update', 'fix', 'mitigation', 'workaround'],
            'low_priority': ['weakness', 'flaw', 'issue']
        },
        'tool': {
            'high_priority': ['cobalt strike', 'metasploit', 'nmap', 'wireshark', 'burp suite', 'fortinet', 'fortigate', 'fortisandbox', 'forticnapp'],
            'medium_priority': ['tool', 'framework', 'software', 'platform', 'solution'],
            'low_priority': ['application', 'system']
        },
        'technique': {
            'high_priority': ['phishing', 'spear phishing', 'social engineering', 'ddos', 'dos', 'man-in-the-middle', 'mitm', 'brute force'],
            'medium_priority': ['attack', 'technique', 'method', 'tactic', 'procedure', 'campaign'],
            'low_priority': ['strategy', 'approach']
        },
        'actor': {
            'high_priority': ['apt', 'advanced persistent threat', 'threat actor', 'cybercriminal', 'hacker group', 'nation-state'],
            'medium_priority': ['group', 'actor', 'organization', 'team', 'gang'],
            'low_priority': ['attacker', 'adversary']
        },
        'incident': {
            'high_priority': ['breach', 'data breach', 'incident', 'intrusion', 'compromise', 'attack'],
            'medium_priority': ['alert', 'warning', 'advisory', 'report'],
            'low_priority': ['event', 'activity']
        }
    }
    
    # Calculate threat score with weighted indicators
    threat_score = 0
    category_scores = {}
    
    for category, priority_indicators in threat_indicators.items():
        category_score = 0
        for priority, indicators in priority_indicators.items():
            weight = {'high_priority': 3, 'medium_priority': 2, 'low_priority': 1}[priority]
            matches = sum(1 for indicator in indicators if indicator in text)
            category_score += matches * weight
        
        category_scores[category] = category_score
        threat_score += category_score
    
    # Determine if it's a threat report (threshold-based)
    is_threat = threat_score >= 2  # At least 2 points to be considered a threat
    
    if not is_threat:
        return {
            'is_threat_report': False,
            'main_object': '',
            'confidence': 0.1,
            'threat_score': threat_score
        }
    
    # Find the most prominent category
    best_category = max(category_scores.items(), key=lambda x: x[1])
    category_name, category_score = best_category
    
    # Extract specific object name with improved logic
    main_object = extract_specific_object(text, category_name, title)
    
    # Calculate confidence based on score and category strength
    confidence = min(threat_score / 5, 1.0)  # Normalize to 0-1 range
    
    return {
        'is_threat_report': True,
        'main_object': f"{category_name.title()}: {main_object}",
        'confidence': confidence,
        'threat_score': threat_score,
        'category_scores': category_scores
    }


def extract_specific_object(text: str, category: str, title: str) -> str:
    """
    Extract specific object name based on category and context.
    """
    # Common patterns for each category
    patterns = {
        'malware': [
            r'(\w+)\s+(ransomware|trojan|virus|backdoor|rootkit|worm|botnet)',
            r'(ransomware|trojan|virus|backdoor|rootkit|worm|botnet)\s+(\w+)',
            r'(\w+)\s+(malware|malicious)',
        ],
        'vulnerability': [
            r'(cve-\d{4}-\d+)',
            r'(\w+)\s+(vulnerability|exploit|flaw)',
            r'(zero-day|zero day)\s+(\w+)',
        ],
        'tool': [
            r'(cobalt strike|metasploit|nmap|wireshark|burp suite)',
            r'(fortinet|fortigate|fortisandbox|forticnapp)',
            r'(\w+)\s+(tool|framework|software)',
        ],
        'technique': [
            r'(phishing|spear phishing|social engineering|ddos|dos|man-in-the-middle|mitm)',
            r'(\w+)\s+(attack|technique|method)',
        ],
        'actor': [
            r'(apt\d+|apt-\d+)',
            r'(\w+)\s+(group|actor|organization)',
            r'(threat actor|cybercriminal|hacker group)',
        ],
        'incident': [
            r'(\w+)\s+(breach|incident|intrusion|compromise)',
            r'(data breach|security incident)',
        ]
    }
    
    import re
    
    # Try to extract from title first (more likely to contain specific names)
    title_lower = title.lower()
    
    if category in patterns:
        for pattern in patterns[category]:
            match = re.search(pattern, title_lower)
            if match:
                # Extract the most specific part
                groups = match.groups()
                if len(groups) == 2:
                    # Return the more specific part (usually the first group)
                    return groups[0].title()
                else:
                    return groups[0].title()
    
    # Fallback: extract from text
    if category in patterns:
        for pattern in patterns[category]:
            match = re.search(pattern, text)
            if match:
                groups = match.groups()
                if len(groups) == 2:
                    return groups[0].title()
                else:
                    return groups[0].title()
    
    # Final fallback: return category name
    return category.title()


def process_data(data: List[Dict[str, Any]], model_info: Dict = None) -> List[Dict[str, Any]]:
    """
    Process all articles using enhanced rule-based classification for speed and accuracy.
    """
    print(f"🔍 Processing {len(data)} articles with enhanced rule-based classification...")
    
    results = []
    threat_reports = 0
    non_threat_reports = 0
    
    for i, item in enumerate(data):
        print(f"Processing {i+1}/{len(data)}: {item.get('title', 'Unknown')[:50]}...")
        
        title = item.get('title', '')
        link = item.get('link', '')
        content = item.get('content', '')
        
        # Use rule-based classification only
        classification = classify_with_rules(title, content)
        
        if classification["is_threat_report"]:
            threat_reports += 1
        else:
            non_threat_reports += 1
        
        # Create result object with detailed information
        result = {
            "title": title,
            "link": link,
            "is_threat_report": classification["is_threat_report"],
            "main_object": classification["main_object"],
            "confidence": classification.get("confidence", 0.5),
            "classification_method": "rules",
            "threat_score": classification.get("threat_score", 0),
            "category_scores": classification.get("category_scores", {})
        }
        
        results.append(result)
        
        # Print progress every 25 items for more frequent updates
        if (i + 1) % 25 == 0:
            print(f"  Processed {i+1}/{len(data)} articles")
            print(f"    Threat reports: {threat_reports}, Non-threat: {non_threat_reports}")
        
        # Memory cleanup every 100 items
        if (i + 1) % 100 == 0:
            gc.collect()
    
    print(f"\n📊 Classification Summary:")
    print(f"   - Threat reports: {threat_reports}")
    print(f"   - Non-threat reports: {non_threat_reports}")
    print(f"   - Threat percentage: {(threat_reports/len(data)*100):.1f}%")
    
    return results


def save_results(results: List[Dict[str, Any]], output_file: str = None):
    """
    Save classification results to JSON file with automatic directory creation.
    """
    try:
        # Generate output filename if not provided
        if output_file is None:
            timestamp = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
            output_file = f"data/topic-classification/rule_base_annotated_data_topic_classification_{timestamp}.json"
        
        # Create directory if it doesn't exist
        output_path = Path(output_file)
        output_path.parent.mkdir(parents=True, exist_ok=True)
        
        # Convert to absolute path to avoid relative path issues
        absolute_path = output_path.resolve()
        
        print(f"💾 Saving to: {absolute_path}")
        
        with open(absolute_path, 'w', encoding='utf-8') as f:
            json.dump(results, f, ensure_ascii=False, indent=2)
        
        print(f"✅ Successfully saved results to {output_file}")
        
        # Print detailed statistics
        threat_reports = sum(1 for r in results if r['is_threat_report'])
        non_threat_reports = len(results) - threat_reports
        
        print(f"\n📊 CLASSIFICATION STATISTICS:")
        print(f"Total articles: {len(results)}")
        print(f"Threat reports: {threat_reports}")
        print(f"Non-threat reports: {non_threat_reports}")
        print(f"Threat report percentage: {(threat_reports/len(results)*100):.1f}%")
        
        # Calculate average confidence and threat scores
        threat_results = [r for r in results if r['is_threat_report']]
        if threat_results:
            avg_confidence = sum(r.get('confidence', 0) for r in threat_results) / len(threat_results)
            avg_threat_score = sum(r.get('threat_score', 0) for r in threat_results) / len(threat_results)
            print(f"Average confidence: {avg_confidence:.2f}")
            print(f"Average threat score: {avg_threat_score:.2f}")
        
        # Show category distribution
        category_counts = {}
        for r in threat_results:
            if 'main_object' in r and r['main_object']:
                category = r['main_object'].split(':')[0] if ':' in r['main_object'] else 'Unknown'
                category_counts[category] = category_counts.get(category, 0) + 1
        
        if category_counts:
            print(f"\n📈 CATEGORY DISTRIBUTION:")
            for category, count in sorted(category_counts.items(), key=lambda x: x[1], reverse=True):
                print(f"  {category}: {count} reports")
        
        # Show some examples of threat reports
        threat_examples = threat_results[:5]
        if threat_examples:
            print(f"\n🔍 SAMPLE THREAT REPORTS:")
            for i, example in enumerate(threat_examples, 1):
                print(f"  {i}. {example['title'][:60]}...")
                print(f"     Main object: {example['main_object']}")
                print(f"     Confidence: {example.get('confidence', 'N/A'):.2f}")
                print(f"     Threat score: {example.get('threat_score', 'N/A')}")
        
    except Exception as e:
        print(f"❌ Error saving results: {e}")
        print(f"   Attempted path: {output_file}")
        print(f"   Current working directory: {os.getcwd()}")


def main():
    """
    Main function to run the classification pipeline using rule-based classification.
    """
    print("🔍 THREAT INTELLIGENCE CLASSIFICATION WITH ENHANCED RULES")
    print("="*60)
    
    # Input file path - try multiple locations
    input_files = [
        "data/raw/merged_threat_intelligence.json",
        "data/processed/merged_threat_intelligence.json"
    ]
    
    input_file = None
    for file_path in input_files:
        if os.path.exists(file_path):
            input_file = file_path
            break
    
    if not input_file:
        print(f"❌ Input file not found in any of these locations:")
        for file_path in input_files:
            print(f"   - {file_path}")
        return
    
    # Load data
    data = load_data(input_file)
    if not data:
        return
    
    # Process data using rule-based classification only
    print("🚀 Using enhanced rule-based classification for speed and accuracy...")
    results = process_data(data)
    
    # Save results
    save_results(results)
    
    print("\n✅ Classification completed successfully!")


if __name__ == "__main__":
    main() 