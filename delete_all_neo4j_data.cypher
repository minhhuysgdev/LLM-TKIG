// ========================================
// 🗑️ DELETE ALL NEO4J DATA - SIMPLE SCRIPT
// ========================================
// Copy and paste these commands into Neo4j Browser

// ========================================
// 1. PREVIEW DATA BEFORE DELETION
// ========================================

// Count all nodes and relationships
MATCH (n) 
OPTIONAL MATCH ()-[r]->()
RETURN count(DISTINCT n) as total_nodes, count(DISTINCT r) as total_relationships;

// ========================================
// 2. ⚠️ DELETE EVERYTHING (ONE COMMAND)
// ========================================

// 🚨 WARNING: This will DELETE ALL data permanently!
MATCH (n) DETACH DELETE n;

// ========================================
// 3. VERIFY DELETION
// ========================================

// Check if database is empty (should return 0, 0)
MATCH (n) 
OPTIONAL MATCH ()-[r]->()
RETURN count(n) as remaining_nodes, count(r) as remaining_relationships;

// ========================================
// 4. ALTERNATIVE: DELETE IN BATCHES (for large databases)
// ========================================

// Delete relationships first (run multiple times until 0)
MATCH ()-[r]->()
WITH r LIMIT 10000
DELETE r
RETURN count(r) as deleted_relationships;

// Then delete nodes (run multiple times until 0)
MATCH (n)
WITH n LIMIT 10000
DELETE n  
RETURN count(n) as deleted_nodes;

// ========================================
// 5. QUICK REFERENCE
// ========================================

/*
🎯 MAIN COMMAND (copy this to Neo4j Browser):

MATCH (n) DETACH DELETE n;

This deletes everything in one go!
*/
