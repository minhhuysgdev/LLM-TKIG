"""
Model trainer module for LLM-TIKG integration.
Handles model training and fine-tuning.
"""

from typing import Dict, Optional
import torch
from transformers import Trainer, TrainingArguments
from peft import get_peft_model, LoraConfig
import logging

logger = logging.getLogger(__name__)

class ModelTrainer:
    def __init__(self, model, config: Dict):
        """
        Initialize the model trainer.
        
        Args:
            model: Base model to train
            config (Dict): Training configuration
        """
        self.model = model
        self.config = config
        self._setup_lora()
        
    def _setup_lora(self):
        """Configure LoRA for efficient fine-tuning."""
        lora_config = LoraConfig(
            r=self.config.get("lora_r", 8),
            lora_alpha=self.config.get("lora_alpha", 32),
            target_modules=self.config.get("target_modules", ["q_proj", "v_proj"]),
            lora_dropout=self.config.get("lora_dropout", 0.05),
            bias="none",
            task_type="CAUSAL_LM"
        )
        self.model = get_peft_model(self.model, lora_config)
        
    def train(self, train_dataset, eval_dataset: Optional = None):
        """
        Train the model.
        
        Args:
            train_dataset: Training dataset
            eval_dataset: Optional evaluation dataset
        """
        training_args = TrainingArguments(
            output_dir=self.config["output_dir"],
            num_train_epochs=self.config.get("num_epochs", 3),
            per_device_train_batch_size=self.config.get("batch_size", 4),
            gradient_accumulation_steps=self.config.get("gradient_accumulation_steps", 4),
            learning_rate=self.config.get("learning_rate", 2e-4),
            fp16=self.config.get("fp16", True),
            logging_steps=self.config.get("logging_steps", 10),
            evaluation_strategy="steps" if eval_dataset else "no",
            eval_steps=self.config.get("eval_steps", 100) if eval_dataset else None,
            save_strategy="steps",
            save_steps=self.config.get("save_steps", 100),
            warmup_steps=self.config.get("warmup_steps", 100),
        )
        
        trainer = Trainer(
            model=self.model,
            args=training_args,
            train_dataset=train_dataset,
            eval_dataset=eval_dataset,
        )
        
        trainer.train()
        
        return trainer 