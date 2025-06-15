"""
Graph post-processing module for LLM-TIKG integration.
Handles post-processing of knowledge graph data.
"""

from typing import Dict, List, Any, Optional
import logging
from neo4j import GraphDatabase

logger = logging.getLogger(__name__)

class GraphPostProcessor:
    def __init__(self, config: Dict[str, Any]):
        """
        Initialize graph post-processor.
        
        Args:
            config (Dict[str, Any]): Post-processing configuration
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
            
    def merge_duplicate_entities(self):
        """Merge duplicate entities based on similarity."""
        query = """
        MATCH (e1:Entity), (e2:Entity)
        WHERE e1 <> e2 AND e1.name = e2.name
        CALL apoc.refactor.mergeNodes([e1, e2], {properties: {
            name: 'discard',
            description: 'combine',
            confidence: 'max'
        }})
        YIELD node
        RETURN node
        """
        try:
            with self.driver.session() as session:
                session.run(query)
        except Exception as e:
            logger.error(f"Error merging duplicate entities: {str(e)}")
            raise
            
    def remove_isolated_nodes(self):
        """Remove nodes that have no relationships."""
        query = """
        MATCH (n)
        WHERE NOT (n)--()
        DELETE n
        """
        try:
            with self.driver.session() as session:
                session.run(query)
        except Exception as e:
            logger.error(f"Error removing isolated nodes: {str(e)}")
            raise
            
    def calculate_centrality_metrics(self):
        """Calculate centrality metrics for nodes."""
        queries = [
            # PageRank
            """
            CALL gds.pageRank.write({
                nodeProjection: '*',
                relationshipProjection: '*',
                writeProperty: 'pagerank'
            })
            """,
            # Betweenness Centrality
            """
            CALL gds.betweenness.write({
                nodeProjection: '*',
                relationshipProjection: '*',
                writeProperty: 'betweenness'
            })
            """
        ]
        
        for query in queries:
            try:
                with self.driver.session() as session:
                    session.run(query)
            except Exception as e:
                logger.error(f"Error calculating centrality metrics: {str(e)}")
                raise
                
    def validate_graph_structure(self) -> Dict[str, Any]:
        """
        Validate the graph structure and return statistics.
        
        Returns:
            Dict[str, Any]: Graph statistics
        """
        queries = {
            "node_count": "MATCH (n) RETURN count(n) as count",
            "relationship_count": "MATCH ()-[r]->() RETURN count(r) as count",
            "entity_types": "MATCH (n) RETURN labels(n) as type, count(*) as count",
            "relationship_types": "MATCH ()-[r]->() RETURN type(r) as type, count(*) as count"
        }
        
        stats = {}
        try:
            with self.driver.session() as session:
                for key, query in queries.items():
                    result = session.run(query)
                    stats[key] = result.single()["count"]
        except Exception as e:
            logger.error(f"Error validating graph structure: {str(e)}")
            raise
            
        return stats
        
    def close(self):
        """Close the database connection."""
        if self.driver:
            self.driver.close() 