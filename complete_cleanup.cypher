// ========================================
// 🗑️ COMPLETE CLEANUP - Remove Everything
// ========================================

// 1. Check current state
MATCH (n) 
OPTIONAL MATCH ()-[r]->()
RETURN count(DISTINCT n) as nodes, count(DISTINCT r) as relationships;

// 2. Delete all nodes and relationships (force delete)
MATCH (n) DETACH DELETE n;

// 3. Drop all constraints
CALL apoc.schema.assert({},{}) YIELD label, key
RETURN label, key;

// Alternative if APOC not available - drop constraints manually:
// SHOW CONSTRAINTS;
// Copy constraint names and drop them:
// DROP CONSTRAINT constraint_name_here;

// 4. Drop all indexes  
CALL apoc.schema.assert({},{}) YIELD label, key
RETURN label, key;

// Alternative if APOC not available - drop indexes manually:
// SHOW INDEXES;
// Copy index names and drop them:
// DROP INDEX index_name_here;

// 5. Verify complete cleanup
MATCH (n) RETURN count(n) as remaining_nodes;

CALL db.labels() YIELD label RETURN count(label) as remaining_labels;

CALL db.relationshipTypes() YIELD relationshipType 
RETURN count(relationshipType) as remaining_relationship_types;

// ========================================
// SIMPLE VERSION (if above doesn't work)
// ========================================

// Force delete everything
MATCH (n) DETACH DELETE n;

// Check if empty
MATCH (n) RETURN count(n) as nodes_left;

// If still showing labels, try:
CALL db.schema.visualization();

// ========================================
// MANUAL CLEANUP COMMANDS
// ========================================

// If schema still shows, run these individually:

// Delete all Attackers
MATCH (n:Attackers) DETACH DELETE n;

// Delete all Malware  
MATCH (n:Malware) DETACH DELETE n;

// Delete all Tools
MATCH (n:Tools) DETACH DELETE n;

// Delete all Vulnerabilities
MATCH (n:Vulnerabilities) DETACH DELETE n;

// Delete all Files
MATCH (n:Files) DETACH DELETE n;

// Delete all Hashes
MATCH (n:Hashes) DETACH DELETE n;

// Delete all Ips
MATCH (n:Ips) DETACH DELETE n;

// Delete all Urls
MATCH (n:Urls) DETACH DELETE n;

// Delete all Devices
MATCH (n:Devices) DETACH DELETE n;

// Delete all Techniques
MATCH (n:Techniques) DETACH DELETE n;

// Final verification
MATCH (n) RETURN count(n) as final_count;
