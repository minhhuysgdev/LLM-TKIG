#!/usr/bin/env python3
"""
Script to create entity extraction instruction file from merged entity extraction results.

This script:
1. Reads the merged entity extraction file
2. Converts each record to instruction format:
   - instruction: content field
   - input: null
   - output: raw_output field
3. Saves the result to entity_extraction_instruction.json
"""

import json
import os
from pathlib import Path
import logging

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

def load_merged_data(input_file: str) -> list:
    """
    Load the merged entity extraction data.
    
    Args:
        input_file: Path to the merged entity extraction file
        
    Returns:
        List of records from the JSON file
    """
    try:
        with open(input_file, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        logger.info(f"Loaded {len(data)} records from {input_file}")
        return data
        
    except Exception as e:
        logger.error(f"Error loading {input_file}: {e}")
        raise

def convert_to_instruction_format(records: list) -> list:
    """
    Convert records to instruction format.
    
    Args:
        records: List of entity extraction records
        
    Returns:
        List of instruction format records
    """
    instruction_records = []
    processed_count = 0
    skipped_count = 0
    
    for record in records:
        try:
            # Check if record has required fields
            if not isinstance(record, dict):
                skipped_count += 1
                continue
                
            if 'content' not in record or 'extraction' not in record:
                skipped_count += 1
                continue
                
            extraction = record['extraction']
            if not isinstance(extraction, dict) or 'raw_output' not in extraction:
                skipped_count += 1
                continue
            
            # Create instruction format record
            instruction_record = {
                "instruction": record['content'],
                "input": None,
                "output": extraction['raw_output']
            }
            
            instruction_records.append(instruction_record)
            processed_count += 1
            
        except Exception as e:
            logger.warning(f"Error processing record: {e}")
            skipped_count += 1
            continue
    
    logger.info(f"Successfully processed {processed_count} records")
    if skipped_count > 0:
        logger.info(f"Skipped {skipped_count} records due to missing fields")
    
    return instruction_records

def save_instruction_file(instructions: list, output_file: str) -> None:
    """
    Save instruction records to JSON file.
    
    Args:
        instructions: List of instruction format records
        output_file: Path to the output file
    """
    try:
        # Create output directory if it doesn't exist
        output_dir = os.path.dirname(output_file)
        if output_dir and not os.path.exists(output_dir):
            os.makedirs(output_dir)
            logger.info(f"Created output directory: {output_dir}")
        
        # Save to file
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(instructions, f, indent=2, ensure_ascii=False)
        
        logger.info(f"Successfully saved {len(instructions)} instructions to {output_file}")
        
    except Exception as e:
        logger.error(f"Error saving instruction file: {e}")
        raise

def main():
    """Main function to execute the conversion process."""
    # Define paths
    current_dir = Path(__file__).parent
    input_file = current_dir / "data" / "entity-extraction" / "Qwen2.5-1.5B-Instruct-entity-extraction.json"
    output_file = current_dir / "data" / "entity-extraction" / "entity_extraction_instruction.json"
    
    # Check if input file exists
    if not input_file.exists():
        logger.error(f"Input file does not exist: {input_file}")
        return
    
    logger.info(f"Starting conversion process...")
    logger.info(f"Input file: {input_file}")
    logger.info(f"Output file: {output_file}")
    
    try:
        # Load merged data
        records = load_merged_data(str(input_file))
        
        # Convert to instruction format
        instructions = convert_to_instruction_format(records)
        
        if not instructions:
            logger.error("No valid instructions created")
            return
        
        # Save instruction file
        save_instruction_file(instructions, str(output_file))
        
        # Print summary
        print("\n" + "="*60)
        print("CONVERSION SUMMARY")
        print("="*60)
        print(f"Input records: {len(records)}")
        print(f"Valid instructions created: {len(instructions)}")
        print(f"Output file: {output_file}")
        print("="*60)
        
        logger.info("Conversion process completed successfully!")
        
    except Exception as e:
        logger.error(f"Conversion process failed: {e}")
        raise

if __name__ == "__main__":
    main()

