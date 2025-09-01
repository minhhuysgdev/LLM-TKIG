// ========================================
// QUICK START QUERIES - LLM-TIKG Knowledge Graph
// ========================================

// 🎯 QUERIES CƠ BẢN ĐỂ BẮT ĐẦU
// ========================================

// 1. Xem tổng quan graph
MATCH (n)
RETURN labels(n)[0] as NodeType, count(n) as Count
ORDER BY Count DESC;

// 2. Xem một số attackers
MATCH (a:Attackers)
RETURN a.name as AttackerName
LIMIT 10;

// 3. Xem một số malware
MATCH (m:Malware)
RETURN m.name as MalwareName
LIMIT 10;

// 4. Xem một số tools
MATCH (t:Tools)
RETURN t.name as ToolName
LIMIT 10;

// 5. Xem một số vulnerabilities
MATCH (v:Vulnerabilities)
RETURN v.name as VulnerabilityName
LIMIT 10;

// 🔍 EXPLORE SPECIFIC ENTITIES
// ========================================

// 6. Tìm attacker có tên chứa "APT"
MATCH (a:Attackers)
WHERE a.name CONTAINS 'APT'
RETURN a.name as APTGroup;

// 7. Tìm malware có tên chứa "Emotet"
MATCH (m:Malware)
WHERE m.name CONTAINS 'Emotet'
RETURN m.name as EmotetVariants;

// 8. Tìm tools có tên chứa "Cobalt"
MATCH (t:Tools)
WHERE t.name CONTAINS 'Cobalt'
RETURN t.name as CobaltTools;

// 9. Tìm vulnerabilities có tên chứa "CVE"
MATCH (v:Vulnerabilities)
WHERE v.name CONTAINS 'CVE'
RETURN v.name as CVEs;

// 📊 STATISTICS
// ========================================

// 10. Top 5 attackers theo tên
MATCH (a:Attackers)
RETURN a.name as AttackerName
ORDER BY a.name
LIMIT 5;

// 11. Top 5 malware theo tên
MATCH (m:Malware)
RETURN m.name as MalwareName
ORDER BY m.name
LIMIT 5;

// 12. Top 5 tools theo tên
MATCH (t:Tools)
RETURN t.name as ToolName
ORDER BY t.name
LIMIT 5;

// 13. Top 5 vulnerabilities theo tên
MATCH (v:Vulnerabilities)
RETURN v.name as VulnerabilityName
ORDER BY v.name
LIMIT 5;

// 🎨 VISUALIZATION QUERIES
// ========================================

// 14. Xem tất cả nodes (để visualize)
MATCH (n)
RETURN n
LIMIT 100;

// 15. Xem một attacker cụ thể và connections (nếu có)
MATCH (a:Attackers {name: 'APT28'})-[r]-(connected)
RETURN a, r, connected;

// 16. Xem một malware cụ thể và connections (nếu có)
MATCH (m:Malware {name: 'Emotet'})-[r]-(connected)
RETURN m, r, connected;

// 17. Xem tất cả relationships (nếu có)
MATCH ()-[r]-()
RETURN r
LIMIT 50;

// 🔧 UTILITY QUERIES
// ========================================

// 18. Kiểm tra xem có relationships nào không
MATCH ()-[r]-()
RETURN count(r) as TotalRelationships;

// 19. Xem cấu trúc của một node
MATCH (n)
RETURN n.name as Name, labels(n) as Labels, keys(n) as Properties
LIMIT 1;

// 20. Tìm nodes có tên trùng lặp
MATCH (n)
WITH n.name as name, collect(n) as nodes
WHERE size(nodes) > 1
RETURN name, size(nodes) as DuplicateCount;

// 🎯 CUSTOM SEARCH QUERIES
// ========================================

// 21. Tìm tất cả entities có tên chứa "China"
MATCH (n)
WHERE n.name CONTAINS 'China'
RETURN n.name as Name, labels(n)[0] as Type;

// 22. Tìm tất cả entities có tên chứa "Windows"
MATCH (n)
WHERE n.name CONTAINS 'Windows'
RETURN n.name as Name, labels(n)[0] as Type;

// 23. Tìm tất cả entities có tên chứa "Ransomware"
MATCH (n)
WHERE n.name CONTAINS 'Ransomware'
RETURN n.name as Name, labels(n)[0] as Type;

// 24. Tìm tất cả entities có tên chứa "PowerShell"
MATCH (n)
WHERE n.name CONTAINS 'PowerShell'
RETURN n.name as Name, labels(n)[0] as Type;

// 25. Tìm tất cả entities có tên chứa "CVE"
MATCH (n)
WHERE n.name CONTAINS 'CVE'
RETURN n.name as Name, labels(n)[0] as Type;

// 📈 ADVANCED ANALYSIS (khi có relationships)
// ========================================

// 26. Tìm nodes có nhiều connections nhất (nếu có relationships)
MATCH (n)-[r]-()
RETURN n.name as NodeName, labels(n)[0] as NodeType, count(r) as Connections
ORDER BY Connections DESC
LIMIT 10;

// 27. Tìm relationships theo type (nếu có)
MATCH ()-[r:RELATES_TO]->()
RETURN r.type as RelationshipType, count(r) as Count
ORDER BY Count DESC;

// 28. Tìm path giữa 2 nodes (nếu có relationships)
MATCH path = shortestPath((start:Attackers)-[*]-(end:Malware))
WHERE start.name = 'APT28' AND end.name = 'Emotet'
RETURN path;

// 🎨 STYLING QUERIES (cho Neo4j Browser)
// ========================================

// 29. Set colors cho nodes (chạy từng query một)
MATCH (n:Attackers) SET n.color = '#FF8C42';
MATCH (n:Malware) SET n.color = '#6BCF7F';
MATCH (n:Tools) SET n.color = '#A0956C';
MATCH (n:Vulnerabilities) SET n.color = '#F7B2BD';
MATCH (n:Files) SET n.color = '#4D9DE0';
MATCH (n:Hashes) SET n.color = '#E15554';

// 30. Set node sizes theo connections (nếu có relationships)
MATCH (n)-[r]-()
WITH n, count(r) as connections
SET n.size = connections * 2;

// 31. Set default node size cho nodes không có connections
MATCH (n)
WHERE NOT EXISTS(n.size)
SET n.size = 1;
