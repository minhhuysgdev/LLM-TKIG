// ========================================
// QUERY ATTACKER RELATIONSHIPS
// ========================================

// 1. List all attackers first to see what we have
MATCH (a:Attackers)
RETURN a.id, a.name
ORDER BY a.name
LIMIT 20;

// ========================================
// 2. GET ALL RELATIONSHIPS FOR SPECIFIC ATTACKER
// ========================================

// Example: Get all relationships for "8220 Gang" (ATT1)
MATCH (attacker:Attackers {id: 'ATT1'})-[r]->(target)
RETURN 
    attacker.name AS attacker_name,
    type(r) AS relationship_type,
    labels(target)[0] AS target_type,
    target.name AS target_name,
    r.original_relation AS original_relation_name
ORDER BY relationship_type, target_type;

// ========================================
// 3. GET BIDIRECTIONAL RELATIONSHIPS 
// ========================================

// Get both outgoing and incoming relationships for "8220 Gang"
MATCH (attacker:Attackers {id: 'ATT1'})
OPTIONAL MATCH (attacker)-[r_out]->(target)
OPTIONAL MATCH (source)-[r_in]->(attacker)
RETURN 
    'OUTGOING' AS direction,
    attacker.name AS attacker_name,
    type(r_out) AS relationship_type,
    labels(target)[0] AS connected_type,
    target.name AS connected_name
WHERE r_out IS NOT NULL

UNION ALL

SELECT 
    'INCOMING' AS direction,
    attacker.name AS attacker_name,
    type(r_in) AS relationship_type,
    labels(source)[0] AS connected_type,
    source.name AS connected_name
WHERE r_in IS NOT NULL
ORDER BY direction, relationship_type;

// ========================================
// 4. DETAILED ATTACKER NETWORK ANALYSIS
// ========================================

// Get complete network for "Cl0p" (ATT17) - another example
MATCH (attacker:Attackers {id: 'ATT17'})
OPTIONAL MATCH (attacker)-[r_out]->(target)
OPTIONAL MATCH (source)-[r_in]->(attacker)
WITH attacker, 
     collect(DISTINCT {
         direction: 'OUTGOING',
         relationship: type(r_out),
         target_type: labels(target)[0],
         target_name: target.name,
         original_relation: r_out.original_relation
     }) AS outgoing_rels,
     collect(DISTINCT {
         direction: 'INCOMING', 
         relationship: type(r_in),
         source_type: labels(source)[0],
         source_name: source.name,
         original_relation: r_in.original_relation
     }) AS incoming_rels
RETURN 
    attacker.name AS attacker_name,
    size(outgoing_rels) AS outgoing_count,
    size(incoming_rels) AS incoming_count,
    outgoing_rels,
    incoming_rels;

// ========================================
// 5. ATTACKER RELATIONSHIPS BY TYPE
// ========================================

// Count relationships by type for specific attacker
MATCH (attacker:Attackers {name: 'Black Basta'})-[r]->(target)
RETURN 
    type(r) AS relationship_type,
    count(r) AS count,
    collect(DISTINCT labels(target)[0]) AS target_types,
    collect(target.name)[0..3] AS sample_targets
ORDER BY count DESC;

// ========================================
// 6. FIND MOST CONNECTED ATTACKERS
// ========================================

// Find attackers with most relationships
MATCH (a:Attackers)
OPTIONAL MATCH (a)-[r_out]->()
OPTIONAL MATCH ()-[r_in]->(a)
WITH a, count(r_out) + count(r_in) AS total_connections
WHERE total_connections > 0
RETURN 
    a.name AS attacker_name,
    a.id AS attacker_id,
    total_connections
ORDER BY total_connections DESC
LIMIT 10;

// ========================================
// 7. PARAMETERIZED QUERY FOR ANY ATTACKER
// ========================================

// Use this with parameter: {attacker_name: "RansomHub"}
MATCH (attacker:Attackers)
WHERE attacker.name CONTAINS $attacker_name OR attacker.id = $attacker_name
OPTIONAL MATCH (attacker)-[r_out]->(target)
OPTIONAL MATCH (source)-[r_in]->(attacker)
RETURN 
    attacker.name AS attacker_name,
    attacker.id AS attacker_id,
    // Outgoing relationships
    collect(DISTINCT {
        direction: 'OUTGOING',
        relationship: type(r_out),
        target_type: labels(target)[0],
        target_name: target.name,
        relationship_id: r_out.relationship_id
    }) AS outgoing_relationships,
    // Incoming relationships  
    collect(DISTINCT {
        direction: 'INCOMING',
        relationship: type(r_in),
        source_type: labels(source)[0], 
        source_name: source.name,
        relationship_id: r_in.relationship_id
    }) AS incoming_relationships;

// ========================================
// 8. ATTACKER ATTACK PATTERNS
// ========================================

// Analyze attack patterns - what do attackers typically target/use?
MATCH (a:Attackers)-[r]->(target)
WHERE type(r) IN ['USES', 'TARGETS', 'EXPLOITS']
RETURN 
    a.name AS attacker,
    type(r) AS action,
    labels(target)[0] AS target_type,
    target.name AS target_name
ORDER BY attacker, action;

// ========================================
// 9. ATTACK CHAIN ANALYSIS
// ========================================

// Find potential attack chains (attacker -> tool -> vulnerability)
MATCH (attacker:Attackers)-[:USES]->(tool:Tools)-[:TARGETS|EXPLOITS]->(vuln:Vulnerabilities)
RETURN 
    attacker.name AS attacker,
    tool.name AS tool_used,
    vuln.name AS vulnerability_targeted
ORDER BY attacker;

// ========================================
// 10. SIMPLE QUERY TEMPLATES
// ========================================

// Template 1: All relationships for attacker by name
// MATCH (a:Attackers {name: 'ATTACKER_NAME_HERE'})-[r]->(target)
// RETURN a.name, type(r), target.name;

// Template 2: All relationships for attacker by ID  
// MATCH (a:Attackers {id: 'ATT_ID_HERE'})-[r]->(target)
// RETURN a.name, type(r), target.name;

// Template 3: Count relationships by type
// MATCH (a:Attackers {name: 'ATTACKER_NAME_HERE'})-[r]->()
// RETURN type(r), count(r) ORDER BY count(r) DESC;
