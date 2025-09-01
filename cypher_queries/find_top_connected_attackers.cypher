// ========================================
// FIND ATTACKERS WITH MOST RELATIONSHIPS
// ========================================

// 1. Count all relationships per attacker (both incoming and outgoing)
MATCH (a:Attackers)
OPTIONAL MATCH (a)-[r_out]->()
OPTIONAL MATCH ()-[r_in]->(a)
WITH a, 
     count(DISTINCT r_out) AS outgoing_count,
     count(DISTINCT r_in) AS incoming_count,
     count(DISTINCT r_out) + count(DISTINCT r_in) AS total_relationships
WHERE total_relationships > 0
RETURN 
    a.name AS attacker_name,
    a.id AS attacker_id,
    outgoing_count,
    incoming_count,
    total_relationships
ORDER BY total_relationships DESC, outgoing_count DESC
LIMIT 10;

// ========================================
// 2. DETAILED VIEW FOR TOP 3 ATTACKERS
// ========================================

// Get detailed relationships for top attackers
MATCH (a:Attackers)
OPTIONAL MATCH (a)-[r_out]->(target)
OPTIONAL MATCH (source)-[r_in]->(a)
WITH a, 
     count(DISTINCT r_out) + count(DISTINCT r_in) AS total_relationships,
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
WHERE total_relationships > 0
RETURN 
    a.name AS attacker_name,
    total_relationships,
    size([r IN outgoing_rels WHERE r.relationship IS NOT NULL]) AS outgoing_count,
    size([r IN incoming_rels WHERE r.relationship IS NOT NULL]) AS incoming_count,
    outgoing_rels,
    incoming_rels
ORDER BY total_relationships DESC
LIMIT 3;

// ========================================
// 3. TOP ATTACKERS BY OUTGOING RELATIONSHIPS ONLY
// ========================================

MATCH (a:Attackers)-[r]->()
WITH a, count(r) AS outgoing_relationships
WHERE outgoing_relationships > 0
RETURN 
    a.name AS attacker_name,
    outgoing_relationships,
    collect(DISTINCT type(r)) AS relationship_types
ORDER BY outgoing_relationships DESC
LIMIT 10;

// ========================================
// 4. TOP ATTACKERS BY INCOMING RELATIONSHIPS ONLY
// ========================================

MATCH ()-[r]->(a:Attackers)
WITH a, count(r) AS incoming_relationships
WHERE incoming_relationships > 0
RETURN 
    a.name AS attacker_name,
    incoming_relationships,
    collect(DISTINCT type(r)) AS relationship_types
ORDER BY incoming_relationships DESC
LIMIT 10;

// ========================================
// 5. RELATIONSHIP NETWORK FOR MALWARE (TOP ATTACKER)
// ========================================

// Show complete network for "Malware" attacker
MATCH (a:Attackers {name: 'Malware'})
OPTIONAL MATCH (a)-[r_out]->(target)
OPTIONAL MATCH (source)-[r_in]->(a)
RETURN 
    'OUTGOING RELATIONSHIPS' AS section,
    collect(DISTINCT {
        relationship: type(r_out),
        target: target.name,
        target_type: labels(target)[0],
        description: r_out.original_relation
    }) AS details
WHERE EXISTS((a)-[]->())

UNION ALL

SELECT 
    'INCOMING RELATIONSHIPS' AS section,
    collect(DISTINCT {
        relationship: type(r_in),
        source: source.name,
        source_type: labels(source)[0],
        description: r_in.original_relation
    }) AS details
WHERE EXISTS(()-[]->(a));

// ========================================
// 6. ANALYZE RELATIONSHIP TYPES
// ========================================

// Count most common relationship types
MATCH ()-[r]->()
WHERE EXISTS(()-[:*1]-(a:Attackers))
RETURN 
    type(r) AS relationship_type,
    count(r) AS total_count,
    // Count how many involve attackers
    size([(start)-[rel]->(end) WHERE type(rel) = type(r) AND 
          (start:Attackers OR end:Attackers) | rel]) AS attacker_involved_count
ORDER BY attacker_involved_count DESC, total_count DESC
LIMIT 15;

// ========================================
// 7. FIND MOST ACTIVE ATTACKERS (BY RELATIONSHIP DIVERSITY)
// ========================================

// Attackers with most diverse relationship types
MATCH (a:Attackers)-[r]->()
WITH a, collect(DISTINCT type(r)) AS relationship_types
WHERE size(relationship_types) > 0
RETURN 
    a.name AS attacker_name,
    size(relationship_types) AS relationship_type_diversity,
    relationship_types
ORDER BY relationship_type_diversity DESC
LIMIT 10;

// ========================================
// 8. VERIFICATION: CHECK FOR SPECIFIC ATTACKERS
// ========================================

// Verify RansomHub relationships
MATCH (a:Attackers {name: 'RansomHub'})
OPTIONAL MATCH (a)-[r_out]->(target)
OPTIONAL MATCH (source)-[r_in]->(a)
RETURN 
    a.name AS attacker,
    'OUTGOING' AS direction,
    collect(DISTINCT type(r_out) + ' → ' + target.name) AS relationships
WHERE EXISTS((a)-[]->())

UNION ALL

SELECT 
    a.name AS attacker,
    'INCOMING' AS direction,
    collect(DISTINCT source.name + ' → ' + type(r_in)) AS relationships
WHERE EXISTS(()-[]->(a));

// ========================================
// 9. SIMPLE QUERIES FOR COPY-PASTE
// ========================================

// Quick check - top 5 connected attackers:
// MATCH (a:Attackers) OPTIONAL MATCH (a)-[r1]->() OPTIONAL MATCH ()-[r2]->(a) WITH a, count(r1)+count(r2) AS total WHERE total > 0 RETURN a.name, total ORDER BY total DESC LIMIT 5;

// Get all relationships for specific attacker:
// MATCH (a:Attackers {name: 'ATTACKER_NAME'})-[r]->(t) RETURN type(r), t.name;

// Find attackers with specific relationship type:
// MATCH (a:Attackers)-[r:USES]->() RETURN a.name, count(r) ORDER BY count(r) DESC;
