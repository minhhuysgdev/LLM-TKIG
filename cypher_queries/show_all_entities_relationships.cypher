// ========================================
// 📊 SHOW ALL ENTITIES AND RELATIONSHIPS
// ========================================
// Queries to visualize the complete knowledge graph

// ========================================
// 1. COMPLETE KNOWLEDGE GRAPH (SMALL SAMPLE)
// ========================================

// Show all entities and relationships (limited for performance)
MATCH (source)-[r]->(target)
RETURN source, r, target
LIMIT 100;

// ========================================
// 2. OVERVIEW BY ENTITY TYPES
// ========================================

// Count entities by type
CALL db.labels() YIELD label
CALL {
  WITH label
  MATCH (n) WHERE label IN labels(n)
  RETURN count(n) as count
}
RETURN label as entity_type, count
ORDER BY count DESC;

// Count relationships by type
MATCH ()-[r]->()
RETURN type(r) as relationship_type, count(r) as count
ORDER BY count DESC
LIMIT 20;

// ========================================
// 3. SAMPLE FROM EACH ENTITY TYPE
// ========================================

// Get sample entities from each type
MATCH (attackers:Attackers)
WITH collect(attackers)[0..3] as sample_attackers

MATCH (malware:Malware)  
WITH sample_attackers, collect(malware)[0..3] as sample_malware

MATCH (tools:Tools)
WITH sample_attackers, sample_malware, collect(tools)[0..3] as sample_tools

MATCH (vulns:Vulnerabilities)
WITH sample_attackers, sample_malware, sample_tools, collect(vulns)[0..2] as sample_vulns

MATCH (files:Files)
WITH sample_attackers, sample_malware, sample_tools, sample_vulns, collect(files)[0..2] as sample_files

RETURN 
  sample_attackers as attackers,
  sample_malware as malware,
  sample_tools as tools,
  sample_vulns as vulnerabilities,
  sample_files as files;

// ========================================
// 4. NETWORK OVERVIEW WITH RELATIONSHIPS
// ========================================

// Show interconnected network (balanced sample)
MATCH (source)-[r]->(target)
WHERE rand() < 0.1  // Random 10% sample
RETURN source, r, target
LIMIT 50;

// ========================================
// 5. MOST CONNECTED ENTITIES
// ========================================

// Find entities with most connections
MATCH (n)
OPTIONAL MATCH (n)-[r_out]->()
OPTIONAL MATCH ()-[r_in]->(n)
WITH n, count(r_out) + count(r_in) AS total_connections
WHERE total_connections > 0
RETURN 
  labels(n)[0] AS entity_type,
  n.name AS entity_name,
  n.id AS entity_id,
  total_connections
ORDER BY total_connections DESC
LIMIT 20;

// ========================================
// 6. NETWORK BY RELATIONSHIP TYPES
// ========================================

// Show network for specific relationship types
MATCH (source)-[r]->(target)
WHERE type(r) IN ['USES', 'TARGETS', 'EXPLOITS', 'ASSOCIATED_WITH', 'DEVELOPS']
RETURN source, r, target
LIMIT 30;

// ========================================
// 7. LAYERED NETWORK VIEW
// ========================================

// Show network layer by layer
// Layer 1: Attackers and their direct connections
MATCH (att:Attackers)-[r1]-(connected1)
// Layer 2: Extend to important entities
OPTIONAL MATCH (connected1)-[r2]-(connected2)
WHERE labels(connected2)[0] IN ['Malware', 'Tools', 'Vulnerabilities']
AND connected2 <> att

RETURN att, r1, connected1, r2, connected2
LIMIT 40;

// ========================================
// 8. COMPLETE GRAPH (USE WITH CAUTION)
// ========================================

// Show ALL entities and relationships (WARNING: May be slow!)
// Only use if you have small dataset
MATCH (n)-[r]-(m)
RETURN n, r, m;

// ========================================
// 9. CLUSTERED VIEW BY ENTITY TYPES
// ========================================

// Group entities by type and show inter-type relationships
MATCH (source)-[r]->(target)
WHERE labels(source)[0] <> labels(target)[0]  // Different entity types
RETURN 
  labels(source)[0] AS source_type,
  source.name AS source_name,
  type(r) AS relationship,
  labels(target)[0] AS target_type,
  target.name AS target_name
LIMIT 30;

// ========================================
// 10. INTERACTIVE EXPLORATION QUERIES
// ========================================

// Start with one entity and expand
MATCH (start)
WHERE start.name CONTAINS 'Malware' OR start.name CONTAINS 'Tool'
MATCH (start)-[r]-(connected)
RETURN start, r, connected
LIMIT 20;

// ========================================
// 11. CENTRALITY ANALYSIS
// ========================================

// Find most central entities (high degree centrality)
MATCH (n)
MATCH (n)-[]-(neighbor)
WITH n, count(DISTINCT neighbor) as degree
WHERE degree >= 3
RETURN 
  labels(n)[0] as entity_type,
  n.name as entity_name,
  degree
ORDER BY degree DESC
LIMIT 15;

// ========================================
// 12. KNOWLEDGE GRAPH STATISTICS
// ========================================

// Overall statistics
MATCH (n) 
WITH count(n) as total_nodes

MATCH ()-[r]->()
WITH total_nodes, count(r) as total_relationships

CALL db.labels() YIELD label
WITH total_nodes, total_relationships, count(label) as total_labels

MATCH ()-[r]->()
WITH total_nodes, total_relationships, total_labels, count(DISTINCT type(r)) as total_rel_types

RETURN 
  total_nodes,
  total_relationships,
  total_labels,
  total_rel_types,
  round(total_relationships * 1.0 / total_nodes, 2) as avg_connections_per_node;

// ========================================
// 13. RECOMMENDED VISUALIZATION QUERY
// ========================================

// Best query for Neo4j Browser visualization
MATCH (n)
WITH n, rand() as r
ORDER BY r
LIMIT 30

MATCH (n)-[rel]-(connected)
RETURN n, rel, connected;

// ========================================
// 14. FILTERED NETWORK (PERFORMANCE OPTIMIZED)
// ========================================

// Show important entities only (those with multiple connections)
// Neo4j 5.0+ syntax:
MATCH (important)
WHERE COUNT { (important)--() } >= 2  // At least 2 connections

MATCH (important)-[r]-(connected)
RETURN important, r, connected
LIMIT 50;

// Alternative for older Neo4j versions:
/*
MATCH (important)
OPTIONAL MATCH (important)-[]-(connected_entity)
WITH important, count(connected_entity) as connection_count
WHERE connection_count >= 2

MATCH (important)-[r]-(connected)
RETURN important, r, connected
LIMIT 50;
*/

// ========================================
// 15. ENTITY TYPE MATRIX VIEW
// ========================================

// Show how different entity types are connected
MATCH (source)-[r]->(target)
RETURN 
  labels(source)[0] AS from_type,
  labels(target)[0] AS to_type,
  type(r) AS relationship_type,
  count(*) AS connection_count
ORDER BY connection_count DESC
LIMIT 25;
