#!/usr/bin/env python3
"""
Extract Attacker Relationships from LLM-TIKG Knowledge Graph
Trích xuất chỉ relationships liên quan đến attackers
"""

import csv
import json
from typing import List, Dict, Set
from pathlib import Path

class AttackerRelationshipExtractor:
    def __init__(self, input_file: str = "data/relationships_norm.csv"):
        self.input_file = input_file
        self.attacker_relationships = []
        self.attacker_ids = set()
        
    def load_attacker_ids(self):
        """Load attacker IDs từ CSV files"""
        attacker_file = "data/entities/attackers.csv"
        if Path(attacker_file).exists():
            with open(attacker_file, 'r', encoding='utf-8') as f:
                reader = csv.DictReader(f)
                for row in reader:
                    self.attacker_ids.add(row['id'])
            print(f"✅ Loaded {len(self.attacker_ids)} attacker IDs")
        else:
            print(f"⚠️ File {attacker_file} not found")
    
    def extract_attacker_relationships(self):
        """Extract relationships liên quan đến attackers"""
        if not Path(self.input_file).exists():
            print(f"❌ File {self.input_file} not found")
            return
            
        with open(self.input_file, 'r', encoding='utf-8') as f:
            reader = csv.DictReader(f)
            for row in reader:
                source_id = row['source_id']
                target_id = row['target_id']
                
                # Kiểm tra nếu source hoặc target là attacker
                if source_id in self.attacker_ids or target_id in self.attacker_ids:
                    self.attacker_relationships.append({
                        'source_id': source_id,
                        'source_name': row['source_name'],
                        'relation': row['relation'],
                        'target_id': target_id,
                        'target_name': row['target_name'],
                        'id': row['id'],
                        'source_is_attacker': source_id in self.attacker_ids,
                        'target_is_attacker': target_id in self.attacker_ids
                    })
        
        print(f"✅ Extracted {len(self.attacker_relationships)} attacker-related relationships")
    
    def analyze_relationships(self):
        """Phân tích relationships"""
        if not self.attacker_relationships:
            print("❌ No relationships to analyze")
            return
            
        # Phân loại relationships
        attacker_to_attacker = []
        attacker_to_other = []
        other_to_attacker = []
        
        for rel in self.attacker_relationships:
            if rel['source_is_attacker'] and rel['target_is_attacker']:
                attacker_to_attacker.append(rel)
            elif rel['source_is_attacker']:
                attacker_to_other.append(rel)
            elif rel['target_is_attacker']:
                other_to_attacker.append(rel)
        
        print(f"\n📊 ATTACKER RELATIONSHIPS ANALYSIS:")
        print(f"   Attacker → Attacker: {len(attacker_to_attacker)}")
        print(f"   Attacker → Other: {len(attacker_to_other)}")
        print(f"   Other → Attacker: {len(other_to_attacker)}")
        print(f"   Total: {len(self.attacker_relationships)}")
        
        # Phân tích relationship types
        relation_types = {}
        for rel in self.attacker_relationships:
            rel_type = rel['relation']
            relation_types[rel_type] = relation_types.get(rel_type, 0) + 1
        
        print(f"\n🔗 RELATIONSHIP TYPES:")
        for rel_type, count in sorted(relation_types.items(), key=lambda x: x[1], reverse=True):
            print(f"   {rel_type}: {count}")
    
    def save_attacker_relationships(self, output_file: str = "data/attacker_relationships.csv"):
        """Save attacker relationships to CSV"""
        if not self.attacker_relationships:
            print("❌ No relationships to save")
            return
            
        with open(output_file, 'w', encoding='utf-8', newline='') as f:
            fieldnames = ['source_id', 'source_name', 'relation', 'target_id', 'target_name', 'id', 'source_is_attacker', 'target_is_attacker']
            writer = csv.DictWriter(f, fieldnames=fieldnames)
            writer.writeheader()
            writer.writerows(self.attacker_relationships)
        
        print(f"✅ Saved {len(self.attacker_relationships)} attacker relationships to {output_file}")
    
    def generate_cypher_queries(self, output_file: str = "cypher_queries/attacker_relationships.cypher"):
        """Generate Cypher queries cho attacker relationships"""
        if not self.attacker_relationships:
            print("❌ No relationships to generate queries for")
            return
            
        queries = []
        queries.append("// ========================================")
        queries.append("// ATTACKER RELATIONSHIPS - LLM-TIKG Knowledge Graph")
        queries.append("// ========================================")
        queries.append("")
        
        # Attacker to Attacker relationships
        att_to_att = [r for r in self.attacker_relationships if r['source_is_attacker'] and r['target_is_attacker']]
        if att_to_att:
            queries.append("// 🎯 ATTACKER TO ATTACKER RELATIONSHIPS")
            queries.append("// ========================================")
            for rel in att_to_att:
                queries.append(f"MATCH (source:Attackers {{id: '{rel['source_id']}'}})")
                queries.append(f"MATCH (target:Attackers {{id: '{rel['target_id']}'}})")
                queries.append(f"CREATE (source)-[:RELATES_TO {{id: '{rel['id']}', type: '{rel['relation']}'}}]->(target);")
                queries.append("")
        
        # Attacker to Other relationships
        att_to_other = [r for r in self.attacker_relationships if r['source_is_attacker'] and not r['target_is_attacker']]
        if att_to_other:
            queries.append("// 🎯 ATTACKER TO OTHER ENTITIES")
            queries.append("// ========================================")
            
            # Group by target type
            target_types = {}
            for rel in att_to_other:
                target_type = rel['target_id'][:3]  # ATT, MAL, TOO, VUL, FIL
                if target_type not in target_types:
                    target_types[target_type] = []
                target_types[target_type].append(rel)
            
            for target_type, rels in target_types.items():
                type_name = {
                    'MAL': 'Malware',
                    'TOO': 'Tools', 
                    'VUL': 'Vulnerabilities',
                    'FIL': 'Files'
                }.get(target_type, target_type)
                
                queries.append(f"// Attacker → {type_name}")
                for rel in rels:
                    queries.append(f"MATCH (source:Attackers {{id: '{rel['source_id']}'}})")
                    queries.append(f"MATCH (target:{type_name} {{id: '{rel['target_id']}'}})")
                    queries.append(f"CREATE (source)-[:RELATES_TO {{id: '{rel['id']}', type: '{rel['relation']}'}}]->(target);")
                queries.append("")
        
        # Other to Attacker relationships
        other_to_att = [r for r in self.attacker_relationships if not r['source_is_attacker'] and r['target_is_attacker']]
        if other_to_att:
            queries.append("// 🎯 OTHER ENTITIES TO ATTACKER")
            queries.append("// ========================================")
            
            # Group by source type
            source_types = {}
            for rel in other_to_att:
                source_type = rel['source_id'][:3]
                if source_type not in source_types:
                    source_types[source_type] = []
                source_types[source_type].append(rel)
            
            for source_type, rels in source_types.items():
                type_name = {
                    'MAL': 'Malware',
                    'TOO': 'Tools',
                    'VUL': 'Vulnerabilities', 
                    'FIL': 'Files'
                }.get(source_type, source_type)
                
                queries.append(f"// {type_name} → Attacker")
                for rel in rels:
                    queries.append(f"MATCH (source:{type_name} {{id: '{rel['source_id']}'}})")
                    queries.append(f"MATCH (target:Attackers {{id: '{rel['target_id']}'}})")
                    queries.append(f"CREATE (source)-[:RELATES_TO {{id: '{rel['id']}', type: '{rel['relation']}'}}]->(target);")
                queries.append("")
        
        # Verification queries
        queries.append("// 🎯 VERIFICATION QUERIES")
        queries.append("// ========================================")
        queries.append("")
        queries.append("// Tổng số attacker relationships")
        queries.append("MATCH (a:Attackers)-[r:RELATES_TO]-()")
        queries.append("RETURN count(r) as AttackerRelationships;")
        queries.append("")
        queries.append("// Attacker relationships theo loại")
        queries.append("MATCH (a:Attackers)-[r:RELATES_TO]->(target)")
        queries.append("RETURN a.name as Attacker, r.type as Relation, target.name as Target, labels(target)[0] as TargetType")
        queries.append("ORDER BY a.name;")
        queries.append("")
        queries.append("// Top attackers có nhiều connections")
        queries.append("MATCH (a:Attackers)-[r:RELATES_TO]-()")
        queries.append("RETURN a.name as Attacker, count(r) as Connections")
        queries.append("ORDER BY Connections DESC")
        queries.append("LIMIT 10;")
        
        # Write to file
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write('\n'.join(queries))
        
        print(f"✅ Generated Cypher queries to {output_file}")
    
    def run(self):
        """Run complete extraction process"""
        print("🚀 Starting Attacker Relationship Extraction...")
        
        # Load attacker IDs
        self.load_attacker_ids()
        
        # Extract relationships
        self.extract_attacker_relationships()
        
        # Analyze relationships
        self.analyze_relationships()
        
        # Save to CSV
        self.save_attacker_relationships()
        
        # Generate Cypher queries
        self.generate_cypher_queries()
        
        print("✅ Attacker relationship extraction complete!")

if __name__ == "__main__":
    extractor = AttackerRelationshipExtractor()
    extractor.run()
