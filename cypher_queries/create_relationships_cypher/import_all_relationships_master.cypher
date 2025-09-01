// ========================================
// MASTER SCRIPT - CREATE ALL RELATIONSHIPS
// ========================================
// This script creates relationships for all entity types

// ========================================
// USAGE INSTRUCTIONS:
// ========================================
/*
1. Run individual scripts for specific entity types:
   - create_attackers_relationships.cypher
   - create_files_relationships.cypher
   - create_malware_relationships.cypher
   - create_tools_relationships.cypher
   - create_vulnerabilities_relationships.cypher

2. Or run this master script to import everything at once

3. Check verification queries at the end of each script
*/

// ========================================
// IMPORT ALL RELATIONSHIPS FROM CSV
// ========================================

// Method 1: Load all relationships with exact names
LOAD CSV WITH HEADERS FROM 'file:///relationships_norm.csv' AS row
CALL {
  WITH row
  MATCH (source {id: row.source_id})
  MATCH (target {id: row.target_id})
  // Create relationship with cleaned name
  WITH source, target, row,
       apoc.text.replace(upper(apoc.text.replace(row.relation, '[^a-zA-Z0-9_]', '_')), '_+', '_') AS rel_type
  CALL apoc.create.relationship(source, rel_type, {
    source_name: row.source_name,
    target_name: row.target_name,
    relationship_id: row.id,
    original_relation: row.relation,
    created_at: datetime()
  }, target) YIELD rel
  RETURN count(rel) as created
}
RETURN sum(created) as total_relationships_created;

// Method 2: Simple RELATES_TO relationships
// Uncomment if Method 1 doesn't work (requires APOC)
/*
LOAD CSV WITH HEADERS FROM 'file:///relationships_norm.csv' AS row
MATCH (source {id: row.source_id})
MATCH (target {id: row.target_id})
MERGE (source)-[:RELATES_TO {
  type: row.relation,
  source_name: row.source_name,
  target_name: row.target_name,
  relationship_id: row.id,
  created_at: datetime()
}]->(target);
*/

// ========================================
// FINAL VERIFICATION
// ========================================

// Count all relationships
MATCH ()-[r]->() RETURN count(r) AS total_relationships;

// Count by type
MATCH ()-[r]->()
RETURN type(r) AS relationship_type, count(r) AS count
ORDER BY count DESC
LIMIT 20;

// Sample network view
MATCH (source)-[r]->(target)
RETURN labels(source)[0] AS source_type, source.name AS source,
       type(r) AS relationship,
       labels(target)[0] AS target_type, target.name AS target
ORDER BY source_type, relationship
LIMIT 30;