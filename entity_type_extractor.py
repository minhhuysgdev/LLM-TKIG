#!/usr/bin/env python3
"""
Entity Type Extractor for LLM-TIKG
Extract and categorize entities from entity&relationship.json file
"""

import json
import csv
import re
from collections import defaultdict
from typing import Dict, List, Set, Tuple
import os
from pathlib import Path

class EntityTypeExtractor:
    def __init__(self, input_file: str = "data/entity-extraction/merged_llama3_extractions_full_content.json"):
        self.input_file = input_file
        self.entities = defaultdict(set)  # type -> set of entities
        self.relationships = []
        self.entity_mapping = {}  # normalized_name -> original_name
        
    def load_data(self) -> bool:
        """Load JSON data from input file"""
        try:
            with open(self.input_file, 'r', encoding='utf-8') as f:
                data = json.load(f)
            print(f"✅ Loaded {len(data)} records from {self.input_file}")
            return data
        except Exception as e:
            print(f"❌ Error loading {self.input_file}: {e}")
            return None
    
    def normalize_entity_name(self, name: str) -> str:
        """Normalize entity name for deduplication"""
        if not name:
            return ""
        
        # Convert to lowercase and remove extra whitespace
        normalized = name.lower().strip()
        
        # Remove common prefixes/suffixes
        normalized = re.sub(r'^(the\s+|a\s+|an\s+)', '', normalized)
        normalized = re.sub(r'[^\w\s\-\.]', '', normalized)
        
        return normalized
    
    def classify_entity(self, entity_name: str, entity_type: str) -> str:
        """Classify entity based on name and type patterns"""
        name_lower = entity_name.lower()
        
        # Attackers/Actors
        if any(keyword in name_lower for keyword in ['apt', 'group', 'actor', 'threat', 'hacker', 'cyber']) or entity_type in ['ThreatActor', 'Person', 'Organization']:
            return 'attackers'
        
        # Malware
        if any(keyword in name_lower for keyword in ['malware', 'virus', 'trojan', 'ransomware', 'backdoor', 'worm']) or entity_type in ['Malware', 'Virus', 'Trojan', 'Ransomware']:
            return 'malware'
        
        # Files
        if any(keyword in name_lower for keyword in ['.exe', '.dll', '.bat', '.ps1', '.vbs', '.js', 'file']) or entity_type in ['File', 'Executable', 'Script']:
            return 'files'
        
        # Hashes (MD5, SHA1, SHA256 patterns)
        if re.match(r'^[a-fA-F0-9]{32}$', entity_name) or re.match(r'^[a-fA-F0-9]{40}$', entity_name) or re.match(r'^[a-fA-F0-9]{64}$', entity_name) or entity_type in ['Hash', 'MD5', 'SHA1', 'SHA256']:
            return 'hashes'
        
        # Vulnerabilities (CVE patterns)
        if re.match(r'^CVE-\d{4}-\d+$', entity_name, re.IGNORECASE) or entity_type in ['Vulnerability', 'CVE']:
            return 'vulnerabilities'
        
        # Tools
        if any(keyword in name_lower for keyword in ['tool', 'framework', 'kit', 'platform', 'software']) or entity_type in ['Tool', 'Framework', 'Platform', 'Software']:
            return 'tools'
        
        # IP Address patterns
        if re.match(r'^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$', entity_name) or entity_type in ['IP', 'IP_Address', 'IPAddress']:
            return 'ips'
        
        # URL patterns
        if any(keyword in name_lower for keyword in ['http://', 'https://', 'www.', '.com', '.org', '.net', '.edu']) or entity_type in ['URL', 'Domain', 'Website']:
            return 'urls'
        
        # Device patterns
        if any(keyword in name_lower for keyword in ['server', 'computer', 'device', 'system', 'network', 'machine']) or entity_type in ['Device', 'Server', 'Computer', 'System', 'Network']:
            return 'devices'
        
        # Technique patterns
        if any(keyword in name_lower for keyword in ['technique', 'tactic', 'ttp', 'attack', 'procedure']) or entity_type in ['Technique', 'Tactic', 'TTP', 'Attack_Pattern', 'Procedure']:
            return 'techniques'
        
        # Default classification based on entity_type
        type_mapping = {
            'PERSON': 'attackers',
            'ORG': 'attackers', 
            'MALWARE': 'malware',
            'FILE': 'files',
            'HASH': 'hashes',
            'VULNERABILITY': 'vulnerabilities',
            'TOOL': 'tools',
            'TECHNIQUE': 'techniques',
            'IP': 'ips',
            'URL': 'urls',
            'DEVICE': 'devices',
            'ThreatActor': 'attackers',
            'Person': 'attackers',
            'Organization': 'attackers',
            'Malware': 'malware',
            'Virus': 'malware',
            'Trojan': 'malware',
            'Ransomware': 'malware',
            'File': 'files',
            'Executable': 'files',
            'Script': 'files',
            'Hash': 'hashes',
            'MD5': 'hashes',
            'SHA1': 'hashes',
            'SHA256': 'hashes',
            'Vulnerability': 'vulnerabilities',
            'CVE': 'vulnerabilities',
            'Tool': 'tools',
            'Framework': 'tools',
            'Platform': 'tools',
            'Software': 'tools',
            'IP_Address': 'ips',
            'IPAddress': 'ips',
            'Domain': 'urls',
            'Website': 'urls',
            'Device': 'devices',
            'Server': 'devices',
            'Computer': 'devices',
            'System': 'devices',
            'Network': 'devices',
            'Technique': 'techniques',
            'Tactic': 'techniques',
            'TTP': 'techniques',
            'Attack_Pattern': 'techniques',
            'Procedure': 'techniques'
        }
        
        return type_mapping.get(entity_type, 'tools')
    
    def extract_entities_and_relationships(self, data: List[Dict]) -> None:
        """Extract entities and relationships from JSON data"""
        print(f"🔍 Processing {len(data)} records...")
        
        for i, record in enumerate(data):
            if i % 100 == 0:
                print(f"  Processed {i}/{len(data)} records")
            
            # Extract extraction field
            extraction = record.get('extraction', {})
            if not extraction:
                continue
            
            # Parse entities and relationships
            try:
                # Extract entities from extraction.entities
                entities = extraction.get('entities', [])
                for entity in entities:
                    if isinstance(entity, list) and len(entity) >= 2:
                        # Format: ["EntityName", "EntityType"]
                        entity_name = entity[0]
                        entity_type = entity[1] if len(entity) > 1 else ''
                        if entity_name:
                            self._process_entity(entity_name, entity_type)
                    elif isinstance(entity, dict):
                        # Format: {"text": "...", "type": "..."}
                        entity_text = entity.get('text', '')
                        entity_type = entity.get('type', '')
                        if entity_text and entity_type:
                            self._process_entity(entity_text, entity_type)
                
                # Extract relationships from extraction.relationships
                relationships = extraction.get('relationships', [])
                for rel in relationships:
                    # Handle both dict format and list format
                    if isinstance(rel, dict):
                        source = rel.get('source', '')
                        relation = rel.get('relation', '')
                        target = rel.get('target', '')
                    elif isinstance(rel, list) and len(rel) >= 3:
                        source = rel[0]
                        relation = rel[1]
                        target = rel[2]
                    else:
                        continue
                        
                    if source and relation and target:
                        self.relationships.append({
                            'source': source,
                            'relation': relation,
                            'target': target
                        })
                    
            except Exception as e:
                print(f"⚠️ Error processing record {i}: {e}")
                continue
        
        print(f"✅ Extraction complete!")
        print(f"   Entities found: {sum(len(entities) for entities in self.entities.values())}")
        print(f"   Relationships found: {len(self.relationships)}")
    
    def _process_entity(self, entity_text: str, entity_type: str) -> None:
        """Process a single entity"""
        if entity_text and entity_type:
            # Classify entity
            category = self.classify_entity(entity_text, entity_type)
            
            # Normalize for deduplication
            normalized_name = self.normalize_entity_name(entity_text)
            
            if normalized_name:
                self.entities[category].add(normalized_name)
                self.entity_mapping[normalized_name] = entity_text
    
    def _parse_relationships(self, relationships_text: str) -> None:
        """Parse relationships from text"""
        # Pattern: (subject, verb, object)
        relationship_pattern = r'\(([^,]+),\s*([^,]+),\s*([^)]+)\)'
        matches = re.findall(relationship_pattern, relationships_text)
        
        for subject, verb, obj in matches:
            subject = subject.strip()
            verb = verb.strip()
            obj = obj.strip()
            
            if subject and verb and obj:
                self.relationships.append({
                    'source': subject,
                    'relation': verb,
                    'target': obj
                })
    
    def save_entities_to_csv(self, output_dir: str = "data/entities") -> None:
        """Save entities to separate CSV files"""
        os.makedirs(output_dir, exist_ok=True)
        
        entity_types = ['attackers', 'malware', 'files', 'hashes', 'vulnerabilities', 'tools', 'ips', 'urls', 'devices', 'techniques']
        
        for entity_type in entity_types:
            entities = self.entities[entity_type]
            if not entities:
                continue
                
            filename = f"{output_dir}/{entity_type}.csv"
            
            with open(filename, 'w', newline='', encoding='utf-8') as f:
                writer = csv.writer(f)
                writer.writerow(['id', 'name', 'type'])
                
                for i, normalized_name in enumerate(sorted(entities), 1):
                    original_name = self.entity_mapping.get(normalized_name, normalized_name)
                    entity_id = f"{entity_type.upper()[:3]}{i}"
                    writer.writerow([entity_id, original_name, entity_type])
            
            print(f"✅ Saved {len(entities)} {entity_type} to {filename}")
    
    def save_relationships_to_csv(self, output_file: str = "data/relationships_norm.csv") -> None:
        """Save normalized relationships to CSV"""
        os.makedirs(os.path.dirname(output_file), exist_ok=True)
        
        # Create entity ID mapping
        entity_to_id = {}
        entity_types = ['attackers', 'malware', 'files', 'hashes', 'vulnerabilities', 'tools']
        
        for entity_type in entity_types:
            entities = self.entities[entity_type]
            for i, normalized_name in enumerate(sorted(entities), 1):
                entity_to_id[normalized_name] = f"{entity_type.upper()[:3]}{i}"
        
        # Process relationships
        normalized_relationships = []
        relationship_id = 1
        
        for rel in self.relationships:
            source_norm = self.normalize_entity_name(rel['source'])
            target_norm = self.normalize_entity_name(rel['target'])
            
            if source_norm in entity_to_id and target_norm in entity_to_id:
                normalized_relationships.append({
                    'source_id': entity_to_id[source_norm],
                    'source_name': self.entity_mapping.get(source_norm, rel['source']),
                    'relation': rel['relation'],
                    'target_id': entity_to_id[target_norm],
                    'target_name': self.entity_mapping.get(target_norm, rel['target']),
                    'id': f"REL{relationship_id}"
                })
                relationship_id += 1
        
        # Save to CSV
        with open(output_file, 'w', newline='', encoding='utf-8') as f:
            fieldnames = ['source_id', 'source_name', 'relation', 'target_id', 'target_name', 'id']
            writer = csv.DictWriter(f, fieldnames=fieldnames)
            writer.writeheader()
            writer.writerows(normalized_relationships)
        
        print(f"✅ Saved {len(normalized_relationships)} relationships to {output_file}")
    
    def generate_statistics(self) -> Dict:
        """Generate statistics about extracted entities and relationships"""
        stats = {
            'total_entities': sum(len(entities) for entities in self.entities.values()),
            'total_relationships': len(self.relationships),
            'entity_types': {}
        }
        
        for entity_type, entities in self.entities.items():
            stats['entity_types'][entity_type] = len(entities)
        
        return stats
    
    def run(self, max_records: int = None) -> None:
        """Main execution method"""
        print("🚀 Starting Entity Type Extraction...")
        
        # Load data
        data = self.load_data()
        if data is None:
            print("❌ Failed to load data")
            return
        
        # Limit records if specified
        if max_records and len(data) > max_records:
            data = data[:max_records]
            print(f"📊 Processing first {max_records} records")
        
        # Extract entities and relationships
        self.extract_entities_and_relationships(data)
        
        # Save results
        self.save_entities_to_csv()
        self.save_relationships_to_csv()
        
        # Print statistics
        stats = self.generate_statistics()
        print("\n📊 EXTRACTION STATISTICS:")
        print(f"Total entities: {stats['total_entities']}")
        print(f"Total relationships: {stats['total_relationships']}")
        print("\nEntities by type:")
        for entity_type, count in stats['entity_types'].items():
            print(f"  {entity_type}: {count}")


def main():
    """Main function"""
    extractor = EntityTypeExtractor()
    
    # Process first 100 records for testing
    extractor.run(max_records=100)
    
    # Uncomment to process all records
    # extractor.run()


if __name__ == "__main__":
    main()
