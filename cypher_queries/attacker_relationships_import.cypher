// ========================================
// CYPHER QUERIES FOR ATTACKER RELATIONSHIPS
// ========================================
// This file contains Cypher queries to create relationships 
// involving Attacker entities in the threat intelligence knowledge graph

// ========================================
// 1. CREATE CONSTRAINTS (Run first)
// ========================================

// Create unique constraints for all entity types
CREATE CONSTRAINT IF NOT EXISTS FOR (a:Attackers) REQUIRE a.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (m:Malware) REQUIRE m.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (t:Tools) REQUIRE t.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (v:Vulnerabilities) REQUIRE v.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (f:Files) REQUIRE f.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (u:Urls) REQUIRE u.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (tech:Techniques) REQUIRE tech.id IS UNIQUE;

// ========================================
// 2. IMPORT ATTACKER-RELATED RELATIONSHIPS
// ========================================

// Load relationships where source is an Attacker
LOAD CSV WITH HEADERS FROM 'file:///relationships_norm.csv' AS row
WITH row WHERE row.source_id STARTS WITH 'ATT'
MATCH (source:Attackers {id: row.source_id})
MATCH (target) WHERE target.id = row.target_id
MERGE (source)-[r:RELATES_TO {
    type: row.relation,
    source_name: row.source_name,
    target_name: row.target_name,
    relationship_id: row.id,
    created_at: datetime()
}]->(target)
RETURN count(r) AS attacker_source_relationships_created;

// Load relationships where target is an Attacker  
LOAD CSV WITH HEADERS FROM 'file:///relationships_norm.csv' AS row
WITH row WHERE row.target_id STARTS WITH 'ATT'
MATCH (source) WHERE source.id = row.source_id
MATCH (target:Attackers {id: row.target_id})
MERGE (source)-[r:RELATES_TO {
    type: row.relation,
    source_name: row.source_name,
    target_name: row.target_name,
    relationship_id: row.id,
    created_at: datetime()
}]->(target)
RETURN count(r) AS attacker_target_relationships_created;

// ========================================
// 3. SPECIFIC ATTACKER RELATIONSHIP TYPES
// ========================================

// Attackers that use tools/malware
MATCH (a:Attackers)-[r:RELATES_TO]->(target)
WHERE r.type IN ['uses', 'employs', 'deploys', 'utilizes']
RETURN a.name AS attacker, r.type AS relationship, 
       labels(target)[0] AS target_type, target.name AS target_name
ORDER BY attacker;

// Attackers that exploit vulnerabilities
MATCH (a:Attackers)-[r:RELATES_TO]->(v:Vulnerabilities)
WHERE r.type IN ['exploits', 'targets', 'abuses']
RETURN a.name AS attacker, r.type AS relationship, v.name AS vulnerability
ORDER BY attacker;

// Attackers that develop/create malware
MATCH (a:Attackers)-[r:RELATES_TO]->(m:Malware)
WHERE r.type IN ['develops', 'creates', 'authors', 'publishes']
RETURN a.name AS attacker, r.type AS relationship, m.name AS malware
ORDER BY attacker;

// Attacker associations/aliases
MATCH (a1:Attackers)-[r:RELATES_TO]->(a2:Attackers)
WHERE r.type IN ['is_alias_for', 'associated_with', 'operates', 'controls']
RETURN a1.name AS source_attacker, r.type AS relationship, a2.name AS target_attacker
ORDER BY source_attacker;

// ========================================
// 4. ANALYSIS QUERIES
// ========================================

// Most connected attackers (by total relationships)
MATCH (a:Attackers)
OPTIONAL MATCH (a)-[r:RELATES_TO]-()
WITH a, count(r) AS total_connections
WHERE total_connections > 0
RETURN a.name AS attacker, total_connections
ORDER BY total_connections DESC
LIMIT 10;

// Attackers by relationship type
MATCH (a:Attackers)-[r:RELATES_TO]-()
WITH a, r.type AS relationship_type, count(r) AS type_count
RETURN a.name AS attacker, relationship_type, type_count
ORDER BY attacker, type_count DESC;

// Attack chains (Attacker -> Tool/Malware -> Target)
MATCH (a:Attackers)-[r1:RELATES_TO]->(tool)-[r2:RELATES_TO]->(target)
WHERE r1.type IN ['uses', 'employs'] AND r2.type IN ['targets', 'attacks']
RETURN a.name AS attacker, 
       r1.type AS uses_relationship,
       tool.name AS tool_used,
       r2.type AS target_relationship,
       target.name AS final_target
LIMIT 20;

// ========================================
// 5. VERIFICATION QUERIES
// ========================================

// Count all attacker relationships
MATCH (a:Attackers)
OPTIONAL MATCH (a)-[r:RELATES_TO]-()
RETURN count(DISTINCT a) AS total_attackers,
       count(r) AS total_attacker_relationships;

// Relationship types involving attackers
MATCH (a:Attackers)-[r:RELATES_TO]-()
RETURN r.type AS relationship_type, count(r) AS frequency
ORDER BY frequency DESC;

// Attackers with no relationships (isolated nodes)
MATCH (a:Attackers)
WHERE NOT EXISTS((a)-[:RELATES_TO]-())
RETURN a.name AS isolated_attacker, a.id AS attacker_id;

// ========================================
// 6. EXPORT ATTACKER SUBGRAPH
// ========================================

// Export all attacker relationships for visualization
MATCH (a:Attackers)-[r:RELATES_TO]-(connected)
RETURN a.id AS attacker_id, a.name AS attacker_name,
       r.type AS relationship_type,
       connected.id AS connected_id, connected.name AS connected_name,
       labels(connected)[0] AS connected_type
ORDER BY attacker_name, relationship_type;
