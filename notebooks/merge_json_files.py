#!/usr/bin/env python3
"""
Script to merge two JSON files from the raw directory with specific formatting rules.
"""

import json
import re
from pathlib import Path
from urllib.parse import urlparse
from typing import List, Dict, Any

def parse_security_title_from_url(url: str) -> str:
    """
    Parse title from security.com URL.
    Example: "security.com/threat-intelligence/espionage-asia-governments" 
    -> "espionage asia governments"
    """
    try:
        # Extract the path part after the domain
        parsed_url = urlparse(url)
        path = parsed_url.path
        
        # Remove leading slash and split by '/'
        path_parts = path.strip('/').split('/')
        
        # Find the last part that contains the title
        if len(path_parts) >= 2:
            # Get the last part (e.g., "espionage-asia-governments")
            title_part = path_parts[-1]
            
            # Replace hyphens with spaces
            title = title_part.replace('-', ' ')
            
            return title
        else:
            return "Unknown Title"
            
    except Exception as e:
        print(f"Error parsing title from URL {url}: {e}")
        return "Unknown Title"

def extract_content_text(content: Any) -> str:
    """
    Extract text content from various content formats.
    """
    if isinstance(content, list):
        # Join all paragraphs with spaces
        return ' '.join([str(item) for item in content if item])
    elif isinstance(content, str):
        return content
    else:
        return str(content) if content else ""

def process_record(record: Dict[str, Any]) -> Dict[str, str]:
    """
    Process a single record according to the specified rules.
    """
    url = record.get('url', '')
    title = record.get('title', '')
    content = record.get('content', '')
    
    # Extract content text
    content_text = extract_content_text(content)
    
    # Apply parsing rules
    if 'fortinet.com' in url:
        # Parse normally - use original title
        final_title = title
    elif 'security.com' in url or title == 'Main menu':
        # Parse title from URL
        final_title = parse_security_title_from_url(url)
    else:
        # Use original title for other cases
        final_title = title
    
    return {
        "title": final_title,
        "content": content_text,
        "link": url
    }

def merge_json_files() -> List[Dict[str, str]]:
    """
    Merge the two JSON files from the raw directory.
    """
    raw_dir = Path('data/raw')
    
    # Find JSON files
    json_files = list(raw_dir.glob('threat_intelligence_multi_source_*.json'))
    
    if len(json_files) < 2:
        print(f"Found {len(json_files)} JSON files, need at least 2")
        return []
    
    print(f"Found {len(json_files)} JSON files to merge:")
    for file in json_files:
        print(f"  - {file.name}")
    
    all_records = []
    
    for file_path in json_files:
        print(f"\nProcessing {file_path.name}...")
        
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                data = json.load(f)
            
            print(f"  Loaded {len(data)} records")
            
            # Process each record
            for record in data:
                processed_record = process_record(record)
                
                # Only add records with valid content
                if processed_record['content'].strip():
                    all_records.append(processed_record)
            
            print(f"  Processed {len(data)} records")
            
        except Exception as e:
            print(f"  Error processing {file_path}: {e}")
            continue
    
    print(f"\nTotal processed records: {len(all_records)}")
    return all_records

def save_merged_data(records: List[Dict[str, str]], output_file: str = None):
    """
    Save merged data to JSON file.
    """
    if output_file is None:
        output_file = 'data/processed/merged_threat_intelligence.json'
    
    # Create output directory if it doesn't exist
    output_path = Path(output_file)
    output_path.parent.mkdir(parents=True, exist_ok=True)
    
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(records, f, indent=2, ensure_ascii=False)
    
    print(f"\n💾 Saved merged data to: {output_path}")
    print(f"📊 Total records: {len(records)}")

def main():
    """
    Main function to merge JSON files.
    """
    print("🔄 MERGING JSON FILES")
    print("="*50)
    
    # Merge the files
    merged_records = merge_json_files()
    
    if merged_records:
        # Save the merged data
        save_merged_data(merged_records)
        
        # Show some examples
        print("\n📋 SAMPLE RECORDS:")
        print("="*30)
        
        for i, record in enumerate(merged_records[:3]):
            print(f"\nRecord {i+1}:")
            print(f"  Title: {record['title'][:80]}...")
            print(f"  Link: {record['link']}")
            print(f"  Content length: {len(record['content'])} chars")
            print(f"  Content preview: {record['content'][:100]}...")
        
        if len(merged_records) > 3:
            print(f"\n... and {len(merged_records) - 3} more records")
        
        # Statistics
        print(f"\n📊 STATISTICS:")
        print("="*20)
        
        fortinet_count = sum(1 for r in merged_records if 'fortinet.com' in r['link'])
        security_count = sum(1 for r in merged_records if 'security.com' in r['link'])
        other_count = len(merged_records) - fortinet_count - security_count
        
        print(f"Fortinet records: {fortinet_count}")
        print(f"Security.com records: {security_count}")
        print(f"Other records: {other_count}")
        print(f"Total records: {len(merged_records)}")
        
    else:
        print("❌ No records to merge")

if __name__ == "__main__":
    main() 