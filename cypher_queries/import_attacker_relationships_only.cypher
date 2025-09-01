// ========================================
// IMPORT ATTACKER RELATIONSHIPS ONLY - LLM-TIKG Knowledge Graph
// ========================================

// 🎯 IMPORT CHỈ ATTACKER RELATIONSHIPS
// ========================================

// Bước 1: Kiểm tra attacker relationships CSV
LOAD CSV WITH HEADERS FROM 'file:///attacker_relationships.csv' AS row
RETURN count(row) as AttackerRelationships;

// Bước 2: Import attacker relationships (chạy query này)
LOAD CSV WITH HEADERS FROM 'file:///attacker_relationships.csv' AS row
MATCH (source {id: row.source_id})
MATCH (target {id: row.target_id})
CREATE (source)-[:RELATES_TO {
    id: row.id,
    type: row.relation,
    source_name: row.source_name,
    target_name: row.target_name
}]->(target);

// Bước 3: Kiểm tra kết quả
MATCH (a:Attackers)-[r:RELATES_TO]-()
RETURN count(r) as AttackerRelationshipsCreated;

// Bước 4: Xem attacker relationships mẫu
MATCH (a:Attackers)-[r:RELATES_TO]->(target)
RETURN a.name as Attacker, 
       r.type as Relation, 
       target.name as Target,
       labels(target)[0] as TargetType
ORDER BY a.name
LIMIT 10;

// Bước 5: Phân tích attacker relationships theo loại
MATCH (a:Attackers)-[r:RELATES_TO]->()
RETURN r.type as RelationType, count(r) as Count
ORDER BY Count DESC;

// Bước 6: Top attackers có nhiều connections
MATCH (a:Attackers)-[r:RELATES_TO]-()
RETURN a.name as Attacker, count(r) as Connections
ORDER BY Connections DESC
LIMIT 10;

// Bước 7: Tìm attack chains (Attacker -> Tool -> Malware)
MATCH path = (attacker:Attackers)-[:RELATES_TO]->(tool:Tools)-[:RELATES_TO]->(malware:Malware)
RETURN attacker.name as Attacker, 
       tool.name as Tool, 
       malware.name as Malware
LIMIT 10;
