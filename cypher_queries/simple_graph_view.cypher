// ========================================
// 📊 SIMPLE GRAPH VISUALIZATION QUERIES
// ========================================
// Guaranteed to show graph in Neo4j Browser

// ========================================
// 1. SIMPLEST GRAPH VIEW
// ========================================

// Show any connected nodes
MATCH (n)-[r]-(m)
RETURN n, r, m
LIMIT 10;

// ========================================
// 2. CHECK IF DATA EXISTS
// ========================================

// Count all data
MATCH (n) RETURN count(n) as nodes;
MATCH ()-[r]->() RETURN count(r) as relationships;

// ========================================
// 3. SHOW ALL NODE TYPES
// ========================================

// Get one example of each entity type
MATCH (a:Attackers) WITH a LIMIT 1
MATCH (m:Malware) WITH a, m LIMIT 1  
MATCH (t:Tools) WITH a, m, t LIMIT 1
RETURN a, m, t;

// ========================================
// 4. BASIC RELATIONSHIP VIEW
// ========================================

// Show basic relationships
MATCH (source)-[r]->(target)
WHERE id(source) < 50 AND id(target) < 50
RETURN source, r, target
LIMIT 15;

// ========================================
// 5. ATTACKERS NETWORK
// ========================================

// Show attacker connections (if any exist)
MATCH (att:Attackers)
OPTIONAL MATCH (att)-[r]-(connected)
RETURN att, r, connected
LIMIT 20;

// ========================================
// 6. FORCE GRAPH VIEW
// ========================================

// Create temporary relationships to test
CREATE (a:Test {name: 'Node A'})
CREATE (b:Test {name: 'Node B'})  
CREATE (c:Test {name: 'Node C'})
CREATE (a)-[:CONNECTS]->(b)
CREATE (b)-[:CONNECTS]->(c)
CREATE (c)-[:CONNECTS]->(a)
RETURN a, b, c;

// Clean up test nodes
// MATCH (n:Test) DETACH DELETE n;

// ========================================
// 7. STEP BY STEP DEBUG
// ========================================

// Step 1: Check if any nodes exist
MATCH (n) RETURN n LIMIT 5;

// Step 2: Check if any relationships exist  
MATCH ()-[r]->() RETURN r LIMIT 5;

// Step 3: Show connected pairs
MATCH (a)-[r]->(b) RETURN a, r, b LIMIT 5;

// ========================================
// 8. MANUAL GRAPH CONSTRUCTION
// ========================================

// If no relationships exist, create sample data
MERGE (attacker:Attackers {name: 'Sample Attacker', id: 'ATT999'})
MERGE (malware:Malware {name: 'Sample Malware', id: 'MAL999'})
MERGE (tool:Tools {name: 'Sample Tool', id: 'TOO999'})

MERGE (attacker)-[:USES]->(tool)
MERGE (attacker)-[:DEVELOPS]->(malware)
MERGE (tool)-[:DEPLOYS]->(malware)

RETURN attacker, malware, tool;

// ========================================
// 9. GUARANTEED VISUALIZATION
// ========================================

// This WILL show a graph (creates nodes if needed)
MERGE (center:Demo {name: 'Center Node'})
MERGE (node1:Demo {name: 'Node 1'})
MERGE (node2:Demo {name: 'Node 2'}) 
MERGE (node3:Demo {name: 'Node 3'})

MERGE (center)-[:CONNECTS_TO]->(node1)
MERGE (center)-[:CONNECTS_TO]->(node2)
MERGE (center)-[:CONNECTS_TO]->(node3)
MERGE (node1)-[:LINKS]->(node2)

MATCH (demo:Demo)-[r]-(connected:Demo)
RETURN demo, r, connected;

// Clean up demo nodes when done:
// MATCH (n:Demo) DETACH DELETE n;
