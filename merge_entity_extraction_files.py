#!/usr/bin/env python3
"""
Script to merge all entity extraction result files from Qwen directory
into a single file while removing duplicate records.

This script:
1. Reads all JSON files from the entity_extraction_results_Qwen directory
2. Merges all records into a single list
3. Removes duplicate records based on title and link
4. Saves the merged data to a single output file
"""

import json
import os
import glob
from pathlib import Path
from typing import List, Dict, Any, Set
import logging
from datetime import datetime

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

def load_json_file(file_path: str) -> List[Dict[str, Any]]:
    """
    Load and parse a JSON file.
    
    Args:
        file_path: Path to the JSON file
        
    Returns:
        List of records from the JSON file
        
    Raises:
        Exception: If file cannot be loaded or parsed
    """
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        if not isinstance(data, list):
            logger.warning(f"File {file_path} does not contain a list, skipping")
            return []
            
        logger.info(f"Loaded {len(data)} records from {file_path}")
        return data
        
    except Exception as e:
        logger.error(f"Error loading {file_path}: {e}")
        return []

def get_unique_records(records: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
    """
    Remove duplicate records based on title and link.
    
    Args:
        records: List of all records
        
    Returns:
        List of unique records
    """
    seen = set()
    unique_records = []
    duplicates_count = 0
    
    for record in records:
        # Create a unique identifier based on title and link
        if isinstance(record, dict) and 'title' in record and 'link' in record:
            identifier = (record['title'], record['link'])
        else:
            # If record doesn't have expected structure, use the entire record as identifier
            identifier = str(record)
        
        if identifier not in seen:
            seen.add(identifier)
            unique_records.append(record)
        else:
            duplicates_count += 1
    
    logger.info(f"Removed {duplicates_count} duplicate records")
    logger.info(f"Kept {len(unique_records)} unique records")
    
    return unique_records

def merge_entity_extraction_files(input_dir: str, output_file: str) -> None:
    """
    Merge all entity extraction result files into a single file.
    
    Args:
        input_dir: Directory containing the entity extraction result files
        output_file: Path to the output merged file
    """
    # Get all JSON files in the input directory
    json_files = glob.glob(os.path.join(input_dir, "*.json"))
    
    if not json_files:
        logger.error(f"No JSON files found in {input_dir}")
        return
    
    logger.info(f"Found {len(json_files)} JSON files to merge")
    
    # Load all records from all files
    all_records = []
    total_files_processed = 0
    
    for file_path in sorted(json_files):
        file_name = os.path.basename(file_path)
        logger.info(f"Processing {file_name}...")
        
        records = load_json_file(file_path)
        if records:
            all_records.extend(records)
            total_files_processed += 1
    
    if not all_records:
        logger.error("No records found in any files")
        return
    
    logger.info(f"Total records loaded: {len(all_records)}")
    logger.info(f"Files successfully processed: {total_files_processed}")
    
    # Remove duplicates
    unique_records = get_unique_records(all_records)
    
    # Create output directory if it doesn't exist
    output_dir = os.path.dirname(output_file)
    if output_dir and not os.path.exists(output_dir):
        os.makedirs(output_dir)
        logger.info(f"Created output directory: {output_dir}")
    
    # Save merged data
    try:
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(unique_records, f, indent=2, ensure_ascii=False)
        
        logger.info(f"Successfully merged data to {output_file}")
        logger.info(f"Final record count: {len(unique_records)}")
        
        # Print summary statistics
        print("\n" + "="*60)
        print("MERGE SUMMARY")
        print("="*60)
        print(f"Input files processed: {total_files_processed}")
        print(f"Total records loaded: {len(all_records)}")
        print(f"Duplicate records removed: {len(all_records) - len(unique_records)}")
        print(f"Final unique records: {len(unique_records)}")
        print(f"Output file: {output_file}")
        print("="*60)
        
    except Exception as e:
        logger.error(f"Error saving merged file: {e}")
        raise

def main():
    """Main function to execute the merge process."""
    # Define paths
    current_dir = Path(__file__).parent
    input_directory = current_dir / "data" / "entity-extraction" / "entity_extraction_results_Qwen"
    output_file = current_dir / "data" / "entity-extraction" / "Qwen2.5-1.5B-Instruct-entity-extraction.json"
    
    # Check if input directory exists
    if not input_directory.exists():
        logger.error(f"Input directory does not exist: {input_directory}")
        return
    
    logger.info(f"Starting merge process...")
    logger.info(f"Input directory: {input_directory}")
    logger.info(f"Output file: {output_file}")
    
    try:
        merge_entity_extraction_files(str(input_directory), str(output_file))
        logger.info("Merge process completed successfully!")
        
    except Exception as e:
        logger.error(f"Merge process failed: {e}")
        raise

if __name__ == "__main__":
    main()

