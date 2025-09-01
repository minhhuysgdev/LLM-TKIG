// ========================================
// CREATE ATTACKERS RELATIONSHIPS
// Auto-generated from relationships_norm.csv
// ========================================

// Total Attackers relationships: 24

// ========================================
// 1. CREATE CONSTRAINTS
// ========================================

CREATE CONSTRAINT IF NOT EXISTS FOR (a:Attackers) REQUIRE a.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (m:Malware) REQUIRE m.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (t:Tools) REQUIRE t.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (v:Vulnerabilities) REQUIRE v.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (f:Files) REQUIRE f.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (h:Hashes) REQUIRE h.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (i:Ips) REQUIRE i.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (u:Urls) REQUIRE u.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (d:Devices) REQUIRE d.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (tech:Techniques) REQUIRE tech.id IS UNIQUE;

// ========================================
// 2. ATTACKERS RELATIONSHIPS
// ========================================

// Iranian state-sponsored threat group targets critical national infrastructure
MATCH (source:Attackers {id: 'ATT16'}), (target:Tools {id: 'TOO61'})
MERGE (source)-[:TARGETS {
    source_name: 'Iranian state-sponsored threat group',
    target_name: 'critical national infrastructure',
    relationship_id: 'REL94',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// Iranian state-sponsored threat group uses Havoc
MATCH (source:Attackers {id: 'ATT16'}), (target:Tools {id: 'TOO122'})
MERGE (source)-[:USES {
    source_name: 'Iranian state-sponsored threat group',
    target_name: 'Havoc',
    relationship_id: 'REL95',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Iranian state-sponsored threat group uses HanifNet
MATCH (source:Attackers {id: 'ATT16'}), (target:Malware {id: 'MAL44'})
MERGE (source)-[:USES {
    source_name: 'Iranian state-sponsored threat group',
    target_name: 'HanifNet',
    relationship_id: 'REL96',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Iranian state-sponsored threat group uses HXLibrary
MATCH (source:Attackers {id: 'ATT16'}), (target:Malware {id: 'MAL50'})
MERGE (source)-[:USES {
    source_name: 'Iranian state-sponsored threat group',
    target_name: 'HXLibrary',
    relationship_id: 'REL97',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Iranian state-sponsored threat group uses NeoExpressRAT
MATCH (source:Attackers {id: 'ATT16'}), (target:Malware {id: 'MAL74'})
MERGE (source)-[:USES {
    source_name: 'Iranian state-sponsored threat group',
    target_name: 'NeoExpressRAT',
    relationship_id: 'REL98',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Iranian state-sponsored threat group uses plink
MATCH (source:Attackers {id: 'ATT16'}), (target:Tools {id: 'TOO195'})
MERGE (source)-[:USES {
    source_name: 'Iranian state-sponsored threat group',
    target_name: 'plink',
    relationship_id: 'REL99',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Iranian state-sponsored threat group uses Ngrok
MATCH (source:Attackers {id: 'ATT16'}), (target:Tools {id: 'TOO182'})
MERGE (source)-[:USES {
    source_name: 'Iranian state-sponsored threat group',
    target_name: 'Ngrok',
    relationship_id: 'REL100',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Iranian state-sponsored threat group uses glider proxy
MATCH (source:Attackers {id: 'ATT16'}), (target:Tools {id: 'TOO115'})
MERGE (source)-[:USES {
    source_name: 'Iranian state-sponsored threat group',
    target_name: 'glider proxy',
    relationship_id: 'REL101',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Iranian state-sponsored threat group uses ReverseSocks5
MATCH (source:Attackers {id: 'ATT16'}), (target:Tools {id: 'TOO213'})
MERGE (source)-[:USES {
    source_name: 'Iranian state-sponsored threat group',
    target_name: 'ReverseSocks5',
    relationship_id: 'REL102',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiGuard Labs Threat Research targets CentOS Linux
MATCH (source:Attackers {id: 'ATT13'}), (target:Tools {id: 'TOO41'})
MERGE (source)-[:TARGETS {
    source_name: 'FortiGuard Labs Threat Research',
    target_name: 'CentOS Linux',
    relationship_id: 'REL159',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// FortiGuard Labs Threat Research affects CentOS Users
MATCH (source:Attackers {id: 'ATT13'}), (target:Tools {id: 'TOO42'})
MERGE (source)-[:AFFECTS {
    source_name: 'FortiGuard Labs Threat Research',
    target_name: 'CentOS Users',
    relationship_id: 'REL160',
    original_relation: 'affects',
    created_at: datetime()
}]->(target);

// FortiGuard Labs Threat Research has severity level Critical
MATCH (source:Attackers {id: 'ATT13'}), (target:Tools {id: 'TOO60'})
MERGE (source)-[:HAS_SEVERITY_LEVEL {
    source_name: 'FortiGuard Labs Threat Research',
    target_name: 'Critical',
    relationship_id: 'REL161',
    original_relation: 'has severity level',
    created_at: datetime()
}]->(target);

// FortiGuard Labs Threat Research related to azero day exploit
MATCH (source:Attackers {id: 'ATT13'}), (target:Vulnerabilities {id: 'VUL1'})
MERGE (source)-[:RELATED_TO {
    source_name: 'FortiGuard Labs Threat Research',
    target_name: 'azero day exploit',
    relationship_id: 'REL162',
    original_relation: 'related to',
    created_at: datetime()
}]->(target);

// EC2 Grouper uses AWS tools
MATCH (source:Attackers {id: 'ATT11'}), (target:Tools {id: 'TOO24'})
MERGE (source)-[:USES {
    source_name: 'EC2 Grouper',
    target_name: 'AWS tools',
    relationship_id: 'REL167',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// EC2 Grouper uses PowerShell
MATCH (source:Attackers {id: 'ATT11'}), (target:Tools {id: 'TOO201'})
MERGE (source)-[:USES {
    source_name: 'EC2 Grouper',
    target_name: 'PowerShell',
    relationship_id: 'REL168',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiGuard Labs Threat Research detect Zebo-0.1.0
MATCH (source:Attackers {id: 'ATT13'}), (target:Malware {id: 'MAL128'})
MERGE (source)-[:DETECT {
    source_name: 'FortiGuard Labs Threat Research',
    target_name: 'Zebo-0.1.0',
    relationship_id: 'REL169',
    original_relation: 'detect',
    created_at: datetime()
}]->(target);

// FortiGuard Labs Threat Research detect Cometlogger-0.1
MATCH (source:Attackers {id: 'ATT13'}), (target:Malware {id: 'MAL22'})
MERGE (source)-[:DETECT {
    source_name: 'FortiGuard Labs Threat Research',
    target_name: 'Cometlogger-0.1',
    relationship_id: 'REL170',
    original_relation: 'detect',
    created_at: datetime()
}]->(target);

// Sina Kheirkhah has handle SinSinology
MATCH (source:Attackers {id: 'ATT23'}), (target:Tools {id: 'TOO228'})
MERGE (source)-[:HAS_HANDLE {
    source_name: 'Sina Kheirkhah',
    target_name: 'SinSinology',
    relationship_id: 'REL193',
    original_relation: 'has handle',
    created_at: datetime()
}]->(target);

// RomCom group aka Storm-0978
MATCH (source:Attackers {id: 'ATT21'}), (target:Tools {id: 'TOO237'})
MERGE (source)-[:AKA {
    source_name: 'RomCom group',
    target_name: 'Storm-0978',
    relationship_id: 'REL226',
    original_relation: 'aka',
    created_at: datetime()
}]->(target);

// RomCom group deploys Underground
MATCH (source:Attackers {id: 'ATT21'}), (target:Malware {id: 'MAL114'})
MERGE (source)-[:DEPLOYS {
    source_name: 'RomCom group',
    target_name: 'Underground',
    relationship_id: 'REL227',
    original_relation: 'deploys',
    created_at: datetime()
}]->(target);

// Threat Actor uses phishing
MATCH (source:Attackers {id: 'ATT24'}), (target:Tools {id: 'TOO192'})
MERGE (source)-[:USES {
    source_name: 'Threat Actor',
    target_name: 'phishing',
    relationship_id: 'REL345',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Threat Actor downloads ZIP file
MATCH (source:Attackers {id: 'ATT24'}), (target:Files {id: 'FIL152'})
MERGE (source)-[:DOWNLOADS {
    source_name: 'Threat Actor',
    target_name: 'ZIP file',
    relationship_id: 'REL346',
    original_relation: 'downloads',
    created_at: datetime()
}]->(target);

// Threat Actor uses ScrubCrypt
MATCH (source:Attackers {id: 'ATT24'}), (target:Tools {id: 'TOO223'})
MERGE (source)-[:USES {
    source_name: 'Threat Actor',
    target_name: 'ScrubCrypt',
    relationship_id: 'REL347',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// CERT India issues advisory
MATCH (source:Attackers {id: 'ATT6'}), (target:Tools {id: 'TOO11'})
MERGE (source)-[:ISSUES {
    source_name: 'CERT India',
    target_name: 'advisory',
    relationship_id: 'REL522',
    original_relation: 'issues',
    created_at: datetime()
}]->(target);

// ========================================
// 3. VERIFICATION QUERIES
// ========================================

// Count Attackers outgoing relationships
MATCH (s:Attackers)-[r]->()
RETURN type(r) AS relationship_type, count(r) AS count
ORDER BY count DESC;

// Show sample Attackers relationships
MATCH (s:Attackers)-[r]->(target)
RETURN s.name AS source, type(r) AS relationship,
       labels(target)[0] AS target_type, target.name AS target
ORDER BY source, relationship
LIMIT 20;

// Summary: Relationship types for Attackers
// USES: 12
// TARGETS: 2
// DETECT: 2
// AFFECTS: 1
// HAS_SEVERITY_LEVEL: 1
// RELATED_TO: 1
// HAS_HANDLE: 1
// AKA: 1
// DEPLOYS: 1
// DOWNLOADS: 1
// ISSUES: 1