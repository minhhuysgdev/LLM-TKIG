// ========================================
// CREATE ALL ATTACKER RELATIONSHIPS - LLM-TIKG
// ========================================
// Import all relationships involving attackers with exact relationship names

// ========================================
// 1. CREATE CONSTRAINTS FIRST
// ========================================

CREATE CONSTRAINT IF NOT EXISTS FOR (a:Attackers) REQUIRE a.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (m:Malware) REQUIRE m.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (t:Tools) REQUIRE t.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (v:Vulnerabilities) REQUIRE v.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (f:Files) REQUIRE f.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (u:Urls) REQUIRE u.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (tech:Techniques) REQUIRE tech.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (d:Devices) REQUIRE d.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (i:Ips) REQUIRE i.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (h:Hashes) REQUIRE h.id IS UNIQUE;

// ========================================
// 2. SPECIFIC ATTACKER RELATIONSHIPS FROM CSV
// ========================================

// MAL96,RolandSkimmer,associated with,ATT1,2025 Global Threat Landscape Report
MATCH (m:Malware {id: 'MAL96'}), (a:Attackers {id: 'ATT1'})
MERGE (m)-[:ASSOCIATED_WITH {
    source_name: 'RolandSkimmer',
    target_name: '2025 Global Threat Landscape Report',
    relationship_id: 'REL46',
    original_relation: 'associated with'
}]->(a);

// TOO192,phishing,associated with,ATT1,2025 Global Threat Landscape Report
MATCH (t:Tools {id: 'TOO192'}), (a:Attackers {id: 'ATT1'})
MERGE (t)-[:ASSOCIATED_WITH {
    source_name: 'phishing',
    target_name: '2025 Global Threat Landscape Report',
    relationship_id: 'REL55',
    original_relation: 'associated with'
}]->(a);

// ATT16,Iranian state-sponsored threat group,targets,TOO61,critical national infrastructure
MATCH (a:Attackers {id: 'ATT16'}), (t:Tools {id: 'TOO61'})
MERGE (a)-[:TARGETS {
    source_name: 'Iranian state-sponsored threat group',
    target_name: 'critical national infrastructure',
    relationship_id: 'REL94',
    original_relation: 'targets'
}]->(t);

// ATT16,Iranian state-sponsored threat group,uses,TOO122,Havoc
MATCH (a:Attackers {id: 'ATT16'}), (t:Tools {id: 'TOO122'})
MERGE (a)-[:USES {
    source_name: 'Iranian state-sponsored threat group',
    target_name: 'Havoc',
    relationship_id: 'REL95',
    original_relation: 'uses'
}]->(t);

// ATT16,Iranian state-sponsored threat group,uses,MAL44,HanifNet
MATCH (a:Attackers {id: 'ATT16'}), (m:Malware {id: 'MAL44'})
MERGE (a)-[:USES {
    source_name: 'Iranian state-sponsored threat group',
    target_name: 'HanifNet',
    relationship_id: 'REL96',
    original_relation: 'uses'
}]->(m);

// ATT16,Iranian state-sponsored threat group,uses,MAL50,HXLibrary
MATCH (a:Attackers {id: 'ATT16'}), (m:Malware {id: 'MAL50'})
MERGE (a)-[:USES {
    source_name: 'Iranian state-sponsored threat group',
    target_name: 'HXLibrary',
    relationship_id: 'REL97',
    original_relation: 'uses'
}]->(m);

// ATT16,Iranian state-sponsored threat group,uses,MAL74,NeoExpressRAT
MATCH (a:Attackers {id: 'ATT16'}), (m:Malware {id: 'MAL74'})
MERGE (a)-[:USES {
    source_name: 'Iranian state-sponsored threat group',
    target_name: 'NeoExpressRAT',
    relationship_id: 'REL98',
    original_relation: 'uses'
}]->(m);

// ATT16,Iranian state-sponsored threat group,uses,TOO195,plink
MATCH (a:Attackers {id: 'ATT16'}), (t:Tools {id: 'TOO195'})
MERGE (a)-[:USES {
    source_name: 'Iranian state-sponsored threat group',
    target_name: 'plink',
    relationship_id: 'REL99',
    original_relation: 'uses'
}]->(t);

// ATT16,Iranian state-sponsored threat group,uses,TOO182,Ngrok
MATCH (a:Attackers {id: 'ATT16'}), (t:Tools {id: 'TOO182'})
MERGE (a)-[:USES {
    source_name: 'Iranian state-sponsored threat group',
    target_name: 'Ngrok',
    relationship_id: 'REL100',
    original_relation: 'uses'
}]->(t);

// ATT16,Iranian state-sponsored threat group,uses,TOO115,glider proxy
MATCH (a:Attackers {id: 'ATT16'}), (t:Tools {id: 'TOO115'})
MERGE (a)-[:USES {
    source_name: 'Iranian state-sponsored threat group',
    target_name: 'glider proxy',
    relationship_id: 'REL101',
    original_relation: 'uses'
}]->(t);

// ATT16,Iranian state-sponsored threat group,uses,TOO213,ReverseSocks5
MATCH (a:Attackers {id: 'ATT16'}), (t:Tools {id: 'TOO213'})
MERGE (a)-[:USES {
    source_name: 'Iranian state-sponsored threat group',
    target_name: 'ReverseSocks5',
    relationship_id: 'REL102',
    original_relation: 'uses'
}]->(t);

// ATT13,FortiGuard Labs Threat Research,targets,TOO41,CentOS Linux
MATCH (a:Attackers {id: 'ATT13'}), (t:Tools {id: 'TOO41'})
MERGE (a)-[:TARGETS {
    source_name: 'FortiGuard Labs Threat Research',
    target_name: 'CentOS Linux',
    relationship_id: 'REL159',
    original_relation: 'targets'
}]->(t);

// ATT13,FortiGuard Labs Threat Research,affects,TOO42,CentOS Users
MATCH (a:Attackers {id: 'ATT13'}), (t:Tools {id: 'TOO42'})
MERGE (a)-[:AFFECTS {
    source_name: 'FortiGuard Labs Threat Research',
    target_name: 'CentOS Users',
    relationship_id: 'REL160',
    original_relation: 'affects'
}]->(t);

// ATT13,FortiGuard Labs Threat Research,has severity level,TOO60,Critical
MATCH (a:Attackers {id: 'ATT13'}), (t:Tools {id: 'TOO60'})
MERGE (a)-[:HAS_SEVERITY_LEVEL {
    source_name: 'FortiGuard Labs Threat Research',
    target_name: 'Critical',
    relationship_id: 'REL161',
    original_relation: 'has severity level'
}]->(t);

// ATT13,FortiGuard Labs Threat Research,related to,VUL1,azero day exploit
MATCH (a:Attackers {id: 'ATT13'}), (v:Vulnerabilities {id: 'VUL1'})
MERGE (a)-[:RELATED_TO {
    source_name: 'FortiGuard Labs Threat Research',
    target_name: 'azero day exploit',
    relationship_id: 'REL162',
    original_relation: 'related to'
}]->(v);

// ATT11,EC2 Grouper,uses,TOO24,AWS tools
MATCH (a:Attackers {id: 'ATT11'}), (t:Tools {id: 'TOO24'})
MERGE (a)-[:USES {
    source_name: 'EC2 Grouper',
    target_name: 'AWS tools',
    relationship_id: 'REL167',
    original_relation: 'uses'
}]->(t);

// ATT11,EC2 Grouper,uses,TOO201,PowerShell
MATCH (a:Attackers {id: 'ATT11'}), (t:Tools {id: 'TOO201'})
MERGE (a)-[:USES {
    source_name: 'EC2 Grouper',
    target_name: 'PowerShell',
    relationship_id: 'REL168',
    original_relation: 'uses'
}]->(t);

// ATT13,FortiGuard Labs Threat Research,detect,MAL128,Zebo-0.1.0
MATCH (a:Attackers {id: 'ATT13'}), (m:Malware {id: 'MAL128'})
MERGE (a)-[:DETECT {
    source_name: 'FortiGuard Labs Threat Research',
    target_name: 'Zebo-0.1.0',
    relationship_id: 'REL169',
    original_relation: 'detect'
}]->(m);

// ATT13,FortiGuard Labs Threat Research,detect,MAL22,Cometlogger-0.1
MATCH (a:Attackers {id: 'ATT13'}), (m:Malware {id: 'MAL22'})
MERGE (a)-[:DETECT {
    source_name: 'FortiGuard Labs Threat Research',
    target_name: 'Cometlogger-0.1',
    relationship_id: 'REL170',
    original_relation: 'detect'
}]->(m);

// MAL128,Zebo-0.1.0,uses,ATT22,Screen Capturing
MATCH (m:Malware {id: 'MAL128'}), (a:Attackers {id: 'ATT22'})
MERGE (m)-[:USES {
    source_name: 'Zebo-0.1.0',
    target_name: 'Screen Capturing',
    relationship_id: 'REL173',
    original_relation: 'uses'
}]->(a);

// TOO188,Operation Serengeti,associated with,ATT9,Cybercrime Atlas
MATCH (t:Tools {id: 'TOO188'}), (a:Attackers {id: 'ATT9'})
MERGE (t)-[:ASSOCIATED_WITH {
    source_name: 'Operation Serengeti',
    target_name: 'Cybercrime Atlas',
    relationship_id: 'REL178',
    original_relation: 'associated with'
}]->(a);

// TOO188,Operation Serengeti,associated with,ATT26,World Economic Forum's Partnership Against Cybercrime
MATCH (t:Tools {id: 'TOO188'}), (a:Attackers {id: 'ATT26'})
MERGE (t)-[:ASSOCIATED_WITH {
    source_name: 'Operation Serengeti',
    target_name: 'World Economic Forum\'s Partnership Against Cybercrime',
    relationship_id: 'REL179',
    original_relation: 'associated with'
}]->(a);

// TOO101,Fortinet,associated with,ATT9,Cybercrime Atlas
MATCH (t:Tools {id: 'TOO101'}), (a:Attackers {id: 'ATT9'})
MERGE (t)-[:ASSOCIATED_WITH {
    source_name: 'Fortinet',
    target_name: 'Cybercrime Atlas',
    relationship_id: 'REL180',
    original_relation: 'associated with'
}]->(a);

// ATT23,Sina Kheirkhah,has handle,TOO228,SinSinology
MATCH (a:Attackers {id: 'ATT23'}), (t:Tools {id: 'TOO228'})
MERGE (a)-[:HAS_HANDLE {
    source_name: 'Sina Kheirkhah',
    target_name: 'SinSinology',
    relationship_id: 'REL193',
    original_relation: 'has handle'
}]->(t);

// ATT21,RomCom group,aka,TOO237,Storm-0978
MATCH (a:Attackers {id: 'ATT21'}), (t:Tools {id: 'TOO237'})
MERGE (a)-[:AKA {
    source_name: 'RomCom group',
    target_name: 'Storm-0978',
    relationship_id: 'REL226',
    original_relation: 'aka'
}]->(t);

// ATT21,RomCom group,deploys,MAL114,Underground
MATCH (a:Attackers {id: 'ATT21'}), (m:Malware {id: 'MAL114'})
MERGE (a)-[:DEPLOYS {
    source_name: 'RomCom group',
    target_name: 'Underground',
    relationship_id: 'REL227',
    original_relation: 'deploys'
}]->(m);

// TOO19,Apple ID,uses,ATT2,Apple
MATCH (t:Tools {id: 'TOO19'}), (a:Attackers {id: 'ATT2'})
MERGE (t)-[:USES {
    source_name: 'Apple ID',
    target_name: 'Apple',
    relationship_id: 'REL269',
    original_relation: 'uses'
}]->(a);

// TOO223,ScrubCrypt,used by,ATT24,Threat Actor
MATCH (t:Tools {id: 'TOO223'}), (a:Attackers {id: 'ATT24'})
MERGE (t)-[:USED_BY {
    source_name: 'ScrubCrypt',
    target_name: 'Threat Actor',
    relationship_id: 'REL344',
    original_relation: 'used by'
}]->(a);

// ATT24,Threat Actor,uses,TOO192,phishing
MATCH (a:Attackers {id: 'ATT24'}), (t:Tools {id: 'TOO192'})
MERGE (a)-[:USES {
    source_name: 'Threat Actor',
    target_name: 'phishing',
    relationship_id: 'REL345',
    original_relation: 'uses'
}]->(t);

// ATT24,Threat Actor,downloads,FIL152,ZIP file
MATCH (a:Attackers {id: 'ATT24'}), (f:Files {id: 'FIL152'})
MERGE (a)-[:DOWNLOADS {
    source_name: 'Threat Actor',
    target_name: 'ZIP file',
    relationship_id: 'REL346',
    original_relation: 'downloads'
}]->(f);

// ATT24,Threat Actor,uses,TOO223,ScrubCrypt
MATCH (a:Attackers {id: 'ATT24'}), (t:Tools {id: 'TOO223'})
MERGE (a)-[:USES {
    source_name: 'Threat Actor',
    target_name: 'ScrubCrypt',
    relationship_id: 'REL347',
    original_relation: 'uses'
}]->(t);

// MAL52,info-stealer,used by,ATT25,Vietnamese-based group
MATCH (m:Malware {id: 'MAL52'}), (a:Attackers {id: 'ATT25'})
MERGE (m)-[:USED_BY {
    source_name: 'info-stealer',
    target_name: 'Vietnamese-based group',
    relationship_id: 'REL402',
    original_relation: 'used by'
}]->(a);

// TOO98,FortiGuard Labs,uses,ATT10,Cybercrime-as-a-Service
MATCH (t:Tools {id: 'TOO98'}), (a:Attackers {id: 'ATT10'})
MERGE (t)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'Cybercrime-as-a-Service',
    relationship_id: 'REL502',
    original_relation: 'uses'
}]->(a);

// TOO98,FortiGuard Labs,uses,ATT3,APT
MATCH (t:Tools {id: 'TOO98'}), (a:Attackers {id: 'ATT3'})
MERGE (t)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'APT',
    relationship_id: 'REL505',
    original_relation: 'uses'
}]->(a);

// ATT6,CERT India,issues,TOO11,advisory
MATCH (a:Attackers {id: 'ATT6'}), (t:Tools {id: 'TOO11'})
MERGE (a)-[:ISSUES {
    source_name: 'CERT India',
    target_name: 'advisory',
    relationship_id: 'REL522',
    original_relation: 'issues'
}]->(t);

// TOO98,FortiGuard Labs,targets,ATT4,Azerbaijanian company
MATCH (t:Tools {id: 'TOO98'}), (a:Attackers {id: 'ATT4'})
MERGE (t)-[:TARGETS {
    source_name: 'FortiGuard Labs',
    target_name: 'Azerbaijanian company',
    relationship_id: 'REL534',
    original_relation: 'targets'
}]->(a);

// ========================================
// 3. VERIFICATION QUERIES
// ========================================

// Count attacker relationships by type
MATCH (a:Attackers)-[r]->()
RETURN type(r) AS outgoing_relationship_type, count(r) AS count
ORDER BY count DESC;

// Count incoming attacker relationships by type
MATCH ()-[r]->(a:Attackers)
RETURN type(r) AS incoming_relationship_type, count(r) AS count
ORDER BY count DESC;

// Show sample attacker network
MATCH (a:Attackers)-[r]->(target)
RETURN a.name AS attacker, type(r) AS relationship, 
       labels(target)[0] AS target_type, target.name AS target
ORDER BY attacker, relationship
LIMIT 20;

// Count total attacker relationships
MATCH (a:Attackers)
OPTIONAL MATCH (a)-[r_out]->()
OPTIONAL MATCH ()-[r_in]->(a)
WITH a, count(r_out) + count(r_in) AS total_connections
WHERE total_connections > 0
RETURN a.name AS attacker, total_connections
ORDER BY total_connections DESC
LIMIT 10;
