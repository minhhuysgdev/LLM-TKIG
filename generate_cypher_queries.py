#!/usr/bin/env python3
"""
Generate Cypher Queries for Neo4j
Create Cypher queries for importing entities and relationships
"""

import csv
import os
from typing import Dict, List, Set
from collections import defaultdict

class CypherQueryGenerator:
    def __init__(self, entities_dir: str = "data/entities", relationships_file: str = "data/relationships_norm.csv"):
        self.entities_dir = entities_dir
        self.relationships_file = relationships_file
        self.entity_ids = {}  # name -> id mapping
        self.relationships_by_type = defaultdict(list)
        
    def load_entities(self) -> Dict[str, List]:
        """Load entities from CSV files"""
        entities = {}
        entity_types = ['attackers', 'malware', 'files', 'hashes', 'vulnerabilities', 'tools']
        
        for entity_type in entity_types:
            csv_file = f"{self.entities_dir}/{entity_type}.csv"
            if not os.path.exists(csv_file):
                continue
                
            entities[entity_type] = []
            with open(csv_file, 'r', encoding='utf-8') as f:
                reader = csv.DictReader(f)
                for row in reader:
                    entities[entity_type].append(row)
                    # Store mapping for relationships
                    self.entity_ids[row['name']] = row['id']
            
            print(f"✅ Loaded {len(entities[entity_type])} {entity_type}")
        
        return entities
    
    def load_relationships(self) -> List[Dict]:
        """Load relationships from CSV file"""
        relationships = []
        
        if not os.path.exists(self.relationships_file):
            print(f"⚠️ Relationships file not found: {self.relationships_file}")
            return relationships
        
        with open(self.relationships_file, 'r', encoding='utf-8') as f:
            reader = csv.DictReader(f)
            for row in reader:
                relationships.append(row)
                # Group by source entity type
                source_type = row['source_id'][:3].lower()
                self.relationships_by_type[source_type].append(row)
        
        print(f"✅ Loaded {len(relationships)} relationships")
        return relationships
    
    def generate_node_creation_queries(self, entities: Dict[str, List]) -> str:
        """Generate Cypher queries for creating nodes"""
        queries = []
        
        # Node creation queries
        for entity_type, entity_list in entities.items():
            if not entity_list:
                continue
                
            # Create nodes
            node_query = f"// Create {entity_type} nodes\n"
            node_query += f"CREATE CONSTRAINT {entity_type}_id IF NOT EXISTS FOR (n:{entity_type.capitalize()}) REQUIRE n.id IS UNIQUE;\n\n"
            
            # Batch create nodes
            batch_size = 50
            for i in range(0, len(entity_list), batch_size):
                batch = entity_list[i:i+batch_size]
                
                node_query += f"// Batch {i//batch_size + 1} of {entity_type}\n"
                for entity in batch:
                    # Escape quotes in name
                    name = entity['name'].replace("'", "\\'")
                    node_query += f"CREATE (:{entity_type.capitalize()} {{id: '{entity['id']}', name: '{name}', type: '{entity['type']}'}});\n"
                node_query += "\n"
            
            queries.append(node_query)
        
        return "\n".join(queries)
    
    def generate_relationship_queries(self, entity_type: str) -> str:
        """Generate Cypher queries for relationships by entity type"""
        if entity_type not in self.relationships_by_type:
            return ""
        
        relationships = self.relationships_by_type[entity_type]
        if not relationships:
            return ""
        
        # Group relationships by source entity
        source_groups = defaultdict(list)
        for rel in relationships:
            source_groups[rel['source_id']].append(rel)
        
        queries = []
        queries.append(f"// {entity_type.upper()} Relationships")
        queries.append(f"// Total: {len(relationships)} relationships")
        queries.append("")
        
        for source_id, rels in source_groups.items():
            # Get source entity name
            source_name = rels[0]['source_name'].replace("'", "\\'")
            
            queries.append(f"// {source_name} ({source_id}) relationships")
            queries.append(f"MATCH (source:{entity_type.capitalize()} {{id: '{source_id}'}})")
            
            # Create target matches
            target_matches = []
            for rel in rels:
                target_type = rel['target_id'][:3].lower()
                target_name = rel['target_name'].replace("'", "\\'")
                relation = rel['relation'].replace("'", "\\'")
                
                target_matches.append(
                    f"OPTIONAL MATCH (target_{rel['target_id']}:{target_type.capitalize()} {{id: '{rel['target_id']}'}})"
                )
            
            queries.extend(target_matches)
            
            # Create relationships
            queries.append("FOREACH (rel IN [")
            for i, rel in enumerate(rels):
                target_type = rel['target_id'][:3].lower()
                relation = rel['relation'].replace("'", "\\'")
                
                if i > 0:
                    queries.append("  ,")
                queries.append(f"  {{source: source, target: target_{rel['target_id']}, relation: '{relation}'}}")
            
            queries.append("] |")
            queries.append("  CASE WHEN rel.target IS NOT NULL")
            queries.append("    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)")
            queries.append("    ELSE NULL")
            queries.append("  END")
            queries.append(");")
            queries.append("")
        
        return "\n".join(queries)
    
    def generate_all_relationship_queries(self) -> str:
        """Generate all relationship queries"""
        all_queries = []
        
        entity_types = ['atk', 'mal', 'fil', 'has', 'vul', 'too']  # Prefixes for entity types
        
        for entity_type in entity_types:
            query = self.generate_relationship_queries(entity_type)
            if query:
                all_queries.append(query)
        
        return "\n".join(all_queries)
    
    def generate_mega_query(self) -> str:
        """Generate a single mega query for all relationships"""
        if not self.relationships_by_type:
            return ""
        
        all_relationships = []
        for rels in self.relationships_by_type.values():
            all_relationships.extend(rels)
        
        if not all_relationships:
            return ""
        
        mega_query = "// MEGA RELATIONSHIP QUERY\n"
        mega_query += f"// Total relationships: {len(all_relationships)}\n\n"
        
        # Group by source entity
        source_groups = defaultdict(list)
        for rel in all_relationships:
            source_groups[rel['source_id']].append(rel)
        
        for source_id, rels in source_groups.items():
            source_type = source_id[:3].lower()
            source_name = rels[0]['source_name'].replace("'", "\\'")
            
            mega_query += f"// {source_name} ({source_id})\n"
            mega_query += f"MATCH (source:{source_type.capitalize()} {{id: '{source_id}'}})\n"
            
            # Create all target matches
            for rel in rels:
                target_type = rel['target_id'][:3].lower()
                mega_query += f"OPTIONAL MATCH (target_{rel['target_id']}:{target_type.capitalize()} {{id: '{rel['target_id']}'}})\n"
            
            # Create relationships
            mega_query += "FOREACH (rel IN [\n"
            for i, rel in enumerate(rels):
                relation = rel['relation'].replace("'", "\\'")
                if i > 0:
                    mega_query += "  ,\n"
                mega_query += f"  {{source: source, target: target_{rel['target_id']}, relation: '{relation}'}}"
            mega_query += "\n] |\n"
            mega_query += "  CASE WHEN rel.target IS NOT NULL\n"
            mega_query += "    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)\n"
            mega_query += "    ELSE NULL\n"
            mega_query += "  END\n"
            mega_query += ");\n\n"
        
        return mega_query
    
    def save_queries_to_files(self, entities: Dict[str, List]) -> None:
        """Save all queries to separate files"""
        os.makedirs("cypher_queries", exist_ok=True)
        
        # 1. Node creation queries
        node_queries = self.generate_node_creation_queries(entities)
        with open("cypher_queries/create_nodes.cypher", 'w', encoding='utf-8') as f:
            f.write(node_queries)
        print("✅ Saved node creation queries to cypher_queries/create_nodes.cypher")
        
        # 2. Individual relationship queries
        for entity_type in ['atk', 'mal', 'fil', 'has', 'vul', 'too']:
            query = self.generate_relationship_queries(entity_type)
            if query:
                filename = f"cypher_queries/all_{entity_type}_relationships.cypher"
                with open(filename, 'w', encoding='utf-8') as f:
                    f.write(query)
                print(f"✅ Saved {entity_type} relationships to {filename}")
        
        # 3. Mega relationship query
        mega_query = self.generate_mega_query()
        if mega_query:
            with open("cypher_queries/mega_relationships_query.cypher", 'w', encoding='utf-8') as f:
                f.write(mega_query)
            print("✅ Saved mega relationship query to cypher_queries/mega_relationships_query.cypher")
    
    def run(self) -> None:
        """Main execution method"""
        print("🚀 Starting Cypher Query Generation...")
        
        # Load data
        entities = self.load_entities()
        relationships = self.load_relationships()
        
        if not entities:
            print("❌ No entities found")
            return
        
        # Generate and save queries
        self.save_queries_to_files(entities)
        
        print("\n📊 QUERY GENERATION STATISTICS:")
        print(f"Entity types: {len(entities)}")
        for entity_type, entity_list in entities.items():
            print(f"  {entity_type}: {len(entity_list)} entities")
        
        print(f"\nRelationships by type:")
        for entity_type, rels in self.relationships_by_type.items():
            print(f"  {entity_type}: {len(rels)} relationships")


def main():
    """Main function"""
    generator = CypherQueryGenerator()
    generator.run()


if __name__ == "__main__":
    main()
