"""
Data collator module for LLM-TIKG integration.
Handles batching and padding of data for model training.
"""

from typing import Dict, List
import torch
from transformers import PreTrainedTokenizer

class DataCollator:
    def __init__(self, tokenizer: PreTrainedTokenizer, max_length: int = 512):
        """
        Initialize the data collator.
        
        Args:
            tokenizer (PreTrainedTokenizer): Tokenizer for text processing
            max_length (int): Maximum sequence length
        """
        self.tokenizer = tokenizer
        self.max_length = max_length
        
    def __call__(self, features: List[Dict]) -> Dict[str, torch.Tensor]:
        """
        Collate a batch of features.
        
        Args:
            features (List[Dict]): List of data features
            
        Returns:
            Dict[str, torch.Tensor]: Collated batch
        """
        batch = {
            "input_ids": [],
            "attention_mask": [],
            "labels": []
        }
        
        for feature in features:
            # Tokenize instruction and input
            instruction = feature["instruction"]
            input_text = feature.get("input", "")
            combined_text = f"{instruction}\n{input_text}"
            
            # Tokenize
            tokenized = self.tokenizer(
                combined_text,
                max_length=self.max_length,
                padding="max_length",
                truncation=True,
                return_tensors="pt"
            )
            
            # Add to batch
            batch["input_ids"].append(tokenized["input_ids"])
            batch["attention_mask"].append(tokenized["attention_mask"])
            
            # Tokenize labels
            labels = self.tokenizer(
                feature["output"],
                max_length=self.max_length,
                padding="max_length",
                truncation=True,
                return_tensors="pt"
            )
            batch["labels"].append(labels["input_ids"])
            
        # Stack tensors
        for key in batch:
            batch[key] = torch.stack(batch[key])
            
        return batch 