"""
Main pipeline module for LLM-TIKG integration.
Orchestrates the entire training and knowledge graph construction process.
"""

import logging
from pathlib import Path
from typing import Dict, Any

from data.loader import DatasetLoader
from data.collator import DataCollator
from data.augmentation import DataAugmentor
from model.trainer import ModelTrainer
from model.config import ModelConfig
from model.evaluation import ModelEvaluator
from graph.knowledge_graph import KnowledgeGraph
from graph.neo4j_connector import Neo4jConnector
from graph.post_process import GraphPostProcessor
from utils.helper import setup_logging, load_yaml_config, set_seed

logger = logging.getLogger(__name__)

class LLMTIKGPipeline:
    def __init__(self, config_path: str):
        """
        Initialize the LLM-TIKG pipeline.
        
        Args:
            config_path (str): Path to configuration file
        """
        self.config = load_yaml_config(config_path)
        self._setup_components()
        
    def _setup_components(self):
        """Set up pipeline components."""
        # Set random seed
        set_seed(self.config.get("seed", 42))
        
        # Initialize data components
        self.data_loader = DatasetLoader(self.config["data"]["path"])
        self.data_collator = DataCollator(
            tokenizer=self.config["model"]["tokenizer"],
            max_length=self.config["model"]["max_length"]
        )
        self.data_augmentor = DataAugmentor(self.config["data"]["augmentation"])
        
        # Initialize model components
        self.model_config = ModelConfig(self.config["model"]["config_path"])
        self.model_trainer = ModelTrainer(
            model=self.config["model"]["base_model"],
            config=self.model_config.get_training_config()
        )
        self.model_evaluator = ModelEvaluator(
            model=self.model_trainer.model,
            config=self.model_config.get_model_config()
        )
        
        # Initialize graph components
        self.neo4j_connector = Neo4jConnector(self.config["graph"]["config_path"])
        self.knowledge_graph = KnowledgeGraph(self.config["graph"])
        self.graph_processor = GraphPostProcessor(self.config["graph"])
        
    def run_training(self):
        """Run the training pipeline."""
        try:
            # Load and preprocess data
            train_data = self.data_loader.load_dataset("train")
            train_data = self.data_loader.preprocess_data(train_data)
            
            if self.config["data"]["augmentation"]["enabled"]:
                train_data = self.data_augmentor.augment_dataset(train_data)
                
            # Train model
            self.model_trainer.train(train_data)
            
            # Evaluate model
            eval_data = self.data_loader.load_dataset("val")
            eval_data = self.data_loader.preprocess_data(eval_data)
            metrics = self.model_evaluator.evaluate(eval_data)
            
            logger.info(f"Training completed. Evaluation metrics: {metrics}")
            
        except Exception as e:
            logger.error(f"Error in training pipeline: {str(e)}")
            raise
            
    def construct_knowledge_graph(self):
        """Construct the knowledge graph from model predictions."""
        try:
            # Load test data
            test_data = self.data_loader.load_dataset("test")
            test_data = self.data_loader.preprocess_data(test_data)
            
            # Generate predictions
            predictions = self.model_trainer.model.predict(test_data)
            
            # Create graph
            for pred in predictions:
                # Create entities
                source_id = self.knowledge_graph.create_entity(
                    entity_type=pred["source_type"],
                    properties=pred["source_properties"]
                )
                target_id = self.knowledge_graph.create_entity(
                    entity_type=pred["target_type"],
                    properties=pred["target_properties"]
                )
                
                # Create relationship
                self.knowledge_graph.create_relationship(
                    source_id=source_id,
                    target_id=target_id,
                    relationship_type=pred["relationship_type"],
                    properties=pred["relationship_properties"]
                )
                
            # Post-process graph
            self.graph_processor.merge_duplicate_entities()
            self.graph_processor.remove_isolated_nodes()
            self.graph_processor.calculate_centrality_metrics()
            
            # Validate graph
            stats = self.graph_processor.validate_graph_structure()
            logger.info(f"Knowledge graph construction completed. Stats: {stats}")
            
        except Exception as e:
            logger.error(f"Error in knowledge graph construction: {str(e)}")
            raise
            
    def run(self):
        """Run the complete pipeline."""
        try:
            logger.info("Starting LLM-TIKG pipeline")
            
            # Run training
            self.run_training()
            
            # Construct knowledge graph
            self.construct_knowledge_graph()
            
            logger.info("Pipeline completed successfully")
            
        except Exception as e:
            logger.error(f"Pipeline failed: {str(e)}")
            raise
        finally:
            # Clean up
            self.neo4j_connector.close()
            self.knowledge_graph.close()
            self.graph_processor.close()
            
if __name__ == "__main__":
    # Set up logging
    setup_logging("logs")
    
    # Run pipeline
    pipeline = LLMTIKGPipeline("config/default_config.yaml")
    pipeline.run() 