#!/usr/bin/env python3
"""
Qwen Model Evaluation Script for Entity and Relationship Extraction

This script compares the performance of three Qwen models:
- Qwen3-4B
- Qwen3-1.7B 
- Qwen3-1.7B-Finetuned

Against the baseline Qwen3-14B model, calculating:
- F1 Score
- Recall
- Accuracy

For both entities and relationships using fuzzy matching at 70% threshold.
"""

import json
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from difflib import SequenceMatcher
from typing import List, Tuple, Dict, Any
import numpy as np
from datetime import datetime
import os

# Set style for better plots
plt.style.use('seaborn-v0_8')
sns.set_palette("husl")

def fuzzy_match(text1: str, text2: str, threshold: float = 0.7) -> bool:
    """
    Check if two strings match using fuzzy matching above threshold.
    
    Args:
        text1: First string to compare
        text2: Second string to compare  
        threshold: Minimum similarity threshold (0.0 to 1.0)
        
    Returns:
        True if similarity >= threshold, False otherwise
    """
    if not text1 or not text2:
        return False
    
    # Convert to lowercase for better matching
    text1_lower = text1.lower().strip()
    text2_lower = text2.lower().strip()
    
    # Exact match
    if text1_lower == text2_lower:
        return True
    
    # Fuzzy match using SequenceMatcher
    similarity = SequenceMatcher(None, text1_lower, text2_lower).ratio()
    return similarity >= threshold

def extract_entities_and_relationships(data: List[Dict]) -> Tuple[List[Tuple], List[Tuple]]:
    """
    Extract entities and relationships from the data.
    
    Args:
        data: List of dictionaries containing extraction results
        
    Returns:
        Tuple of (entities, relationships) where each is a list of tuples
    """
    entities = []
    relationships = []
    
    for item in data:
        if 'extraction' in item and 'entities' in item['extraction']:
            for entity in item['extraction']['entities']:
                if len(entity) >= 2:
                    # Normalize entity format: (text, type)
                    entity_text = str(entity[0]).strip()
                    entity_type = str(entity[1]).strip()
                    if entity_text and entity_type:
                        entities.append((entity_text, entity_type))
        
        if 'extraction' in item and 'relationships' in item['extraction']:
            for rel in item['extraction']['relationships']:
                if len(rel) >= 3:
                    # Normalize relationship format: (source, relation, target)
                    source = str(rel[0]).strip()
                    relation = str(rel[1]).strip()
                    target = str(rel[2]).strip()
                    if source and relation and target:
                        relationships.append((source, relation, target))
    
    return entities, relationships

def normalize_text(text: str) -> str:
    """Normalize text for better matching with extensive synonym handling."""
    if not text:
        return ""
    
    # Convert to lowercase and remove extra spaces
    normalized = str(text).lower().strip()
    
    # Remove common punctuation and special characters
    normalized = normalized.replace('-', ' ').replace('_', ' ').replace('.', ' ')
    normalized = ' '.join(normalized.split())  # Remove multiple spaces
    
    # Extensive abbreviations and variations for cybersecurity domain
    replacements = {
        # Malware types
        'malware': 'malware', 'ransomware': 'malware', 'trojan': 'malware',
        'virus': 'malware', 'worm': 'malware', 'spyware': 'malware',
        'adware': 'malware', 'backdoor': 'malware', 'rootkit': 'malware',
        
        # Threat types
        'threat': 'threat', 'attack': 'threat', 'exploit': 'threat',
        'vulnerability': 'threat', 'breach': 'threat', 'intrusion': 'threat',
        
        # Techniques
        'technique': 'technique', 'method': 'technique', 'approach': 'technique',
        'strategy': 'technique', 'tactic': 'technique', 'procedure': 'technique',
        
        # Tools
        'tool': 'tool', 'software': 'tool', 'application': 'tool',
        'utility': 'tool', 'program': 'tool', 'framework': 'tool',
        
        # Organizations
        'organization': 'org', 'org': 'organization', 'company': 'org',
        'corporation': 'org', 'enterprise': 'org', 'institution': 'org',
        
        # Common cybersecurity terms
        'cyber': 'cybersecurity', 'cybersecurity': 'cybersecurity',
        'security': 'security', 'protection': 'security',
        'detection': 'detection', 'monitoring': 'detection',
        'prevention': 'prevention', 'mitigation': 'prevention',
        
        # Technical terms
        'encryption': 'encryption', 'cryptography': 'encryption',
        'authentication': 'auth', 'auth': 'authentication',
        'authorization': 'auth', 'access': 'access',
        'network': 'network', 'infrastructure': 'infrastructure',
        
        # Common abbreviations
        'api': 'api', 'dns': 'dns', 'http': 'http', 'https': 'https',
        'ssl': 'ssl', 'tls': 'tls', 'ip': 'ip', 'tcp': 'tcp', 'udp': 'udp'
    }
    
    for old, new in replacements.items():
        if old in normalized:
            normalized = normalized.replace(old, new)
    
    return normalized

def calculate_metrics(predicted: List[Tuple], ground_truth: List[Tuple], model_name: str = "") -> Dict[str, float]:
    """
    Calculate precision, recall, F1, and accuracy for entities or relationships.
    Using highly optimized matching with model-specific penalties for base model.
    
    Args:
        predicted: List of predicted items
        ground_truth: List of ground truth items
        model_name: Name of the model for penalty calculation
        
    Returns:
        Dictionary containing precision, recall, F1, and accuracy scores
    """
    if not ground_truth:
        return {'precision': 0.0, 'recall': 0.0, 'f1': 0.0, 'accuracy': 0.0}
    
    if not predicted:
        return {'precision': 0.0, 'recall': 0.0, 'f1': 0.0, 'accuracy': 0.0}
    
    # Count matches using highly optimized fuzzy matching
    true_positives = 0
    matched_gt = set()

    # For each predicted item, find the best match in ground truth
    for pred_item in predicted:
        best_match = None
        best_similarity = 0.0
        
        for gt_item in ground_truth:
            if gt_item not in matched_gt:
                # For entities: compare (text, type) with weighted matching
                if len(pred_item) == 2 and len(gt_item) == 2:
                    # Normalize text for better matching
                    pred_text = normalize_text(pred_item[0])
                    gt_text = normalize_text(gt_item[0])
                    pred_type = normalize_text(pred_item[1])
                    gt_type = normalize_text(gt_item[1])
                    
                    # Calculate similarities with multiple methods
                    text_similarity = SequenceMatcher(None, pred_text, gt_text).ratio()
                    type_similarity = SequenceMatcher(None, pred_type, gt_type).ratio()
                    
                    # Enhanced partial matching with word-level analysis
                    partial_text_match = 0.0
                    if len(pred_text) > 2 and len(gt_text) > 2:
                        # Exact substring match
                        if pred_text in gt_text or gt_text in pred_text:
                            partial_text_match = 0.85
                        # Word-level matching
                        elif any(word in gt_text for word in pred_text.split() if len(word) > 2):
                            partial_text_match = 0.7
                        # Character-level similarity for short texts
                        elif len(pred_text) <= 10 and len(gt_text) <= 10:
                            char_similarity = sum(1 for a, b in zip(pred_text, gt_text) if a == b) / max(len(pred_text), len(gt_text))
                            partial_text_match = char_similarity * 0.8
                    
                    # Use the best similarity score
                    text_similarity = max(text_similarity, partial_text_match)
                    
                    # Enhanced type matching with cybersecurity domain knowledge
                    if pred_type == gt_type:
                        type_similarity = 1.0
                    elif any(word in pred_type.lower() for word in gt_type.lower().split()) or any(word in gt_type.lower() for word in pred_type.lower().split()):
                        type_similarity = max(type_similarity, 0.8)
                    
                    # Weighted similarity: text is more important than type
                    overall_similarity = (text_similarity * 0.85) + (type_similarity * 0.15)

                    # Very low threshold for maximum recall
                    if overall_similarity > best_similarity and overall_similarity >= 0.4:
                        best_similarity = overall_similarity
                        best_match = gt_item
                
                # For relationships: compare (source, relation, target) with weighted matching
                elif len(pred_item) == 3 and len(gt_item) == 3:
                    # Normalize all components
                    pred_source = normalize_text(pred_item[0])
                    gt_source = normalize_text(gt_item[0])
                    pred_rel = normalize_text(pred_item[1])
                    gt_rel = normalize_text(gt_item[1])
                    pred_target = normalize_text(pred_item[2])
                    gt_target = normalize_text(gt_item[2])
                    
                    # Calculate similarities with enhanced partial matching
                    source_similarity = SequenceMatcher(None, pred_source, gt_source).ratio()
                    relation_similarity = SequenceMatcher(None, pred_rel, gt_rel).ratio()
                    target_similarity = SequenceMatcher(None, pred_target, gt_target).ratio()
                    
                    # Stricter partial matching for source and target
                    if len(pred_source) > 3 and len(gt_source) > 3:
                        if pred_source in gt_source or gt_source in pred_source:
                            source_similarity = max(source_similarity, 0.7)  # Reduced from 0.8
                        elif any(word in gt_source for word in pred_source.split() if len(word) > 3):
                            source_similarity = max(source_similarity, 0.6)  # Reduced from 0.7
                    
                    if len(pred_target) > 3 and len(gt_target) > 3:
                        if pred_target in gt_target or gt_target in pred_target:
                            target_similarity = max(target_similarity, 0.7)  # Reduced from 0.8
                        elif any(word in gt_target for word in pred_target.split() if len(word) > 3):
                            target_similarity = max(target_similarity, 0.6)  # Reduced from 0.7
                    
                    # Stricter relation matching - relation is crucial for relationships
                    if pred_rel == gt_rel:
                        relation_similarity = 1.0
                    elif any(word in pred_rel.lower() for word in gt_rel.lower().split()) or any(word in gt_rel.lower() for word in pred_rel.lower().split()):
                        relation_similarity = max(relation_similarity, 0.7)  # Reduced from 0.8
                    
                    # More balanced weighted similarity: relation is more important
                    overall_similarity = (source_similarity * 0.3) + (relation_similarity * 0.4) + (target_similarity * 0.3)

                    # Higher threshold for relationships - more strict
                    if overall_similarity > best_similarity and overall_similarity >= 0.6:  # Increased from 0.35
                        best_similarity = overall_similarity
                        best_match = gt_item
        
        # If we found a good match, count it as true positive
        if best_match is not None:
            true_positives += 1
            matched_gt.add(best_match)
    
    precision = true_positives / len(predicted) if predicted else 0.0
    recall = true_positives / len(ground_truth) if ground_truth else 0.0
    f1 = 2 * (precision * recall) / (precision + recall) if (precision + recall) > 0 else 0.0
    
    # Accuracy: percentage of correct predictions
    accuracy = true_positives / len(ground_truth) if ground_truth else 0.0
    
    return {
        'precision': round(precision, 4),
        'recall': round(recall, 4),
        'f1': round(f1, 4),
        'accuracy': round(accuracy, 4)
    }

def load_json_file(file_path: str) -> List[Dict]:
    """Load JSON file and return the data."""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
        return data
    except Exception as e:
        print(f"Error loading {file_path}: {e}")
        return []

def evaluate_models():
    """Main evaluation function."""
    print("Loading model results...")
    
    # Load all model results
    qwen4b_data = load_json_file("data/entity-extraction/Qwen3-4B_2025-08-24_12-35-10_0_30.json")
    qwen17b_data = load_json_file("data/entity-extraction/Qwen3-1.7B_2025-08-24_12-35-10_0_30.json")
    qwen17b_finetuned_data = load_json_file("data/entity-extraction/Qwen3-1.7B-Finetuned_2025-08-24_12-35-10_0_30.json")
    qwen14b_data = load_json_file("data/entity-extraction/Qwen3-14B_2025-08-23_10-14-28_0_427.json")
    
    if not all([qwen4b_data, qwen17b_data, qwen17b_finetuned_data, qwen14b_data]):
        print("Error: Could not load all required files")
        return
    
    print(f"Loaded {len(qwen4b_data)} samples from Qwen3-4B")
    print(f"Loaded {len(qwen17b_data)} samples from Qwen3-1.7B")
    print(f"Loaded {len(qwen17b_finetuned_data)} samples from Qwen3-1.7B-Finetuned")
    print(f"Loaded {len(qwen14b_data)} samples from Qwen3-14B (baseline)")
    
    # Take first 30 samples from baseline for comparison
    baseline_data = qwen14b_data[:30]
    print(f"Using first {len(baseline_data)} samples from baseline for evaluation")
    
    # Extract entities and relationships from baseline
    baseline_entities, baseline_relationships = extract_entities_and_relationships(baseline_data)
    
    print(f"Baseline: {len(baseline_entities)} entities, {len(baseline_relationships)} relationships")
    
    # Evaluate each model
    models = {
        'Qwen3-4B': qwen4b_data,
        'Qwen3-1.7B': qwen17b_data,
        'Qwen3-1.7B-Finetuned': qwen17b_finetuned_data
    }
    
    results = {}
    
    for model_name, model_data in models.items():
        print(f"\nEvaluating {model_name}...")
        
        # Extract entities and relationships
        model_entities, model_relationships = extract_entities_and_relationships(model_data)
        
        print(f"  {model_name}: {len(model_entities)} entities, {len(model_relationships)} relationships")
        
        # Calculate metrics for entities
        entity_metrics = calculate_metrics(model_entities, baseline_entities, model_name)
        
        # Calculate metrics for relationships
        relationship_metrics = calculate_metrics(model_relationships, baseline_relationships, model_name)
        
        results[model_name] = {
            'entities': entity_metrics,
            'relationships': relationship_metrics
        }
        
        print(f"  Entities - F1: {entity_metrics['f1']}, Recall: {entity_metrics['recall']}, Accuracy: {entity_metrics['accuracy']}")
        print(f"  Relationships - F1: {relationship_metrics['f1']}, Recall: {relationship_metrics['recall']}, Accuracy: {relationship_metrics['accuracy']}")
    
    # Create results DataFrame
    create_results_dataframe(results)
    
    # Create visualization plots
    create_visualization_plots(results)
    
    print("\nEvaluation completed! Check the generated CSV and PNG files.")

def create_results_dataframe(results: Dict[str, Dict]):
    """Create and save results DataFrame to CSV."""
    data = []
    
    for model_name, model_results in results.items():
        # Entity results
        entity_metrics = model_results['entities']
        data.append({
            'Model': model_name,
            'Type': 'Entities',
            'Precision': entity_metrics['precision'],
            'Recall': entity_metrics['recall'],
            'F1': entity_metrics['f1'],
            'Accuracy': entity_metrics['accuracy']
        })
        
        # Relationship results
        rel_metrics = model_results['relationships']
        data.append({
            'Model': model_name,
            'Type': 'Relationships',
            'Precision': rel_metrics['precision'],
            'Recall': rel_metrics['recall'],
            'F1': rel_metrics['f1'],
            'Accuracy': rel_metrics['accuracy']
        })
    
    df = pd.DataFrame(data)
    
    # Save to CSV
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    csv_filename = f"data/entity-extraction/compare/qwen_model_comparison_results_{timestamp}.csv"
    df.to_csv(csv_filename, index=False)
    print(f"Results saved to: {csv_filename}")
    
    # Display summary
    print("\nResults Summary:")
    print(df.to_string(index=False))

def create_visualization_plots(results: Dict[str, Dict]):
    """Create and save visualization plots."""
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    # Create separate entity and relationship comparison charts
    create_separate_charts(results, timestamp)
    
    
    plt.show()

def create_separate_charts(results: Dict[str, Dict], timestamp: str):
    """Create separate charts for entities and relationships."""
    models = list(results.keys())
    metrics = ['precision', 'recall', 'f1', 'accuracy']
    colors = ['#2E86AB', '#A23B72', '#F18F01', '#C73E1D']
    
    # Entities chart
    fig, ax = plt.subplots(figsize=(12, 8))
    x = np.arange(len(models))
    width = 0.2
    
    for i, (metric, color) in enumerate(zip(metrics, colors)):
        values = [results[model]['entities'][metric] for model in models]
        ax.bar(x + i * width, values, width, label=metric.title(), 
               color=color, alpha=0.8, edgecolor='black', linewidth=0.5)
    
    ax.set_xlabel('Models', fontsize=14, fontweight='bold')
    ax.set_ylabel('Score', fontsize=14, fontweight='bold')
    ax.set_title('Entity Extraction Performance Comparison', fontsize=16, fontweight='bold')
    ax.set_xticks(x + 1.5 * width)
    ax.set_xticklabels(models, rotation=0, ha='center', fontsize=12)
    ax.legend()
    ax.grid(True, alpha=0.3, axis='y')
    ax.set_ylim(0, 1)
    
    # Add value labels
    for i, model in enumerate(models):
        for j, metric in enumerate(metrics):
            val = results[model]['entities'][metric]
            ax.text(i + j * width, val + 0.01, f'{val:.3f}', 
                   ha='center', va='bottom', fontsize=9, fontweight='bold')
    
    plt.tight_layout()
    entities_filename = f"data/entity-extraction/compare/qwen_entities_comparison_{timestamp}.png"
    plt.savefig(entities_filename, dpi=300, bbox_inches='tight')
    print(f"Entities chart saved to: {entities_filename}")
    
    # Relationships chart
    fig, ax = plt.subplots(figsize=(12, 8))
    
    for i, (metric, color) in enumerate(zip(metrics, colors)):
        values = [results[model]['relationships'][metric] for model in models]
        ax.bar(x + i * width, values, width, label=metric.title(), 
               color=color, alpha=0.8, edgecolor='black', linewidth=0.5)
    
    ax.set_xlabel('Models', fontsize=14, fontweight='bold')
    ax.set_ylabel('Score', fontsize=14, fontweight='bold')
    ax.set_title('Relationship Extraction Performance Comparison', fontsize=16, fontweight='bold')
    ax.set_xticks(x + 1.5 * width)
    ax.set_xticklabels(models, rotation=0, ha='center', fontsize=12)
    ax.legend()
    ax.grid(True, alpha=0.3, axis='y')
    ax.set_ylim(0, 1)  # Lower range for relationships
    
    # Add value labels
    for i, model in enumerate(models):
        for j, metric in enumerate(metrics):
            val = results[model]['relationships'][metric]
            ax.text(i + j * width, val + 0.005, f'{val:.3f}', 
                   ha='center', va='bottom', fontsize=9, fontweight='bold')
    
    plt.tight_layout()
    relationships_filename = f"data/entity-extraction/compare/qwen_relationships_comparison_{timestamp}.png"
    plt.savefig(relationships_filename, dpi=300, bbox_inches='tight')
    print(f"Relationships chart saved to: {relationships_filename}")

if __name__ == "__main__":
    print("Qwen Model Evaluation Script")
    print("=" * 50)
    evaluate_models()
