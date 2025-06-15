"""
Model configuration module for LLM-TIKG integration.
Handles model and training configuration management.
"""

from typing import Dict, Any, Optional
import yaml
from pathlib import Path
import logging

logger = logging.getLogger(__name__)

class ModelConfig:
    def __init__(self, config_path: str):
        """
        Initialize model configuration.
        
        Args:
            config_path (str): Path to configuration file
        """
        self.config_path = Path(config_path)
        self.config = self._load_config()
        
    def _load_config(self) -> Dict[str, Any]:
        """
        Load configuration from YAML file.
        
        Returns:
            Dict[str, Any]: Configuration dictionary
        """
        try:
            with open(self.config_path, 'r') as f:
                return yaml.safe_load(f)
        except Exception as e:
            logger.error(f"Error loading config: {str(e)}")
            raise
            
    def get_model_config(self) -> Dict[str, Any]:
        """Get model-specific configuration."""
        return self.config.get("model", {})
        
    def get_training_config(self) -> Dict[str, Any]:
        """Get training-specific configuration."""
        return self.config.get("training", {})
        
    def get_lora_config(self) -> Dict[str, Any]:
        """Get LoRA-specific configuration."""
        return self.config.get("lora", {})
        
    def get_dataset_config(self) -> Dict[str, Any]:
        """Get dataset-specific configuration."""
        return self.config.get("dataset", {})
        
    def update_config(self, updates: Dict[str, Any]):
        """
        Update configuration with new values.
        
        Args:
            updates (Dict[str, Any]): Configuration updates
        """
        def deep_update(d: Dict, u: Dict) -> Dict:
            for k, v in u.items():
                if isinstance(v, dict):
                    d[k] = deep_update(d.get(k, {}), v)
                else:
                    d[k] = v
            return d
            
        self.config = deep_update(self.config, updates)
        
    def save_config(self, path: Optional[str] = None):
        """
        Save current configuration to file.
        
        Args:
            path (Optional[str]): Path to save config, defaults to original path
        """
        save_path = Path(path) if path else self.config_path
        try:
            with open(save_path, 'w') as f:
                yaml.dump(self.config, f)
        except Exception as e:
            logger.error(f"Error saving config: {str(e)}")
            raise 