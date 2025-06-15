"""
Dataset loader module for LLM-TIKG integration.
Handles loading and preprocessing of the LLM-TIKG dataset.
"""

import json
from typing import Dict, List, Optional
from pathlib import Path
import logging

logger = logging.getLogger(__name__)

class DatasetLoader:
    def __init__(self, data_path: str):
        """
        Initialize the dataset loader.
        
        Args:
            data_path (str): Path to the dataset directory
        """
        self.data_path = Path(data_path)
        
    def load_dataset(self, split: str = "train") -> List[Dict]:
        """
        Load dataset from JSON/JSONL files.
        
        Args:
            split (str): Dataset split to load (train/val/test)
            
        Returns:
            List[Dict]: List of dataset entries
        """
        try:
            file_path = self.data_path / f"{split}.jsonl"
            data = []
            with open(file_path, 'r', encoding='utf-8') as f:
                for line in f:
                    data.append(json.loads(line))
            return data
        except Exception as e:
            logger.error(f"Error loading dataset: {str(e)}")
            raise
            
    def preprocess_data(self, data: List[Dict]) -> List[Dict]:
        """
        Preprocess the loaded data for model training.
        
        Args:
            data (List[Dict]): Raw dataset entries
            
        Returns:
            List[Dict]: Preprocessed dataset entries
        """
        processed_data = []
        for entry in data:
            processed_entry = {
                "instruction": entry["instruction"],
                "input": entry.get("input", ""),
                "output": entry["output"]
            }
            processed_data.append(processed_entry)
        return processed_data 