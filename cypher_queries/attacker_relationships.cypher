// ========================================
// ATTACKER RELATIONSHIPS - LLM-TIKG Knowledge Graph
// ========================================

// 🎯 ATTACKER TO OTHER ENTITIES
// ========================================
// Attacker → Tools
MATCH (source:Attackers {id: 'ATT16'})
MATCH (target:Tools {id: 'TOO61'})
CREATE (source)-[:RELATES_TO {id: 'REL94', type: 'targets'}]->(target);
MATCH (source:Attackers {id: 'ATT16'})
MATCH (target:Tools {id: 'TOO122'})
CREATE (source)-[:RELATES_TO {id: 'REL95', type: 'uses'}]->(target);
MATCH (source:Attackers {id: 'ATT16'})
MATCH (target:Tools {id: 'TOO195'})
CREATE (source)-[:RELATES_TO {id: 'REL99', type: 'uses'}]->(target);
MATCH (source:Attackers {id: 'ATT16'})
MATCH (target:Tools {id: 'TOO182'})
CREATE (source)-[:RELATES_TO {id: 'REL100', type: 'uses'}]->(target);
MATCH (source:Attackers {id: 'ATT16'})
MATCH (target:Tools {id: 'TOO115'})
CREATE (source)-[:RELATES_TO {id: 'REL101', type: 'uses'}]->(target);
MATCH (source:Attackers {id: 'ATT16'})
MATCH (target:Tools {id: 'TOO213'})
CREATE (source)-[:RELATES_TO {id: 'REL102', type: 'uses'}]->(target);
MATCH (source:Attackers {id: 'ATT13'})
MATCH (target:Tools {id: 'TOO41'})
CREATE (source)-[:RELATES_TO {id: 'REL159', type: 'targets'}]->(target);
MATCH (source:Attackers {id: 'ATT13'})
MATCH (target:Tools {id: 'TOO42'})
CREATE (source)-[:RELATES_TO {id: 'REL160', type: 'affects'}]->(target);
MATCH (source:Attackers {id: 'ATT13'})
MATCH (target:Tools {id: 'TOO60'})
CREATE (source)-[:RELATES_TO {id: 'REL161', type: 'has severity level'}]->(target);
MATCH (source:Attackers {id: 'ATT11'})
MATCH (target:Tools {id: 'TOO24'})
CREATE (source)-[:RELATES_TO {id: 'REL167', type: 'uses'}]->(target);
MATCH (source:Attackers {id: 'ATT11'})
MATCH (target:Tools {id: 'TOO201'})
CREATE (source)-[:RELATES_TO {id: 'REL168', type: 'uses'}]->(target);
MATCH (source:Attackers {id: 'ATT23'})
MATCH (target:Tools {id: 'TOO228'})
CREATE (source)-[:RELATES_TO {id: 'REL193', type: 'has handle'}]->(target);
MATCH (source:Attackers {id: 'ATT21'})
MATCH (target:Tools {id: 'TOO237'})
CREATE (source)-[:RELATES_TO {id: 'REL226', type: 'aka'}]->(target);
MATCH (source:Attackers {id: 'ATT24'})
MATCH (target:Tools {id: 'TOO192'})
CREATE (source)-[:RELATES_TO {id: 'REL345', type: 'uses'}]->(target);
MATCH (source:Attackers {id: 'ATT24'})
MATCH (target:Tools {id: 'TOO223'})
CREATE (source)-[:RELATES_TO {id: 'REL347', type: 'uses'}]->(target);
MATCH (source:Attackers {id: 'ATT6'})
MATCH (target:Tools {id: 'TOO11'})
CREATE (source)-[:RELATES_TO {id: 'REL522', type: 'issues'}]->(target);

// Attacker → Malware
MATCH (source:Attackers {id: 'ATT16'})
MATCH (target:Malware {id: 'MAL44'})
CREATE (source)-[:RELATES_TO {id: 'REL96', type: 'uses'}]->(target);
MATCH (source:Attackers {id: 'ATT16'})
MATCH (target:Malware {id: 'MAL50'})
CREATE (source)-[:RELATES_TO {id: 'REL97', type: 'uses'}]->(target);
MATCH (source:Attackers {id: 'ATT16'})
MATCH (target:Malware {id: 'MAL74'})
CREATE (source)-[:RELATES_TO {id: 'REL98', type: 'uses'}]->(target);
MATCH (source:Attackers {id: 'ATT13'})
MATCH (target:Malware {id: 'MAL128'})
CREATE (source)-[:RELATES_TO {id: 'REL169', type: 'detect'}]->(target);
MATCH (source:Attackers {id: 'ATT13'})
MATCH (target:Malware {id: 'MAL22'})
CREATE (source)-[:RELATES_TO {id: 'REL170', type: 'detect'}]->(target);
MATCH (source:Attackers {id: 'ATT21'})
MATCH (target:Malware {id: 'MAL114'})
CREATE (source)-[:RELATES_TO {id: 'REL227', type: 'deploys'}]->(target);

// Attacker → Vulnerabilities
MATCH (source:Attackers {id: 'ATT13'})
MATCH (target:Vulnerabilities {id: 'VUL1'})
CREATE (source)-[:RELATES_TO {id: 'REL162', type: 'related to'}]->(target);

// Attacker → Files
MATCH (source:Attackers {id: 'ATT24'})
MATCH (target:Files {id: 'FIL152'})
CREATE (source)-[:RELATES_TO {id: 'REL346', type: 'downloads'}]->(target);

// 🎯 OTHER ENTITIES TO ATTACKER
// ========================================
// Malware → Attacker
MATCH (source:Malware {id: 'MAL96'})
MATCH (target:Attackers {id: 'ATT1'})
CREATE (source)-[:RELATES_TO {id: 'REL46', type: 'associated with'}]->(target);
MATCH (source:Malware {id: 'MAL128'})
MATCH (target:Attackers {id: 'ATT22'})
CREATE (source)-[:RELATES_TO {id: 'REL173', type: 'uses'}]->(target);
MATCH (source:Malware {id: 'MAL52'})
MATCH (target:Attackers {id: 'ATT25'})
CREATE (source)-[:RELATES_TO {id: 'REL402', type: 'used by'}]->(target);

// Tools → Attacker
MATCH (source:Tools {id: 'TOO192'})
MATCH (target:Attackers {id: 'ATT1'})
CREATE (source)-[:RELATES_TO {id: 'REL55', type: 'associated with'}]->(target);
MATCH (source:Tools {id: 'TOO188'})
MATCH (target:Attackers {id: 'ATT9'})
CREATE (source)-[:RELATES_TO {id: 'REL178', type: 'associated with'}]->(target);
MATCH (source:Tools {id: 'TOO188'})
MATCH (target:Attackers {id: 'ATT26'})
CREATE (source)-[:RELATES_TO {id: 'REL179', type: 'associated with'}]->(target);
MATCH (source:Tools {id: 'TOO101'})
MATCH (target:Attackers {id: 'ATT9'})
CREATE (source)-[:RELATES_TO {id: 'REL180', type: 'associated with'}]->(target);
MATCH (source:Tools {id: 'TOO19'})
MATCH (target:Attackers {id: 'ATT2'})
CREATE (source)-[:RELATES_TO {id: 'REL269', type: 'uses'}]->(target);
MATCH (source:Tools {id: 'TOO223'})
MATCH (target:Attackers {id: 'ATT24'})
CREATE (source)-[:RELATES_TO {id: 'REL344', type: 'used by'}]->(target);
MATCH (source:Tools {id: 'TOO98'})
MATCH (target:Attackers {id: 'ATT10'})
CREATE (source)-[:RELATES_TO {id: 'REL502', type: 'uses'}]->(target);
MATCH (source:Tools {id: 'TOO98'})
MATCH (target:Attackers {id: 'ATT3'})
CREATE (source)-[:RELATES_TO {id: 'REL505', type: 'uses'}]->(target);
MATCH (source:Tools {id: 'TOO98'})
MATCH (target:Attackers {id: 'ATT4'})
CREATE (source)-[:RELATES_TO {id: 'REL534', type: 'targets'}]->(target);

// 🎯 VERIFICATION QUERIES
// ========================================

// Tổng số attacker relationships
MATCH (a:Attackers)-[r:RELATES_TO]-()
RETURN count(r) as AttackerRelationships;

// Attacker relationships theo loại
MATCH (a:Attackers)-[r:RELATES_TO]->(target)
RETURN a.name as Attacker, r.type as Relation, target.name as Target, labels(target)[0] as TargetType
ORDER BY a.name;

// Top attackers có nhiều connections
MATCH (a:Attackers)-[r:RELATES_TO]-()
RETURN a.name as Attacker, count(r) as Connections
ORDER BY Connections DESC
LIMIT 10;