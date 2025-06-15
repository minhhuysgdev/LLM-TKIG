"""
Neo4j connector module for LLM-TIKG integration.
Handles Neo4j database connection and management.
"""

from typing import Dict, Any, Optional, List
from neo4j import GraphDatabase
import logging
from pathlib import Path
import yaml

logger = logging.getLogger(__name__)

class Neo4jConnector:
    def __init__(self, config_path: str):
        """
        Initialize Neo4j connector.
        
        Args:
            config_path (str): Path to Neo4j configuration file
        """
        self.config = self._load_config(config_path)
        self.driver = None
        self._connect()
        
    def _load_config(self, config_path: str) -> Dict[str, Any]:
        """
        Load Neo4j configuration from YAML file.
        
        Args:
            config_path (str): Path to configuration file
            
        Returns:
            Dict[str, Any]: Configuration dictionary
        """
        try:
            with open(config_path, 'r') as f:
                return yaml.safe_load(f)
        except Exception as e:
            logger.error(f"Error loading Neo4j config: {str(e)}")
            raise
            
    def _connect(self):
        """Establish connection to Neo4j database."""
        try:
            self.driver = GraphDatabase.driver(
                self.config["uri"],
                auth=(self.config["username"], self.config["password"])
            )
            # Test connection
            with self.driver.session() as session:
                session.run("RETURN 1")
        except Exception as e:
            logger.error(f"Error connecting to Neo4j: {str(e)}")
            raise
            
    def execute_query(self, query: str, parameters: Optional[Dict[str, Any]] = None) -> List[Dict[str, Any]]:
        """
        Execute a Cypher query.
        
        Args:
            query (str): Cypher query to execute
            parameters (Optional[Dict[str, Any]]): Query parameters
            
        Returns:
            List[Dict[str, Any]]: Query results
        """
        try:
            with self.driver.session() as session:
                result = session.run(query, parameters or {})
                return [dict(record) for record in result]
        except Exception as e:
            logger.error(f"Error executing query: {str(e)}")
            raise
            
    def create_constraints(self):
        """Create database constraints."""
        constraints = [
            "CREATE CONSTRAINT IF NOT EXISTS FOR (e:Entity) REQUIRE e.id IS UNIQUE",
            "CREATE CONSTRAINT IF NOT EXISTS FOR (r:Relationship) REQUIRE r.id IS UNIQUE"
        ]
        
        for constraint in constraints:
            try:
                self.execute_query(constraint)
            except Exception as e:
                logger.error(f"Error creating constraint: {str(e)}")
                raise
                
    def clear_database(self):
        """Clear all data from the database."""
        try:
            self.execute_query("MATCH (n) DETACH DELETE n")
        except Exception as e:
            logger.error(f"Error clearing database: {str(e)}")
            raise
            
    def close(self):
        """Close the database connection."""
        if self.driver:
            self.driver.close() 