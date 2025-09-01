// ========================================
// LLM-TIKG Knowledge Graph Analysis Queries
// ========================================

// 1. TỔNG QUAN GRAPH
// ========================================
// Đếm tổng số nodes theo loại
MATCH (n)
RETURN labels(n)[0] as NodeType, count(n) as Count
ORDER BY Count DESC;

// Đếm tổng số relationships
MATCH ()-[r]-()
RETURN count(r) as TotalRelationships;

// 2. TOP NODES THEO CONNECTIONS
// ========================================
// Top 10 nodes có nhiều connections nhất
MATCH (n)-[r]-()
RETURN n.name as NodeName, labels(n)[0] as NodeType, count(r) as Connections
ORDER BY Connections DESC
LIMIT 10;

// Top attackers có nhiều connections
MATCH (n:Attackers)-[r]-()
RETURN n.name as Attacker, count(r) as Connections
ORDER BY Connections DESC
LIMIT 10;

// Top malware có nhiều connections  
MATCH (n:Malware)-[r]-()
RETURN n.name as Malware, count(r) as Connections
ORDER BY Connections DESC
LIMIT 10;

// 3. RELATIONSHIP ANALYSIS
// ========================================
// Phân tích relationships theo loại
MATCH ()-[r:RELATES_TO]->()
RETURN r.type as RelationshipType, count(r) as Count
ORDER BY Count DESC;

// Relationships giữa các loại nodes
MATCH (a)-[r:RELATES_TO]->(b)
RETURN labels(a)[0] as SourceType, labels(b)[0] as TargetType, count(r) as Count
ORDER BY Count DESC;

// 4. PATH ANALYSIS
// ========================================
// Tìm path ngắn nhất giữa 2 nodes
MATCH path = shortestPath((start:Attackers {name: 'APT28'})-[*]-(end:Malware {name: 'Emotet'}))
RETURN path;

// Tìm tất cả paths có độ dài <= 3
MATCH path = (start:Attackers)-[*1..3]-(end:Malware)
RETURN start.name as StartNode, end.name as EndNode, length(path) as PathLength
ORDER BY PathLength;

// 5. COMMUNITY DETECTION
// ========================================
// Tìm nodes có cùng pattern connections
MATCH (n)-[r]-()
WITH n, collect(type(r)) as connectionTypes
RETURN n.name as NodeName, labels(n)[0] as NodeType, connectionTypes
ORDER BY size(connectionTypes) DESC
LIMIT 20;

// 6. SPECIFIC ENTITY EXPLORATION
// ========================================
// Explore một attacker cụ thể
MATCH (attacker:Attackers {name: 'APT28'})-[r]-(connected)
RETURN attacker, r, connected
LIMIT 50;

// Explore một malware cụ thể
MATCH (malware:Malware {name: 'Emotet'})-[r]-(connected)
RETURN malware, r, connected
LIMIT 50;

// 7. VULNERABILITY ANALYSIS
// ========================================
// Tìm vulnerabilities liên quan đến nhiều malware
MATCH (vuln:Vulnerabilities)-[r]-(malware:Malware)
RETURN vuln.name as Vulnerability, count(malware) as RelatedMalware
ORDER BY RelatedMalware DESC;

// 8. TOOL USAGE ANALYSIS
// ========================================
// Tìm tools được sử dụng bởi nhiều attackers
MATCH (tool:Tools)-[r]-(attacker:Attackers)
RETURN tool.name as Tool, count(attacker) as UsedByAttackers
ORDER BY UsedByAttackers DESC
LIMIT 10;

// 9. GRAPH VISUALIZATION QUERIES
// ========================================
// Subgraph cho một attacker và connections
MATCH (attacker:Attackers {name: 'APT28'})-[r]-(connected)
RETURN attacker, r, connected;

// Subgraph cho một malware family
MATCH (malware:Malware)-[r]-(related)
WHERE malware.name CONTAINS 'Emotet'
RETURN malware, r, related;

// Subgraph cho vulnerabilities và affected systems
MATCH (vuln:Vulnerabilities)-[r]-(affected)
RETURN vuln, r, affected
LIMIT 100;

// 10. STATISTICAL ANALYSIS
// ========================================
// Distribution của node degrees
MATCH (n)-[r]-()
WITH n, count(r) as degree
RETURN labels(n)[0] as NodeType, 
       avg(degree) as AvgDegree,
       max(degree) as MaxDegree,
       min(degree) as MinDegree;

// 11. TEMPORAL ANALYSIS (nếu có timestamp)
// ========================================
// Phân tích theo thời gian (nếu có field timestamp)
MATCH (n)
WHERE n.timestamp IS NOT NULL
RETURN labels(n)[0] as NodeType, 
       n.timestamp as Time,
       count(n) as Count
ORDER BY Time;

// 12. GEOGRAPHICAL ANALYSIS (nếu có location)
// ========================================
// Phân tích theo địa lý (nếu có field location)
MATCH (n)
WHERE n.location IS NOT NULL
RETURN labels(n)[0] as NodeType,
       n.location as Location,
       count(n) as Count
ORDER BY Count DESC;

// 13. COMPLEX PATTERNS
// ========================================
// Tìm attack chains (attacker -> tool -> malware -> target)
MATCH path = (attacker:Attackers)-[:RELATES_TO]->(tool:Tools)-[:RELATES_TO]->(malware:Malware)-[:RELATES_TO]->(target)
RETURN attacker.name as Attacker, 
       tool.name as Tool, 
       malware.name as Malware,
       target.name as Target;

// Tìm shared infrastructure
MATCH (a)-[:RELATES_TO]->(shared)<-[:RELATES_TO]-(b)
WHERE a <> b
RETURN a.name as Entity1, 
       labels(a)[0] as Type1,
       shared.name as SharedResource,
       labels(shared)[0] as SharedType,
       b.name as Entity2,
       labels(b)[0] as Type2;

// 14. RECOMMENDATION QUERIES
// ========================================
// Tìm similar attackers (dựa trên shared tools/malware)
MATCH (a1:Attackers)-[:RELATES_TO]->(shared)<-[:RELATES_TO]-(a2:Attackers)
WHERE a1 <> a2
RETURN a1.name as Attacker1, 
       a2.name as Attacker2,
       count(shared) as SharedResources
ORDER BY SharedResources DESC;

// Tìm potential threats (malware chưa được connect với attackers)
MATCH (malware:Malware)
WHERE NOT EXISTS((malware)-[:RELATES_TO]-())
RETURN malware.name as UnconnectedMalware;

// 15. CLEANUP QUERIES (nếu cần)
// ========================================
// Xóa duplicate relationships
MATCH (a)-[r1:RELATES_TO]->(b), (a)-[r2:RELATES_TO]->(b)
WHERE r1 <> r2
DELETE r2;

// Xóa nodes không có connections
MATCH (n)
WHERE NOT EXISTS((n)-[]-())
DELETE n;
