// ========================================
// TEST: GET ALL RELATIONSHIPS FOR BLACK BASTA
// ========================================

// 1. First check if Black Basta exists in database
MATCH (a:Attackers)
WHERE a.name CONTAINS 'Black Basta' OR a.id = 'ATT9'
RETURN a.id, a.name;

// ========================================
// 2. GET ALL OUTGOING RELATIONSHIPS
// ========================================

MATCH (attacker:Attackers {name: 'Black Basta'})-[r]->(target)
RETURN 
    '🎯 Black Basta' AS attacker,
    type(r) AS relationship_type,
    labels(target)[0] AS target_type,
    target.name AS target_name,
    r.original_relation AS original_description
ORDER BY relationship_type, target_type;

// ========================================
// 3. GET INCOMING RELATIONSHIPS 
// ========================================

MATCH (source)-[r]->(attacker:Attackers {name: 'Black Basta'})
RETURN 
    labels(source)[0] AS source_type,
    source.name AS source_name,
    type(r) AS relationship_type,
    '🎯 Black Basta' AS target,
    r.original_relation AS original_description
ORDER BY relationship_type, source_type;

// ========================================
// 4. COMPLETE NETWORK VIEW
// ========================================

MATCH (attacker:Attackers {name: 'Black Basta'})
OPTIONAL MATCH (attacker)-[r_out]->(target)
OPTIONAL MATCH (source)-[r_in]->(attacker)
RETURN 
    attacker.name AS attacker_name,
    
    // Outgoing relationships
    collect(DISTINCT {
        direction: '➡️ OUTGOING',
        relationship: type(r_out),
        target_type: labels(target)[0],
        target_name: target.name,
        description: r_out.original_relation
    }) AS what_black_basta_does,
    
    // Incoming relationships  
    collect(DISTINCT {
        direction: '⬅️ INCOMING',
        relationship: type(r_in),
        source_type: labels(source)[0],
        source_name: source.name,
        description: r_in.original_relation
    }) AS what_others_do_to_black_basta;

// ========================================
// 5. SUMMARY STATISTICS
// ========================================

MATCH (attacker:Attackers {name: 'Black Basta'})
OPTIONAL MATCH (attacker)-[r_out]->()
OPTIONAL MATCH ()-[r_in]->(attacker)
RETURN 
    attacker.name AS attacker,
    count(DISTINCT r_out) AS outgoing_relationships,
    count(DISTINCT r_in) AS incoming_relationships,
    count(DISTINCT r_out) + count(DISTINCT r_in) AS total_connections;

// ========================================
// 6. RELATIONSHIP TYPES BREAKDOWN
// ========================================

MATCH (attacker:Attackers {name: 'Black Basta'})-[r]->()
RETURN 
    type(r) AS relationship_type,
    count(r) AS count,
    collect(r.original_relation) AS original_descriptions
ORDER BY count DESC;

// ========================================
// 7. WHAT BLACK BASTA ATTACKS/USES
// ========================================

MATCH (attacker:Attackers {name: 'Black Basta'})-[r]->(target)
WHERE type(r) IN ['USES', 'TARGETS', 'EXPLOITS', 'OPERATES']
RETURN 
    type(r) AS action_type,
    labels(target)[0] AS target_category,
    target.name AS target_name,
    r.original_relation AS how
ORDER BY action_type, target_category;

// ========================================
// 8. SIMPLE ONE-LINER FOR COPY-PASTE
// ========================================

// Just copy this single line to Neo4j Browser:
MATCH (a:Attackers {name: 'Black Basta'})-[r]->(t) RETURN a.name, type(r), labels(t)[0], t.name;

// ========================================
// 9. ALTERNATIVE BY ID
// ========================================

// If name doesn't work, try by ID:
MATCH (a:Attackers {id: 'ATT9'})-[r]->(t) RETURN a.name, type(r), labels(t)[0], t.name;
