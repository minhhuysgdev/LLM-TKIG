"""
Helper utilities module for LLM-TIKG integration.
Provides common utility functions used across the project.
"""

import logging
import json
from typing import Dict, List, Any, Optional
from pathlib import Path
import yaml
import torch
import numpy as np
from datetime import datetime

logger = logging.getLogger(__name__)

def setup_logging(log_dir: str, level: int = logging.INFO):
    """
    Set up logging configuration.
    
    Args:
        log_dir (str): Directory to store log files
        level (int): Logging level
    """
    log_dir = Path(log_dir)
    log_dir.mkdir(parents=True, exist_ok=True)
    
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    log_file = log_dir / f"llm_tikg_{timestamp}.log"
    
    logging.basicConfig(
        level=level,
        format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
        handlers=[
            logging.FileHandler(log_file),
            logging.StreamHandler()
        ]
    )
    
def load_yaml_config(config_path: str) -> Dict[str, Any]:
    """
    Load configuration from YAML file.
    
    Args:
        config_path (str): Path to configuration file
        
    Returns:
        Dict[str, Any]: Configuration dictionary
    """
    try:
        with open(config_path, 'r') as f:
            return yaml.safe_load(f)
    except Exception as e:
        logger.error(f"Error loading config: {str(e)}")
        raise
        
def save_json(data: Any, file_path: str):
    """
    Save data to JSON file.
    
    Args:
        data (Any): Data to save
        file_path (str): Path to save file
    """
    try:
        with open(file_path, 'w') as f:
            json.dump(data, f, indent=2)
    except Exception as e:
        logger.error(f"Error saving JSON: {str(e)}")
        raise
        
def load_json(file_path: str) -> Any:
    """
    Load data from JSON file.
    
    Args:
        file_path (str): Path to JSON file
        
    Returns:
        Any: Loaded data
    """
    try:
        with open(file_path, 'r') as f:
            return json.load(f)
    except Exception as e:
        logger.error(f"Error loading JSON: {str(e)}")
        raise
        
def set_seed(seed: int):
    """
    Set random seed for reproducibility.
    
    Args:
        seed (int): Random seed
    """
    torch.manual_seed(seed)
    torch.cuda.manual_seed_all(seed)
    np.random.seed(seed)
    
def get_device() -> torch.device:
    """
    Get the appropriate device for model training.
    
    Returns:
        torch.device: Device to use
    """
    if torch.cuda.is_available():
        return torch.device("cuda")
    return torch.device("cpu")
    
def format_time(seconds: float) -> str:
    """
    Format time in seconds to human-readable string.
    
    Args:
        seconds (float): Time in seconds
        
    Returns:
        str: Formatted time string
    """
    hours = int(seconds // 3600)
    minutes = int((seconds % 3600) // 60)
    seconds = int(seconds % 60)
    return f"{hours:02d}:{minutes:02d}:{seconds:02d}" 