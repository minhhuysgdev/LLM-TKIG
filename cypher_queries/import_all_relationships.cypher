// ========================================
// IMPORT ALL RELATIONSHIPS - LLM-TIKG Knowledge Graph
// ========================================

// 🎯 IMPORT TẤT CẢ RELATIONSHIPS TỪ CSV
// ========================================

// Bước 1: Kiểm tra CSV có bao nhiêu relationships
LOAD CSV WITH HEADERS FROM 'file:///relationships_norm.csv' AS row
RETURN count(row) as TotalRelationships;

// Bước 2: Import tất cả relationships (chạy query này)
LOAD CSV WITH HEADERS FROM 'file:///relationships_norm.csv' AS row
MATCH (source {id: row.source_id})
MATCH (target {id: row.target_id})
CREATE (source)-[:RELATES_TO {
    id: row.id,
    type: row.relation,
    source_name: row.source_name,
    target_name: row.target_name
}]->(target);

// Bước 3: Kiểm tra kết quả
MATCH ()-[r:RELATES_TO]->()
RETURN count(r) as TotalRelationshipsCreated;

// Bước 4: Xem một số relationships mẫu
MATCH ()-[r:RELATES_TO]->()
RETURN startNode(r).name as Source, 
       r.type as Relation, 
       endNode(r).name as Target,
       labels(startNode(r))[0] as SourceType,
       labels(endNode(r))[0] as TargetType
LIMIT 10;

// Bước 5: Phân tích relationships theo loại
MATCH ()-[r:RELATES_TO]->()
RETURN r.type as RelationType, count(r) as Count
ORDER BY Count DESC;

// Bước 6: Kiểm tra relationships theo node types
MATCH (a)-[r:RELATES_TO]->(b)
RETURN labels(a)[0] as SourceType, 
       labels(b)[0] as TargetType, 
       count(r) as Count
ORDER BY Count DESC;
