"""
Knowledge graph module for LLM-TIKG integration.
Handles knowledge graph construction and management.
"""

from typing import Dict, List, Any, Optional
from neo4j import GraphDatabase
import logging

logger = logging.getLogger(__name__)

class KnowledgeGraph:
    def __init__(self, config: Dict[str, Any]):
        """
        Initialize knowledge graph.
        
        Args:
            config (Dict[str, Any]): Graph configuration
        """
        self.config = config
        self.driver = None
        self._connect()
        
    def _connect(self):
        """Establish connection to Neo4j database."""
        try:
            self.driver = GraphDatabase.driver(
                self.config["uri"],
                auth=(self.config["username"], self.config["password"])
            )
        except Exception as e:
            logger.error(f"Error connecting to Neo4j: {str(e)}")
            raise
            
    def create_entity(self, entity_type: str, properties: Dict[str, Any]) -> str:
        """
        Create a new entity node.
        
        Args:
            entity_type (str): Type of entity
            properties (Dict[str, Any]): Entity properties
            
        Returns:
            str: Created entity ID
        """
        with self.driver.session() as session:
            result = session.write_transaction(
                self._create_entity_tx,
                entity_type,
                properties
            )
            return result
            
    def create_relationship(
        self,
        source_id: str,
        target_id: str,
        relationship_type: str,
        properties: Optional[Dict[str, Any]] = None
    ) -> str:
        """
        Create a relationship between entities.
        
        Args:
            source_id (str): Source entity ID
            target_id (str): Target entity ID
            relationship_type (str): Type of relationship
            properties (Optional[Dict[str, Any]]): Relationship properties
            
        Returns:
            str: Created relationship ID
        """
        with self.driver.session() as session:
            result = session.write_transaction(
                self._create_relationship_tx,
                source_id,
                target_id,
                relationship_type,
                properties or {}
            )
            return result
            
    @staticmethod
    def _create_entity_tx(tx, entity_type: str, properties: Dict[str, Any]) -> str:
        """Transaction function for entity creation."""
        query = (
            f"CREATE (e:{entity_type} $properties) "
            "RETURN id(e) as entity_id"
        )
        result = tx.run(query, properties=properties)
        return result.single()["entity_id"]
        
    @staticmethod
    def _create_relationship_tx(
        tx,
        source_id: str,
        target_id: str,
        relationship_type: str,
        properties: Dict[str, Any]
    ) -> str:
        """Transaction function for relationship creation."""
        query = (
            f"MATCH (a), (b) "
            f"WHERE id(a) = $source_id AND id(b) = $target_id "
            f"CREATE (a)-[r:{relationship_type} $properties]->(b) "
            "RETURN id(r) as rel_id"
        )
        result = tx.run(
            query,
            source_id=source_id,
            target_id=target_id,
            properties=properties
        )
        return result.single()["rel_id"]
        
    def close(self):
        """Close the database connection."""
        if self.driver:
            self.driver.close() 