// ========================================
// CREATE TOOLS RELATIONSHIPS
// Auto-generated from relationships_norm.csv
// ========================================

// Total Tools relationships: 210

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
// 2. TOOLS RELATIONSHIPS
// ========================================

// FortiCNAPP Composite Alerts used by Lcrypt0rx
MATCH (source:Tools {id: 'TOO95'}), (target:Malware {id: 'MAL57'})
MERGE (source)-[:USED_BY {
    source_name: 'FortiCNAPP Composite Alerts',
    target_name: 'Lcrypt0rx',
    relationship_id: 'REL1',
    original_relation: 'used by',
    created_at: datetime()
}]->(target);

// Rust used by Lcrypt0rx
MATCH (source:Tools {id: 'TOO219'}), (target:Malware {id: 'MAL57'})
MERGE (source)-[:USED_BY {
    source_name: 'Rust',
    target_name: 'Lcrypt0rx',
    relationship_id: 'REL4',
    original_relation: 'used by',
    created_at: datetime()
}]->(target);

// H2miner uses KinSing
MATCH (source:Tools {id: 'TOO120'}), (target:Tools {id: 'TOO145'})
MERGE (source)-[:USES {
    source_name: 'H2miner',
    target_name: 'KinSing',
    relationship_id: 'REL11',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// H2miner uses Xmrig miners
MATCH (source:Tools {id: 'TOO120'}), (target:Tools {id: 'TOO284'})
MERGE (source)-[:USES {
    source_name: 'H2miner',
    target_name: 'Xmrig miners',
    relationship_id: 'REL12',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// H2miner associated with Lcrypt0rx
MATCH (source:Tools {id: 'TOO120'}), (target:Malware {id: 'MAL57'})
MERGE (source)-[:ASSOCIATED_WITH {
    source_name: 'H2miner',
    target_name: 'Lcrypt0rx',
    relationship_id: 'REL13',
    original_relation: 'associated with',
    created_at: datetime()
}]->(target);

// H2miner targets Linux
MATCH (source:Tools {id: 'TOO120'}), (target:Tools {id: 'TOO154'})
MERGE (source)-[:TARGETS {
    source_name: 'H2miner',
    target_name: 'Linux',
    relationship_id: 'REL19',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// H2miner targets Windows
MATCH (source:Tools {id: 'TOO120'}), (target:Tools {id: 'TOO275'})
MERGE (source)-[:TARGETS {
    source_name: 'H2miner',
    target_name: 'Windows',
    relationship_id: 'REL20',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// H2miner targets Containers
MATCH (source:Tools {id: 'TOO120'}), (target:Tools {id: 'TOO57'})
MERGE (source)-[:TARGETS {
    source_name: 'H2miner',
    target_name: 'Containers',
    relationship_id: 'REL21',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// FortiGuard Labs analyze Dark 101
MATCH (source:Tools {id: 'TOO98'}), (target:Malware {id: 'MAL26'})
MERGE (source)-[:ANALYZE {
    source_name: 'FortiGuard Labs',
    target_name: 'Dark 101',
    relationship_id: 'REL22',
    original_relation: 'analyze',
    created_at: datetime()
}]->(target);

// FortiSandbox used by FortiGuard Labs
MATCH (source:Tools {id: 'TOO103'}), (target:Tools {id: 'TOO98'})
MERGE (source)-[:USED_BY {
    source_name: 'FortiSandbox',
    target_name: 'FortiGuard Labs',
    relationship_id: 'REL25',
    original_relation: 'used by',
    created_at: datetime()
}]->(target);

// RondoDox exploits CVE-2024-3721
MATCH (source:Tools {id: 'TOO217'}), (target:Vulnerabilities {id: 'VUL21'})
MERGE (source)-[:EXPLOITS {
    source_name: 'RondoDox',
    target_name: 'CVE-2024-3721',
    relationship_id: 'REL28',
    original_relation: 'exploits',
    created_at: datetime()
}]->(target);

// RondoDox exploits CVE-2024-12856
MATCH (source:Tools {id: 'TOO217'}), (target:Vulnerabilities {id: 'VUL18'})
MERGE (source)-[:EXPLOITS {
    source_name: 'RondoDox',
    target_name: 'CVE-2024-12856',
    relationship_id: 'REL29',
    original_relation: 'exploits',
    created_at: datetime()
}]->(target);

// RondoDox uses ELF binary
MATCH (source:Tools {id: 'TOO217'}), (target:Files {id: 'FIL68'})
MERGE (source)-[:USES {
    source_name: 'RondoDox',
    target_name: 'ELF binary',
    relationship_id: 'REL30',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiMail IR team uses file drops
MATCH (source:Tools {id: 'TOO100'}), (target:Files {id: 'FIL82'})
MERGE (source)-[:USES {
    source_name: 'FortiMail IR team',
    target_name: 'file drops',
    relationship_id: 'REL31',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// DCRAT is Remote Access Trojan
MATCH (source:Tools {id: 'TOO75'}), (target:Malware {id: 'MAL93'})
MERGE (source)-[:IS {
    source_name: 'DCRAT',
    target_name: 'Remote Access Trojan',
    relationship_id: 'REL32',
    original_relation: 'is',
    created_at: datetime()
}]->(target);

// Havoc deploy cmd.exe
MATCH (source:Tools {id: 'TOO122'}), (target:Files {id: 'FIL53'})
MERGE (source)-[:DEPLOY {
    source_name: 'Havoc',
    target_name: 'cmd.exe',
    relationship_id: 'REL33',
    original_relation: 'deploy',
    created_at: datetime()
}]->(target);

// Havoc communicate with C2 server
MATCH (source:Tools {id: 'TOO122'}), (target:Tools {id: 'TOO38'})
MERGE (source)-[:COMMUNICATE_WITH {
    source_name: 'Havoc',
    target_name: 'C2 server',
    relationship_id: 'REL34',
    original_relation: 'communicate with',
    created_at: datetime()
}]->(target);

// Task Scheduler launch conhost.exe
MATCH (source:Tools {id: 'TOO243'}), (target:Files {id: 'FIL55'})
MERGE (source)-[:LAUNCH {
    source_name: 'Task Scheduler',
    target_name: 'conhost.exe',
    relationship_id: 'REL35',
    original_relation: 'launch',
    created_at: datetime()
}]->(target);

// FortiGuard Labs targets Microsoft Windows
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO168'})
MERGE (source)-[:TARGETS {
    source_name: 'FortiGuard Labs',
    target_name: 'Microsoft Windows',
    relationship_id: 'REL37',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses winos 4.0
MATCH (source:Tools {id: 'TOO98'}), (target:Malware {id: 'MAL125'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'winos 4.0',
    relationship_id: 'REL38',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiGuard Labs targets Taiwan
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO241'})
MERGE (source)-[:TARGETS {
    source_name: 'FortiGuard Labs',
    target_name: 'Taiwan',
    relationship_id: 'REL39',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// phishing targets Windows Users
MATCH (source:Tools {id: 'TOO192'}), (target:Tools {id: 'TOO277'})
MERGE (source)-[:TARGETS {
    source_name: 'phishing',
    target_name: 'Windows Users',
    relationship_id: 'REL47',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// phishing exploits CVE-2017-0199
MATCH (source:Tools {id: 'TOO192'}), (target:Vulnerabilities {id: 'VUL6'})
MERGE (source)-[:EXPLOITS {
    source_name: 'phishing',
    target_name: 'CVE-2017-0199',
    relationship_id: 'REL48',
    original_relation: 'exploits',
    created_at: datetime()
}]->(target);

// phishing delivers Excel
MATCH (source:Tools {id: 'TOO192'}), (target:Tools {id: 'TOO89'})
MERGE (source)-[:DELIVERS {
    source_name: 'phishing',
    target_name: 'Excel',
    relationship_id: 'REL49',
    original_relation: 'delivers',
    created_at: datetime()
}]->(target);

// Excel exploits CVE-2017-0199
MATCH (source:Tools {id: 'TOO89'}), (target:Vulnerabilities {id: 'VUL6'})
MERGE (source)-[:EXPLOITS {
    source_name: 'Excel',
    target_name: 'CVE-2017-0199',
    relationship_id: 'REL50',
    original_relation: 'exploits',
    created_at: datetime()
}]->(target);

// phishing uses FormBook
MATCH (source:Tools {id: 'TOO192'}), (target:Malware {id: 'MAL37'})
MERGE (source)-[:USES {
    source_name: 'phishing',
    target_name: 'FormBook',
    relationship_id: 'REL51',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// phishing associated with 2025 Global Threat Landscape Report
MATCH (source:Tools {id: 'TOO192'}), (target:Attackers {id: 'ATT1'})
MERGE (source)-[:ASSOCIATED_WITH {
    source_name: 'phishing',
    target_name: '2025 Global Threat Landscape Report',
    relationship_id: 'REL55',
    original_relation: 'associated with',
    created_at: datetime()
}]->(target);

// phishing has subject sales order
MATCH (source:Tools {id: 'TOO192'}), (target:Tools {id: 'TOO221'})
MERGE (source)-[:HAS_SUBJECT {
    source_name: 'phishing',
    target_name: 'sales order',
    relationship_id: 'REL56',
    original_relation: 'has subject',
    created_at: datetime()
}]->(target);

// FortiMail detects phishing
MATCH (source:Tools {id: 'TOO99'}), (target:Tools {id: 'TOO192'})
MERGE (source)-[:DETECTS {
    source_name: 'FortiMail',
    target_name: 'phishing',
    relationship_id: 'REL57',
    original_relation: 'detects',
    created_at: datetime()
}]->(target);

// FortiGuard Incident Response Team execute batch of scripts
MATCH (source:Tools {id: 'TOO97'}), (target:Files {id: 'FIL47'})
MERGE (source)-[:EXECUTE {
    source_name: 'FortiGuard Incident Response Team',
    target_name: 'batch of scripts',
    relationship_id: 'REL58',
    original_relation: 'execute',
    created_at: datetime()
}]->(target);

// FortiGuard Incident Response Team execute PowerShell
MATCH (source:Tools {id: 'TOO97'}), (target:Tools {id: 'TOO201'})
MERGE (source)-[:EXECUTE {
    source_name: 'FortiGuard Incident Response Team',
    target_name: 'PowerShell',
    relationship_id: 'REL59',
    original_relation: 'execute',
    created_at: datetime()
}]->(target);

// FortiGuard Incident Response Team drop fullout
MATCH (source:Tools {id: 'TOO97'}), (target:Files {id: 'FIL88'})
MERGE (source)-[:DROP {
    source_name: 'FortiGuard Incident Response Team',
    target_name: 'fullout',
    relationship_id: 'REL60',
    original_relation: 'drop',
    created_at: datetime()
}]->(target);

// FortiGuard Incident Response Team deploy fullout
MATCH (source:Tools {id: 'TOO97'}), (target:Files {id: 'FIL88'})
MERGE (source)-[:DEPLOY {
    source_name: 'FortiGuard Incident Response Team',
    target_name: 'fullout',
    relationship_id: 'REL61',
    original_relation: 'deploy',
    created_at: datetime()
}]->(target);

// FortiGuard Incident Response Team use dllhost.exe
MATCH (source:Tools {id: 'TOO97'}), (target:Files {id: 'FIL62'})
MERGE (source)-[:USE {
    source_name: 'FortiGuard Incident Response Team',
    target_name: 'dllhost.exe',
    relationship_id: 'REL62',
    original_relation: 'use',
    created_at: datetime()
}]->(target);

// FortiGuard Incident Response Team drop pid.8200.vad.0x1c3eefb0000-0x1c3ef029fff.dmp
MATCH (source:Tools {id: 'TOO97'}), (target:Files {id: 'FIL119'})
MERGE (source)-[:DROP {
    source_name: 'FortiGuard Incident Response Team',
    target_name: 'pid.8200.vad.0x1c3eefb0000-0x1c3ef029fff.dmp',
    relationship_id: 'REL63',
    original_relation: 'drop',
    created_at: datetime()
}]->(target);

// FortiGuard Incident Response Team deploy pid.8200.vad.0x1c3eefb0000-0x1c3ef029fff.dmp
MATCH (source:Tools {id: 'TOO97'}), (target:Files {id: 'FIL119'})
MERGE (source)-[:DEPLOY {
    source_name: 'FortiGuard Incident Response Team',
    target_name: 'pid.8200.vad.0x1c3eefb0000-0x1c3ef029fff.dmp',
    relationship_id: 'REL64',
    original_relation: 'deploy',
    created_at: datetime()
}]->(target);

// RAT is RATty
MATCH (source:Tools {id: 'TOO212'}), (target:Malware {id: 'MAL87'})
MERGE (source)-[:IS {
    source_name: 'RAT',
    target_name: 'RATty',
    relationship_id: 'REL87',
    original_relation: 'is',
    created_at: datetime()
}]->(target);

// FortiGuard Labs targets Spain
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO234'})
MERGE (source)-[:TARGETS {
    source_name: 'FortiGuard Labs',
    target_name: 'Spain',
    relationship_id: 'REL88',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// FortiGuard Labs targets Italy
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO137'})
MERGE (source)-[:TARGETS {
    source_name: 'FortiGuard Labs',
    target_name: 'Italy',
    relationship_id: 'REL89',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// FortiGuard Labs targets Portugal
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO198'})
MERGE (source)-[:TARGETS {
    source_name: 'FortiGuard Labs',
    target_name: 'Portugal',
    relationship_id: 'REL90',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// FortiGuard Incident Response investigates critical national infrastructure
MATCH (source:Tools {id: 'TOO96'}), (target:Tools {id: 'TOO61'})
MERGE (source)-[:INVESTIGATES {
    source_name: 'FortiGuard Incident Response',
    target_name: 'critical national infrastructure',
    relationship_id: 'REL93',
    original_relation: 'investigates',
    created_at: datetime()
}]->(target);

// Ingress-NGINX exploit CVE‑2025‑1974
MATCH (source:Tools {id: 'TOO133'}), (target:Vulnerabilities {id: 'VUL23'})
MERGE (source)-[:EXPLOIT {
    source_name: 'Ingress-NGINX',
    target_name: 'CVE‑2025‑1974',
    relationship_id: 'REL103',
    original_relation: 'exploit',
    created_at: datetime()
}]->(target);

// Lacework FortiCNAPP provide coverage for Ingress-NGINX
MATCH (source:Tools {id: 'TOO150'}), (target:Tools {id: 'TOO133'})
MERGE (source)-[:PROVIDE_COVERAGE_FOR {
    source_name: 'Lacework FortiCNAPP',
    target_name: 'Ingress-NGINX',
    relationship_id: 'REL104',
    original_relation: 'provide coverage for',
    created_at: datetime()
}]->(target);

// Fortinet Security Fabric provide coverage for Ingress-NGINX
MATCH (source:Tools {id: 'TOO102'}), (target:Tools {id: 'TOO133'})
MERGE (source)-[:PROVIDE_COVERAGE_FOR {
    source_name: 'Fortinet Security Fabric',
    target_name: 'Ingress-NGINX',
    relationship_id: 'REL105',
    original_relation: 'provide coverage for',
    created_at: datetime()
}]->(target);

// phishing used by malicious Word document
MATCH (source:Tools {id: 'TOO192'}), (target:Files {id: 'FIL105'})
MERGE (source)-[:USED_BY {
    source_name: 'phishing',
    target_name: 'malicious Word document',
    relationship_id: 'REL106',
    original_relation: 'used by',
    created_at: datetime()
}]->(target);

// phishing target Windows
MATCH (source:Tools {id: 'TOO192'}), (target:Tools {id: 'TOO275'})
MERGE (source)-[:TARGET {
    source_name: 'phishing',
    target_name: 'Windows',
    relationship_id: 'REL109',
    original_relation: 'target',
    created_at: datetime()
}]->(target);

// phishing deliver malicious Word document
MATCH (source:Tools {id: 'TOO192'}), (target:Files {id: 'FIL105'})
MERGE (source)-[:DELIVER {
    source_name: 'phishing',
    target_name: 'malicious Word document',
    relationship_id: 'REL111',
    original_relation: 'deliver',
    created_at: datetime()
}]->(target);

// phishing deploy malware
MATCH (source:Tools {id: 'TOO192'}), (target:Malware {id: 'MAL64'})
MERGE (source)-[:DEPLOY {
    source_name: 'phishing',
    target_name: 'malware',
    relationship_id: 'REL112',
    original_relation: 'deploy',
    created_at: datetime()
}]->(target);

// Havoc uses Cobalt Strike
MATCH (source:Tools {id: 'TOO122'}), (target:Tools {id: 'TOO54'})
MERGE (source)-[:USES {
    source_name: 'Havoc',
    target_name: 'Cobalt Strike',
    relationship_id: 'REL113',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Havoc uses Silver
MATCH (source:Tools {id: 'TOO122'}), (target:Tools {id: 'TOO226'})
MERGE (source)-[:USES {
    source_name: 'Havoc',
    target_name: 'Silver',
    relationship_id: 'REL114',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Havoc uses Winos4.0
MATCH (source:Tools {id: 'TOO122'}), (target:Tools {id: 'TOO278'})
MERGE (source)-[:USES {
    source_name: 'Havoc',
    target_name: 'Winos4.0',
    relationship_id: 'REL115',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// phishing uses ClickFix
MATCH (source:Tools {id: 'TOO192'}), (target:Tools {id: 'TOO52'})
MERGE (source)-[:USES {
    source_name: 'phishing',
    target_name: 'ClickFix',
    relationship_id: 'REL118',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Winos4.0 targets Microsoft Windows
MATCH (source:Tools {id: 'TOO278'}), (target:Tools {id: 'TOO168'})
MERGE (source)-[:TARGETS {
    source_name: 'Winos4.0',
    target_name: 'Microsoft Windows',
    relationship_id: 'REL120',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// Winos4.0 targets Taiwan
MATCH (source:Tools {id: 'TOO278'}), (target:Tools {id: 'TOO241'})
MERGE (source)-[:TARGETS {
    source_name: 'Winos4.0',
    target_name: 'Taiwan',
    relationship_id: 'REL121',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// Winos4.0 download C2 server
MATCH (source:Tools {id: 'TOO278'}), (target:Tools {id: 'TOO38'})
MERGE (source)-[:DOWNLOAD {
    source_name: 'Winos4.0',
    target_name: 'C2 server',
    relationship_id: 'REL122',
    original_relation: 'download',
    created_at: datetime()
}]->(target);

// FortiGuard Labs detects AutoIt/Injector.GTY!tr
MATCH (source:Tools {id: 'TOO98'}), (target:Malware {id: 'MAL13'})
MERGE (source)-[:DETECTS {
    source_name: 'FortiGuard Labs',
    target_name: 'AutoIt/Injector.GTY!tr',
    relationship_id: 'REL123',
    original_relation: 'detects',
    created_at: datetime()
}]->(target);

// phishing use PayPal
MATCH (source:Tools {id: 'TOO192'}), (target:Tools {id: 'TOO190'})
MERGE (source)-[:USE {
    source_name: 'phishing',
    target_name: 'PayPal',
    relationship_id: 'REL166',
    original_relation: 'use',
    created_at: datetime()
}]->(target);

// INTERPOL associated with Operation Serengeti
MATCH (source:Tools {id: 'TOO134'}), (target:Tools {id: 'TOO188'})
MERGE (source)-[:ASSOCIATED_WITH {
    source_name: 'INTERPOL',
    target_name: 'Operation Serengeti',
    relationship_id: 'REL175',
    original_relation: 'associated with',
    created_at: datetime()
}]->(target);

// AFRIPOL associated with Operation Serengeti
MATCH (source:Tools {id: 'TOO12'}), (target:Tools {id: 'TOO188'})
MERGE (source)-[:ASSOCIATED_WITH {
    source_name: 'AFRIPOL',
    target_name: 'Operation Serengeti',
    relationship_id: 'REL176',
    original_relation: 'associated with',
    created_at: datetime()
}]->(target);

// Operation Serengeti associated with Fortinet
MATCH (source:Tools {id: 'TOO188'}), (target:Tools {id: 'TOO101'})
MERGE (source)-[:ASSOCIATED_WITH {
    source_name: 'Operation Serengeti',
    target_name: 'Fortinet',
    relationship_id: 'REL177',
    original_relation: 'associated with',
    created_at: datetime()
}]->(target);

// Operation Serengeti associated with Cybercrime Atlas
MATCH (source:Tools {id: 'TOO188'}), (target:Attackers {id: 'ATT9'})
MERGE (source)-[:ASSOCIATED_WITH {
    source_name: 'Operation Serengeti',
    target_name: 'Cybercrime Atlas',
    relationship_id: 'REL178',
    original_relation: 'associated with',
    created_at: datetime()
}]->(target);

// Operation Serengeti associated with World Economic Forum’s Partnership Against Cybercrime
MATCH (source:Tools {id: 'TOO188'}), (target:Attackers {id: 'ATT26'})
MERGE (source)-[:ASSOCIATED_WITH {
    source_name: 'Operation Serengeti',
    target_name: 'World Economic Forum’s Partnership Against Cybercrime',
    relationship_id: 'REL179',
    original_relation: 'associated with',
    created_at: datetime()
}]->(target);

// Fortinet associated with Cybercrime Atlas
MATCH (source:Tools {id: 'TOO101'}), (target:Attackers {id: 'ATT9'})
MERGE (source)-[:ASSOCIATED_WITH {
    source_name: 'Fortinet',
    target_name: 'Cybercrime Atlas',
    relationship_id: 'REL180',
    original_relation: 'associated with',
    created_at: datetime()
}]->(target);

// Operation Serengeti target 19 participating countries
MATCH (source:Tools {id: 'TOO188'}), (target:Tools {id: 'TOO4'})
MERGE (source)-[:TARGET {
    source_name: 'Operation Serengeti',
    target_name: '19 participating countries',
    relationship_id: 'REL181',
    original_relation: 'target',
    created_at: datetime()
}]->(target);

// Operation Serengeti target 1
MATCH (source:Tools {id: 'TOO188'}), (target:Tools {id: 'TOO1'})
MERGE (source)-[:TARGET {
    source_name: 'Operation Serengeti',
    target_name: '1',
    relationship_id: 'REL182',
    original_relation: 'target',
    created_at: datetime()
}]->(target);

// Operation Serengeti target 135
MATCH (source:Tools {id: 'TOO188'}), (target:Tools {id: 'TOO3'})
MERGE (source)-[:TARGET {
    source_name: 'Operation Serengeti',
    target_name: '135',
    relationship_id: 'REL183',
    original_relation: 'target',
    created_at: datetime()
}]->(target);

// FortiGuard Labs highlight darknet
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO72'})
MERGE (source)-[:HIGHLIGHT {
    source_name: 'FortiGuard Labs',
    target_name: 'darknet',
    relationship_id: 'REL194',
    original_relation: 'highlight',
    created_at: datetime()
}]->(target);

// FortiGuard Labs highlight sophisticated website cloning tools
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO233'})
MERGE (source)-[:HIGHLIGHT {
    source_name: 'FortiGuard Labs',
    target_name: 'sophisticated website cloning tools',
    relationship_id: 'REL195',
    original_relation: 'highlight',
    created_at: datetime()
}]->(target);

// FortiGuard Labs highlight Sniffing tools
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO232'})
MERGE (source)-[:HIGHLIGHT {
    source_name: 'FortiGuard Labs',
    target_name: 'Sniffing tools',
    relationship_id: 'REL196',
    original_relation: 'highlight',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses phishing
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO192'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'phishing',
    relationship_id: 'REL197',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// phishing exploit CVE-2017-0199
MATCH (source:Tools {id: 'TOO192'}), (target:Vulnerabilities {id: 'VUL6'})
MERGE (source)-[:EXPLOIT {
    source_name: 'phishing',
    target_name: 'CVE-2017-0199',
    relationship_id: 'REL198',
    original_relation: 'exploit',
    created_at: datetime()
}]->(target);

// phishing deliver Remcos RAT
MATCH (source:Tools {id: 'TOO192'}), (target:Malware {id: 'MAL91'})
MERGE (source)-[:DELIVER {
    source_name: 'phishing',
    target_name: 'Remcos RAT',
    relationship_id: 'REL199',
    original_relation: 'deliver',
    created_at: datetime()
}]->(target);

// Winos4.0 derived from Gh0strat
MATCH (source:Tools {id: 'TOO278'}), (target:Malware {id: 'MAL39'})
MERGE (source)-[:DERIVED_FROM {
    source_name: 'Winos4.0',
    target_name: 'Gh0strat',
    relationship_id: 'REL203',
    original_relation: 'derived from',
    created_at: datetime()
}]->(target);

// Winos4.0 used in Silver Fox
MATCH (source:Tools {id: 'TOO278'}), (target:Tools {id: 'TOO227'})
MERGE (source)-[:USED_IN {
    source_name: 'Winos4.0',
    target_name: 'Silver Fox',
    relationship_id: 'REL204',
    original_relation: 'used in',
    created_at: datetime()
}]->(target);

// Winos4.0 targets Microsoft Windows
MATCH (source:Tools {id: 'TOO278'}), (target:Tools {id: 'TOO168'})
MERGE (source)-[:TARGETS {
    source_name: 'Winos4.0',
    target_name: 'Microsoft Windows',
    relationship_id: 'REL205',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// FortiGuard Labs exploit Ivanti Cloud Services Appliance
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO138'})
MERGE (source)-[:EXPLOIT {
    source_name: 'FortiGuard Labs',
    target_name: 'Ivanti Cloud Services Appliance',
    relationship_id: 'REL208',
    original_relation: 'exploit',
    created_at: datetime()
}]->(target);

// FortiGuard Labs exploit CVE-2024-8190
MATCH (source:Tools {id: 'TOO98'}), (target:Vulnerabilities {id: 'VUL22'})
MERGE (source)-[:EXPLOIT {
    source_name: 'FortiGuard Labs',
    target_name: 'CVE-2024-8190',
    relationship_id: 'REL209',
    original_relation: 'exploit',
    created_at: datetime()
}]->(target);

// FortiGuard Labs exploit Ivanti Cloud Services Appliance
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO138'})
MERGE (source)-[:EXPLOIT {
    source_name: 'FortiGuard Labs',
    target_name: 'Ivanti Cloud Services Appliance',
    relationship_id: 'REL210',
    original_relation: 'exploit',
    created_at: datetime()
}]->(target);

// FortiGuard Labs exploit CVE-2024-8190
MATCH (source:Tools {id: 'TOO98'}), (target:Vulnerabilities {id: 'VUL22'})
MERGE (source)-[:EXPLOIT {
    source_name: 'FortiGuard Labs',
    target_name: 'CVE-2024-8190',
    relationship_id: 'REL211',
    original_relation: 'exploit',
    created_at: datetime()
}]->(target);

// GeoServer exploit CVE-2024-36401
MATCH (source:Tools {id: 'TOO110'}), (target:Vulnerabilities {id: 'VUL20'})
MERGE (source)-[:EXPLOIT {
    source_name: 'GeoServer',
    target_name: 'CVE-2024-36401',
    relationship_id: 'REL212',
    original_relation: 'exploit',
    created_at: datetime()
}]->(target);

// CISA add CVE-2024-36401
MATCH (source:Tools {id: 'TOO51'}), (target:Vulnerabilities {id: 'VUL20'})
MERGE (source)-[:ADD {
    source_name: 'CISA',
    target_name: 'CVE-2024-36401',
    relationship_id: 'REL213',
    original_relation: 'add',
    created_at: datetime()
}]->(target);

// FortiGuard Labs use IPS
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO135'})
MERGE (source)-[:USE {
    source_name: 'FortiGuard Labs',
    target_name: 'IPS',
    relationship_id: 'REL214',
    original_relation: 'use',
    created_at: datetime()
}]->(target);

// botnet target CVE-2024-36401
MATCH (source:Tools {id: 'TOO32'}), (target:Vulnerabilities {id: 'VUL20'})
MERGE (source)-[:TARGET {
    source_name: 'botnet',
    target_name: 'CVE-2024-36401',
    relationship_id: 'REL215',
    original_relation: 'target',
    created_at: datetime()
}]->(target);

// FortiGuard Labs published Outbreak Alert
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO189'})
MERGE (source)-[:PUBLISHED {
    source_name: 'FortiGuard Labs',
    target_name: 'Outbreak Alert',
    relationship_id: 'REL228',
    original_relation: 'published',
    created_at: datetime()
}]->(target);

// phishing targets Windows Users
MATCH (source:Tools {id: 'TOO192'}), (target:Tools {id: 'TOO277'})
MERGE (source)-[:TARGETS {
    source_name: 'phishing',
    target_name: 'Windows Users',
    relationship_id: 'REL231',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// phishing uses Excel
MATCH (source:Tools {id: 'TOO192'}), (target:Tools {id: 'TOO89'})
MERGE (source)-[:USES {
    source_name: 'phishing',
    target_name: 'Excel',
    relationship_id: 'REL232',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// phishing delivers Snake Keylogger
MATCH (source:Tools {id: 'TOO192'}), (target:Malware {id: 'MAL105'})
MERGE (source)-[:DELIVERS {
    source_name: 'phishing',
    target_name: 'Snake Keylogger',
    relationship_id: 'REL233',
    original_relation: 'delivers',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses phishing
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO192'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'phishing',
    relationship_id: 'REL245',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses VenomRAT
MATCH (source:Tools {id: 'TOO98'}), (target:Malware {id: 'MAL121'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'VenomRAT',
    relationship_id: 'REL246',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses ScrubCrypt
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO223'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'ScrubCrypt',
    relationship_id: 'REL247',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// phishing deploy XWorm
MATCH (source:Tools {id: 'TOO192'}), (target:Malware {id: 'MAL127'})
MERGE (source)-[:DEPLOY {
    source_name: 'phishing',
    target_name: 'XWorm',
    relationship_id: 'REL248',
    original_relation: 'deploy',
    created_at: datetime()
}]->(target);

// phishing deploy AsyncRAT
MATCH (source:Tools {id: 'TOO192'}), (target:Malware {id: 'MAL12'})
MERGE (source)-[:DEPLOY {
    source_name: 'phishing',
    target_name: 'AsyncRAT',
    relationship_id: 'REL249',
    original_relation: 'deploy',
    created_at: datetime()
}]->(target);

// phishing deploy PureHVNC
MATCH (source:Tools {id: 'TOO192'}), (target:Malware {id: 'MAL80'})
MERGE (source)-[:DEPLOY {
    source_name: 'phishing',
    target_name: 'PureHVNC',
    relationship_id: 'REL250',
    original_relation: 'deploy',
    created_at: datetime()
}]->(target);

// FortiGuard Labs detect zlibxjson
MATCH (source:Tools {id: 'TOO98'}), (target:Files {id: 'FIL153'})
MERGE (source)-[:DETECT {
    source_name: 'FortiGuard Labs',
    target_name: 'zlibxjson',
    relationship_id: 'REL260',
    original_relation: 'detect',
    created_at: datetime()
}]->(target);

// Smishing Triad uses iMessage
MATCH (source:Tools {id: 'TOO230'}), (target:Tools {id: 'TOO131'})
MERGE (source)-[:USES {
    source_name: 'Smishing Triad',
    target_name: 'iMessage',
    relationship_id: 'REL264',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Smishing Triad uses Hotmail
MATCH (source:Tools {id: 'TOO230'}), (target:Tools {id: 'TOO127'})
MERGE (source)-[:USES {
    source_name: 'Smishing Triad',
    target_name: 'Hotmail',
    relationship_id: 'REL265',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Smishing Triad uses Gmail
MATCH (source:Tools {id: 'TOO230'}), (target:Tools {id: 'TOO116'})
MERGE (source)-[:USES {
    source_name: 'Smishing Triad',
    target_name: 'Gmail',
    relationship_id: 'REL266',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Smishing Triad uses Yahoo
MATCH (source:Tools {id: 'TOO230'}), (target:Tools {id: 'TOO285'})
MERGE (source)-[:USES {
    source_name: 'Smishing Triad',
    target_name: 'Yahoo',
    relationship_id: 'REL267',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// iMessage uses Apple ID
MATCH (source:Tools {id: 'TOO131'}), (target:Tools {id: 'TOO19'})
MERGE (source)-[:USES {
    source_name: 'iMessage',
    target_name: 'Apple ID',
    relationship_id: 'REL268',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Apple ID uses Apple
MATCH (source:Tools {id: 'TOO19'}), (target:Attackers {id: 'ATT2'})
MERGE (source)-[:USES {
    source_name: 'Apple ID',
    target_name: 'Apple',
    relationship_id: 'REL269',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Spyware exploit CVE-2021-40444
MATCH (source:Tools {id: 'TOO235'}), (target:Vulnerabilities {id: 'VUL12'})
MERGE (source)-[:EXPLOIT {
    source_name: 'Spyware',
    target_name: 'CVE-2021-40444',
    relationship_id: 'REL270',
    original_relation: 'exploit',
    created_at: datetime()
}]->(target);

// MSHTML part of Microsoft Office
MATCH (source:Tools {id: 'TOO177'}), (target:Tools {id: 'TOO167'})
MERGE (source)-[:PART_OF {
    source_name: 'MSHTML',
    target_name: 'Microsoft Office',
    relationship_id: 'REL274',
    original_relation: 'part of',
    created_at: datetime()
}]->(target);

// UNSTABLE uses VCRUMS
MATCH (source:Tools {id: 'TOO260'}), (target:Malware {id: 'MAL119'})
MERGE (source)-[:USES {
    source_name: 'UNSTABLE',
    target_name: 'VCRUMS',
    relationship_id: 'REL279',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// UNSTABLE uses SYK Crypto
MATCH (source:Tools {id: 'TOO260'}), (target:Malware {id: 'MAL111'})
MERGE (source)-[:USES {
    source_name: 'UNSTABLE',
    target_name: 'SYK Crypto',
    relationship_id: 'REL280',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// UNSTABLE exploits JAWS Webserver RCE vulnerability
MATCH (source:Tools {id: 'TOO260'}), (target:Vulnerabilities {id: 'VUL25'})
MERGE (source)-[:EXPLOITS {
    source_name: 'UNSTABLE',
    target_name: 'JAWS Webserver RCE vulnerability',
    relationship_id: 'REL281',
    original_relation: 'exploits',
    created_at: datetime()
}]->(target);

// UNSTABLE exploits CV
MATCH (source:Tools {id: 'TOO260'}), (target:Vulnerabilities {id: 'VUL2'})
MERGE (source)-[:EXPLOITS {
    source_name: 'UNSTABLE',
    target_name: 'CV',
    relationship_id: 'REL282',
    original_relation: 'exploits',
    created_at: datetime()
}]->(target);

// Condi uses AWS
MATCH (source:Tools {id: 'TOO56'}), (target:Tools {id: 'TOO23'})
MERGE (source)-[:USES {
    source_name: 'Condi',
    target_name: 'AWS',
    relationship_id: 'REL283',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Condi uses DriveHQ
MATCH (source:Tools {id: 'TOO56'}), (target:Tools {id: 'TOO83'})
MERGE (source)-[:USES {
    source_name: 'Condi',
    target_name: 'DriveHQ',
    relationship_id: 'REL284',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// VBA downloader use forfiles.exe
MATCH (source:Tools {id: 'TOO263'}), (target:Files {id: 'FIL87'})
MERGE (source)-[:USE {
    source_name: 'VBA downloader',
    target_name: 'forfiles.exe',
    relationship_id: 'REL293',
    original_relation: 'use',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses malicious Excel document
MATCH (source:Tools {id: 'TOO98'}), (target:Files {id: 'FIL103'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'malicious Excel document',
    relationship_id: 'REL307',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// VBA macro deploy Cobalt Strike
MATCH (source:Tools {id: 'TOO265'}), (target:Tools {id: 'TOO54'})
MERGE (source)-[:DEPLOY {
    source_name: 'VBA macro',
    target_name: 'Cobalt Strike',
    relationship_id: 'REL309',
    original_relation: 'deploy',
    created_at: datetime()
}]->(target);

// Ukraine target FortiGuard Labs
MATCH (source:Tools {id: 'TOO257'}), (target:Tools {id: 'TOO98'})
MERGE (source)-[:TARGET {
    source_name: 'Ukraine',
    target_name: 'FortiGuard Labs',
    relationship_id: 'REL310',
    original_relation: 'target',
    created_at: datetime()
}]->(target);

// UAC-0057 deploy XLS file
MATCH (source:Tools {id: 'TOO256'}), (target:Files {id: 'FIL148'})
MERGE (source)-[:DEPLOY {
    source_name: 'UAC-0057',
    target_name: 'XLS file',
    relationship_id: 'REL311',
    original_relation: 'deploy',
    created_at: datetime()
}]->(target);

// Goldoon exploit CVE-2015-2051
MATCH (source:Tools {id: 'TOO117'}), (target:Vulnerabilities {id: 'VUL4'})
MERGE (source)-[:EXPLOIT {
    source_name: 'Goldoon',
    target_name: 'CVE-2015-2051',
    relationship_id: 'REL319',
    original_relation: 'exploit',
    created_at: datetime()
}]->(target);

// Goldoon download dropper
MATCH (source:Tools {id: 'TOO117'}), (target:Files {id: 'FIL67'})
MERGE (source)-[:DOWNLOAD {
    source_name: 'Goldoon',
    target_name: 'dropper',
    relationship_id: 'REL320',
    original_relation: 'download',
    created_at: datetime()
}]->(target);

// FortiGuard Labs detect discordpy_bypass-1.7
MATCH (source:Tools {id: 'TOO98'}), (target:Malware {id: 'MAL28'})
MERGE (source)-[:DETECT {
    source_name: 'FortiGuard Labs',
    target_name: 'discordpy_bypass-1.7',
    relationship_id: 'REL333',
    original_relation: 'detect',
    created_at: datetime()
}]->(target);

// theaos author discordpy_bypass-1.7
MATCH (source:Tools {id: 'TOO247'}), (target:Malware {id: 'MAL28'})
MERGE (source)-[:AUTHOR {
    source_name: 'theaos',
    target_name: 'discordpy_bypass-1.7',
    relationship_id: 'REL334',
    original_relation: 'author',
    created_at: datetime()
}]->(target);

// theaos author upgrade-colored_0.0.1
MATCH (source:Tools {id: 'TOO247'}), (target:Malware {id: 'MAL116'})
MERGE (source)-[:AUTHOR {
    source_name: 'theaos',
    target_name: 'upgrade-colored_0.0.1',
    relationship_id: 'REL335',
    original_relation: 'author',
    created_at: datetime()
}]->(target);

// Moobot associated with CVE-2023-1389
MATCH (source:Tools {id: 'TOO174'}), (target:Vulnerabilities {id: 'VUL15'})
MERGE (source)-[:ASSOCIATED_WITH {
    source_name: 'Moobot',
    target_name: 'CVE-2023-1389',
    relationship_id: 'REL338',
    original_relation: 'associated with',
    created_at: datetime()
}]->(target);

// Miori associated with CVE-2023-1389
MATCH (source:Tools {id: 'TOO172'}), (target:Vulnerabilities {id: 'VUL15'})
MERGE (source)-[:ASSOCIATED_WITH {
    source_name: 'Miori',
    target_name: 'CVE-2023-1389',
    relationship_id: 'REL339',
    original_relation: 'associated with',
    created_at: datetime()
}]->(target);

// Gafgyt Variant associated with CVE-2023-1389
MATCH (source:Tools {id: 'TOO108'}), (target:Vulnerabilities {id: 'VUL15'})
MERGE (source)-[:ASSOCIATED_WITH {
    source_name: 'Gafgyt Variant',
    target_name: 'CVE-2023-1389',
    relationship_id: 'REL341',
    original_relation: 'associated with',
    created_at: datetime()
}]->(target);

// FortiGuard Labs targets Oracle WebLogic Servers
MATCH (source:Tools {id: 'TOO98'}), (target:Vulnerabilities {id: 'VUL26'})
MERGE (source)-[:TARGETS {
    source_name: 'FortiGuard Labs',
    target_name: 'Oracle WebLogic Servers',
    relationship_id: 'REL343',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// ScrubCrypt used by Threat Actor
MATCH (source:Tools {id: 'TOO223'}), (target:Attackers {id: 'ATT24'})
MERGE (source)-[:USED_BY {
    source_name: 'ScrubCrypt',
    target_name: 'Threat Actor',
    relationship_id: 'REL344',
    original_relation: 'used by',
    created_at: datetime()
}]->(target);

// ScrubCrypt loads VenomRAT
MATCH (source:Tools {id: 'TOO223'}), (target:Malware {id: 'MAL121'})
MERGE (source)-[:LOADS {
    source_name: 'ScrubCrypt',
    target_name: 'VenomRAT',
    relationship_id: 'REL348',
    original_relation: 'loads',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses phishing
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO192'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'phishing',
    relationship_id: 'REL364',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses VCURMS
MATCH (source:Tools {id: 'TOO98'}), (target:Malware {id: 'MAL120'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'VCURMS',
    relationship_id: 'REL365',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses STRRAT
MATCH (source:Tools {id: 'TOO98'}), (target:Malware {id: 'MAL110'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'STRRAT',
    relationship_id: 'REL366',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses Amazon Web Services
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO14'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'Amazon Web Services',
    relationship_id: 'REL367',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses GitHub
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO114'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'GitHub',
    relationship_id: 'REL368',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses Proton Mail
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO202'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'Proton Mail',
    relationship_id: 'REL369',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiGuard Labs download JAR
MATCH (source:Tools {id: 'TOO98'}), (target:Files {id: 'FIL97'})
MERGE (source)-[:DOWNLOAD {
    source_name: 'FortiGuard Labs',
    target_name: 'JAR',
    relationship_id: 'REL370',
    original_relation: 'download',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses PDF
MATCH (source:Tools {id: 'TOO98'}), (target:Files {id: 'FIL115'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'PDF',
    relationship_id: 'REL371',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiGuard Labs targets Microsoft Windows
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO168'})
MERGE (source)-[:TARGETS {
    source_name: 'FortiGuard Labs',
    target_name: 'Microsoft Windows',
    relationship_id: 'REL401',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// VBA script execute PowerShell
MATCH (source:Tools {id: 'TOO266'}), (target:Tools {id: 'TOO201'})
MERGE (source)-[:EXECUTE {
    source_name: 'VBA script',
    target_name: 'PowerShell',
    relationship_id: 'REL404',
    original_relation: 'execute',
    created_at: datetime()
}]->(target);

// PowerShell download Windows Update.bat
MATCH (source:Tools {id: 'TOO201'}), (target:Files {id: 'FIL145'})
MERGE (source)-[:DOWNLOAD {
    source_name: 'PowerShell',
    target_name: 'Windows Update.bat',
    relationship_id: 'REL405',
    original_relation: 'download',
    created_at: datetime()
}]->(target);

// Albabat aka White Bat
MATCH (source:Tools {id: 'TOO13'}), (target:Malware {id: 'MAL124'})
MERGE (source)-[:AKA {
    source_name: 'Albabat',
    target_name: 'White Bat',
    relationship_id: 'REL412',
    original_relation: 'aka',
    created_at: datetime()
}]->(target);

// Albabat is a Ransomware
MATCH (source:Tools {id: 'TOO13'}), (target:Malware {id: 'MAL84'})
MERGE (source)-[:IS_A {
    source_name: 'Albabat',
    target_name: 'Ransomware',
    relationship_id: 'REL413',
    original_relation: 'is a',
    created_at: datetime()
}]->(target);

// Albabat written in Rust
MATCH (source:Tools {id: 'TOO13'}), (target:Tools {id: 'TOO219'})
MERGE (source)-[:WRITTEN_IN {
    source_name: 'Albabat',
    target_name: 'Rust',
    relationship_id: 'REL414',
    original_relation: 'written in',
    created_at: datetime()
}]->(target);

// Albabat distributed as rogue software
MATCH (source:Tools {id: 'TOO13'}), (target:Tools {id: 'TOO215'})
MERGE (source)-[:DISTRIBUTED_AS {
    source_name: 'Albabat',
    target_name: 'rogue software',
    relationship_id: 'REL415',
    original_relation: 'distributed as',
    created_at: datetime()
}]->(target);

// Albabat distributed as fake Windows 10 digital activation tool
MATCH (source:Tools {id: 'TOO13'}), (target:Tools {id: 'TOO91'})
MERGE (source)-[:DISTRIBUTED_AS {
    source_name: 'Albabat',
    target_name: 'fake Windows 10 digital activation tool',
    relationship_id: 'REL416',
    original_relation: 'distributed as',
    created_at: datetime()
}]->(target);

// Albabat distributed as cheat program for the Counter-Strike 2 game
MATCH (source:Tools {id: 'TOO13'}), (target:Tools {id: 'TOO44'})
MERGE (source)-[:DISTRIBUTED_AS {
    source_name: 'Albabat',
    target_name: 'cheat program for the Counter-Strike 2 game',
    relationship_id: 'REL417',
    original_relation: 'distributed as',
    created_at: datetime()
}]->(target);

// Albabat targets Microsoft Windows
MATCH (source:Tools {id: 'TOO13'}), (target:Tools {id: 'TOO168'})
MERGE (source)-[:TARGETS {
    source_name: 'Albabat',
    target_name: 'Microsoft Windows',
    relationship_id: 'REL418',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// Phobos contains EKING
MATCH (source:Tools {id: 'TOO193'}), (target:Malware {id: 'MAL30'})
MERGE (source)-[:CONTAINS {
    source_name: 'Phobos',
    target_name: 'EKING',
    relationship_id: 'REL419',
    original_relation: 'contains',
    created_at: datetime()
}]->(target);

// Phobos contains 8base
MATCH (source:Tools {id: 'TOO193'}), (target:Malware {id: 'MAL2'})
MERGE (source)-[:CONTAINS {
    source_name: 'Phobos',
    target_name: '8base',
    relationship_id: 'REL420',
    original_relation: 'contains',
    created_at: datetime()
}]->(target);

// Phobos contains FAUST
MATCH (source:Tools {id: 'TOO193'}), (target:Malware {id: 'MAL35'})
MERGE (source)-[:CONTAINS {
    source_name: 'Phobos',
    target_name: 'FAUST',
    relationship_id: 'REL421',
    original_relation: 'contains',
    created_at: datetime()
}]->(target);

// VBA script triggers PowerShell
MATCH (source:Tools {id: 'TOO266'}), (target:Tools {id: 'TOO201'})
MERGE (source)-[:TRIGGERS {
    source_name: 'VBA script',
    target_name: 'PowerShell',
    relationship_id: 'REL423',
    original_relation: 'triggers',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses PyPI
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO206'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'PyPI',
    relationship_id: 'REL425',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// WS drop nigpal
MATCH (source:Tools {id: 'TOO282'}), (target:Files {id: 'FIL112'})
MERGE (source)-[:DROP {
    source_name: 'WS',
    target_name: 'nigpal',
    relationship_id: 'REL426',
    original_relation: 'drop',
    created_at: datetime()
}]->(target);

// WS drop figflix
MATCH (source:Tools {id: 'TOO282'}), (target:Files {id: 'FIL81'})
MERGE (source)-[:DROP {
    source_name: 'WS',
    target_name: 'figflix',
    relationship_id: 'REL427',
    original_relation: 'drop',
    created_at: datetime()
}]->(target);

// WS drop telerer
MATCH (source:Tools {id: 'TOO282'}), (target:Files {id: 'FIL136'})
MERGE (source)-[:DROP {
    source_name: 'WS',
    target_name: 'telerer',
    relationship_id: 'REL428',
    original_relation: 'drop',
    created_at: datetime()
}]->(target);

// WS drop seGMM
MATCH (source:Tools {id: 'TOO282'}), (target:Files {id: 'FIL127'})
MERGE (source)-[:DROP {
    source_name: 'WS',
    target_name: 'seGMM',
    relationship_id: 'REL429',
    original_relation: 'drop',
    created_at: datetime()
}]->(target);

// WS drop fbdebug
MATCH (source:Tools {id: 'TOO282'}), (target:Files {id: 'FIL80'})
MERGE (source)-[:DROP {
    source_name: 'WS',
    target_name: 'fbdebug',
    relationship_id: 'REL430',
    original_relation: 'drop',
    created_at: datetime()
}]->(target);

// WS drop sGMM
MATCH (source:Tools {id: 'TOO282'}), (target:Files {id: 'FIL129'})
MERGE (source)-[:DROP {
    source_name: 'WS',
    target_name: 'sGMM',
    relationship_id: 'REL431',
    original_relation: 'drop',
    created_at: datetime()
}]->(target);

// WS drop myGens
MATCH (source:Tools {id: 'TOO282'}), (target:Files {id: 'FIL110'})
MERGE (source)-[:DROP {
    source_name: 'WS',
    target_name: 'myGens',
    relationship_id: 'REL432',
    original_relation: 'drop',
    created_at: datetime()
}]->(target);

// WS drop NewGends
MATCH (source:Tools {id: 'TOO282'}), (target:Files {id: 'FIL111'})
MERGE (source)-[:DROP {
    source_name: 'WS',
    target_name: 'NewGends',
    relationship_id: 'REL433',
    original_relation: 'drop',
    created_at: datetime()
}]->(target);

// WS drop TestLibs111
MATCH (source:Tools {id: 'TOO282'}), (target:Files {id: 'FIL140'})
MERGE (source)-[:DROP {
    source_name: 'WS',
    target_name: 'TestLibs111',
    relationship_id: 'REL434',
    original_relation: 'drop',
    created_at: datetime()
}]->(target);

// WS associated with Checkmarxblog
MATCH (source:Tools {id: 'TOO282'}), (target:Tools {id: 'TOO45'})
MERGE (source)-[:ASSOCIATED_WITH {
    source_name: 'WS',
    target_name: 'Checkmarxblog',
    relationship_id: 'REL435',
    original_relation: 'associated with',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses YouTube
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO287'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'YouTube',
    relationship_id: 'REL436',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses TinyURL
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO248'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'TinyURL',
    relationship_id: 'REL437',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses Cuttly
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO67'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'Cuttly',
    relationship_id: 'REL438',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses GitHub
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO114'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'GitHub',
    relationship_id: 'REL439',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses MediaFire
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO164'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'MediaFire',
    relationship_id: 'REL440',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Lumma Stealer communicatesWith C2 server
MATCH (source:Tools {id: 'TOO159'}), (target:Tools {id: 'TOO38'})
MERGE (source)-[:COMMUNICATESWITH {
    source_name: 'Lumma Stealer',
    target_name: 'C2 server',
    relationship_id: 'REL441',
    original_relation: 'communicatesWith',
    created_at: datetime()
}]->(target);

// FortiGuard Labs detect CoinMiner
MATCH (source:Tools {id: 'TOO98'}), (target:Malware {id: 'MAL21'})
MERGE (source)-[:DETECT {
    source_name: 'FortiGuard Labs',
    target_name: 'CoinMiner',
    relationship_id: 'REL442',
    original_relation: 'detect',
    created_at: datetime()
}]->(target);

// FortiGuard Labs detects email phishing
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO86'})
MERGE (source)-[:DETECTS {
    source_name: 'FortiGuard Labs',
    target_name: 'email phishing',
    relationship_id: 'REL464',
    original_relation: 'detects',
    created_at: datetime()
}]->(target);

// email phishing targets Microsoft Windows
MATCH (source:Tools {id: 'TOO86'}), (target:Tools {id: 'TOO168'})
MERGE (source)-[:TARGETS {
    source_name: 'email phishing',
    target_name: 'Microsoft Windows',
    relationship_id: 'REL465',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// email phishing uses malicious PDF file
MATCH (source:Tools {id: 'TOO86'}), (target:Files {id: 'FIL104'})
MERGE (source)-[:USES {
    source_name: 'email phishing',
    target_name: 'malicious PDF file',
    relationship_id: 'REL466',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// PowerShell fetches MrAnon Stealer
MATCH (source:Tools {id: 'TOO201'}), (target:Malware {id: 'MAL71'})
MERGE (source)-[:FETCHES {
    source_name: 'PowerShell',
    target_name: 'MrAnon Stealer',
    relationship_id: 'REL470',
    original_relation: 'fetches',
    created_at: datetime()
}]->(target);

// Apache Active MQ contains CVE-2023-46604
MATCH (source:Tools {id: 'TOO17'}), (target:Vulnerabilities {id: 'VUL17'})
MERGE (source)-[:CONTAINS {
    source_name: 'Apache Active MQ',
    target_name: 'CVE-2023-46604',
    relationship_id: 'REL476',
    original_relation: 'contains',
    created_at: datetime()
}]->(target);

// FortiGuard Labs released Outbreak Alert
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO189'})
MERGE (source)-[:RELEASED {
    source_name: 'FortiGuard Labs',
    target_name: 'Outbreak Alert',
    relationship_id: 'REL477',
    original_relation: 'released',
    created_at: datetime()
}]->(target);

// FortiGuard Labs detected GoTitan
MATCH (source:Tools {id: 'TOO98'}), (target:Malware {id: 'MAL41'})
MERGE (source)-[:DETECTED {
    source_name: 'FortiGuard Labs',
    target_name: 'GoTitan',
    relationship_id: 'REL478',
    original_relation: 'detected',
    created_at: datetime()
}]->(target);

// FortiGuard Labs detected PrCtrl Rat
MATCH (source:Tools {id: 'TOO98'}), (target:Malware {id: 'MAL79'})
MERGE (source)-[:DETECTED {
    source_name: 'FortiGuard Labs',
    target_name: 'PrCtrl Rat',
    relationship_id: 'REL479',
    original_relation: 'detected',
    created_at: datetime()
}]->(target);

// FortiGuard Labs identified Sliver
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO229'})
MERGE (source)-[:IDENTIFIED {
    source_name: 'FortiGuard Labs',
    target_name: 'Sliver',
    relationship_id: 'REL480',
    original_relation: 'identified',
    created_at: datetime()
}]->(target);

// Konni uses RAT
MATCH (source:Tools {id: 'TOO146'}), (target:Tools {id: 'TOO212'})
MERGE (source)-[:USES {
    source_name: 'Konni',
    target_name: 'RAT',
    relationship_id: 'REL481',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Konni targets Microsoft Windows
MATCH (source:Tools {id: 'TOO146'}), (target:Tools {id: 'TOO168'})
MERGE (source)-[:TARGETS {
    source_name: 'Konni',
    target_name: 'Microsoft Windows',
    relationship_id: 'REL482',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// VBA script uses OLEFormat.IconLabel
MATCH (source:Tools {id: 'TOO266'}), (target:Tools {id: 'TOO186'})
MERGE (source)-[:USES {
    source_name: 'VBA script',
    target_name: 'OLEFormat.IconLabel',
    relationship_id: 'REL483',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// VBA script drop temp.zip
MATCH (source:Tools {id: 'TOO266'}), (target:Files {id: 'FIL138'})
MERGE (source)-[:DROP {
    source_name: 'VBA script',
    target_name: 'temp.zip',
    relationship_id: 'REL484',
    original_relation: 'drop',
    created_at: datetime()
}]->(target);

// VBA script execute check.bat
MATCH (source:Tools {id: 'TOO266'}), (target:Files {id: 'FIL51'})
MERGE (source)-[:EXECUTE {
    source_name: 'VBA script',
    target_name: 'check.bat',
    relationship_id: 'REL485',
    original_relation: 'execute',
    created_at: datetime()
}]->(target);

// Rhysida uses PowerShell
MATCH (source:Tools {id: 'TOO214'}), (target:Tools {id: 'TOO201'})
MERGE (source)-[:USES {
    source_name: 'Rhysida',
    target_name: 'PowerShell',
    relationship_id: 'REL486',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Rhysida uses PSExec
MATCH (source:Tools {id: 'TOO214'}), (target:Tools {id: 'TOO203'})
MERGE (source)-[:USES {
    source_name: 'Rhysida',
    target_name: 'PSExec',
    relationship_id: 'REL487',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Rhysida uses AnyDesk
MATCH (source:Tools {id: 'TOO214'}), (target:Tools {id: 'TOO16'})
MERGE (source)-[:USES {
    source_name: 'Rhysida',
    target_name: 'AnyDesk',
    relationship_id: 'REL488',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Rhysida uses WinSCP
MATCH (source:Tools {id: 'TOO214'}), (target:Tools {id: 'TOO280'})
MERGE (source)-[:USES {
    source_name: 'Rhysida',
    target_name: 'WinSCP',
    relationship_id: 'REL489',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Rhysida deploy Rhysida ransomware
MATCH (source:Tools {id: 'TOO214'}), (target:Malware {id: 'MAL95'})
MERGE (source)-[:DEPLOY {
    source_name: 'Rhysida',
    target_name: 'Rhysida ransomware',
    relationship_id: 'REL490',
    original_relation: 'deploy',
    created_at: datetime()
}]->(target);

// Rhysida offer RaaS
MATCH (source:Tools {id: 'TOO214'}), (target:Tools {id: 'TOO210'})
MERGE (source)-[:OFFER {
    source_name: 'Rhysida',
    target_name: 'RaaS',
    relationship_id: 'REL491',
    original_relation: 'offer',
    created_at: datetime()
}]->(target);

// Rhysida use ESXi-based ransomware
MATCH (source:Tools {id: 'TOO214'}), (target:Malware {id: 'MAL33'})
MERGE (source)-[:USE {
    source_name: 'Rhysida',
    target_name: 'ESXi-based ransomware',
    relationship_id: 'REL492',
    original_relation: 'use',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses Cybercrime-as-a-Service
MATCH (source:Tools {id: 'TOO98'}), (target:Attackers {id: 'ATT10'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'Cybercrime-as-a-Service',
    relationship_id: 'REL502',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses generative AI
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO109'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'generative AI',
    relationship_id: 'REL503',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses CaaS
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO39'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'CaaS',
    relationship_id: 'REL504',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses APT
MATCH (source:Tools {id: 'TOO98'}), (target:Attackers {id: 'ATT3'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'APT',
    relationship_id: 'REL505',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// advisory issued by CERT Italy
MATCH (source:Tools {id: 'TOO11'}), (target:Tools {id: 'TOO43'})
MERGE (source)-[:ISSUED_BY {
    source_name: 'advisory',
    target_name: 'CERT Italy',
    relationship_id: 'REL513',
    original_relation: 'issued by',
    created_at: datetime()
}]->(target);

// FortiGuard Labs protects against Akira
MATCH (source:Tools {id: 'TOO98'}), (target:Malware {id: 'MAL8'})
MERGE (source)-[:PROTECTS_AGAINST {
    source_name: 'FortiGuard Labs',
    target_name: 'Akira',
    relationship_id: 'REL523',
    original_relation: 'protects against',
    created_at: datetime()
}]->(target);

// Fortinet partners with FortiGuard Labs
MATCH (source:Tools {id: 'TOO101'}), (target:Tools {id: 'TOO98'})
MERGE (source)-[:PARTNERS_WITH {
    source_name: 'Fortinet',
    target_name: 'FortiGuard Labs',
    relationship_id: 'REL524',
    original_relation: 'partners with',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses NPM
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO184'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'NPM',
    relationship_id: 'REL530',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses JavaScript
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO141'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'JavaScript',
    relationship_id: 'REL531',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses PyPI
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO206'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'PyPI',
    relationship_id: 'REL532',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses index.js
MATCH (source:Tools {id: 'TOO98'}), (target:Files {id: 'FIL93'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'index.js',
    relationship_id: 'REL533',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiGuard Labs targets Azerbaijanian company
MATCH (source:Tools {id: 'TOO98'}), (target:Attackers {id: 'ATT4'})
MERGE (source)-[:TARGETS {
    source_name: 'FortiGuard Labs',
    target_name: 'Azerbaijanian company',
    relationship_id: 'REL534',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// FortiGuard Labs targets Azerbaijan
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO25'})
MERGE (source)-[:TARGETS {
    source_name: 'FortiGuard Labs',
    target_name: 'Azerbaijan',
    relationship_id: 'REL535',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// FortiGuard Labs targets Armenia
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO21'})
MERGE (source)-[:TARGETS {
    source_name: 'FortiGuard Labs',
    target_name: 'Armenia',
    relationship_id: 'REL536',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// FortiGuard Labs targets Windows
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO275'})
MERGE (source)-[:TARGETS {
    source_name: 'FortiGuard Labs',
    target_name: 'Windows',
    relationship_id: 'REL539',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses Word document
MATCH (source:Tools {id: 'TOO98'}), (target:Files {id: 'FIL146'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'Word document',
    relationship_id: 'REL540',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses OriginBotnet
MATCH (source:Tools {id: 'TOO98'}), (target:Malware {id: 'MAL77'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'OriginBotnet',
    relationship_id: 'REL541',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses RedLine Clipper
MATCH (source:Tools {id: 'TOO98'}), (target:Malware {id: 'MAL89'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'RedLine Clipper',
    relationship_id: 'REL542',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses AgentTesla
MATCH (source:Tools {id: 'TOO98'}), (target:Malware {id: 'MAL6'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'AgentTesla',
    relationship_id: 'REL543',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Aphishingemail uses Word document
MATCH (source:Tools {id: 'TOO18'}), (target:Files {id: 'FIL146'})
MERGE (source)-[:USES {
    source_name: 'Aphishingemail',
    target_name: 'Word document',
    relationship_id: 'REL544',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// phishing used by Agent Tesla
MATCH (source:Tools {id: 'TOO192'}), (target:Malware {id: 'MAL5'})
MERGE (source)-[:USED_BY {
    source_name: 'phishing',
    target_name: 'Agent Tesla',
    relationship_id: 'REL548',
    original_relation: 'used by',
    created_at: datetime()
}]->(target);

// phishing targets Windows Users
MATCH (source:Tools {id: 'TOO192'}), (target:Tools {id: 'TOO277'})
MERGE (source)-[:TARGETS {
    source_name: 'phishing',
    target_name: 'Windows Users',
    relationship_id: 'REL551',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// FortiGuard Labs detects Agent Tesla
MATCH (source:Tools {id: 'TOO98'}), (target:Malware {id: 'MAL5'})
MERGE (source)-[:DETECTS {
    source_name: 'FortiGuard Labs',
    target_name: 'Agent Tesla',
    relationship_id: 'REL552',
    original_relation: 'detects',
    created_at: datetime()
}]->(target);

// FortiGuard Labs mitigates 3000
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO6'})
MERGE (source)-[:MITIGATES {
    source_name: 'FortiGuard Labs',
    target_name: '3000',
    relationship_id: 'REL553',
    original_relation: 'mitigates',
    created_at: datetime()
}]->(target);

// FortiGuard Labs observes 1300
MATCH (source:Tools {id: 'TOO98'}), (target:Tools {id: 'TOO2'})
MERGE (source)-[:OBSERVES {
    source_name: 'FortiGuard Labs',
    target_name: '1300',
    relationship_id: 'REL554',
    original_relation: 'observes',
    created_at: datetime()
}]->(target);

// ========================================
// 3. VERIFICATION QUERIES
// ========================================

// Count Tools outgoing relationships
MATCH (s:Tools)-[r]->()
RETURN type(r) AS relationship_type, count(r) AS count
ORDER BY count DESC;

// Show sample Tools relationships
MATCH (s:Tools)-[r]->(target)
RETURN s.name AS source, type(r) AS relationship,
       labels(target)[0] AS target_type, target.name AS target
ORDER BY source, relationship
LIMIT 20;

// Summary: Relationship types for Tools
// USES: 59
// TARGETS: 23
// ASSOCIATED_WITH: 12
// DROP: 12
// DEPLOY: 10
// EXPLOIT: 9
// USED_BY: 6
// EXPLOITS: 6
// TARGET: 6
// USE: 5
// DETECTS: 4
// EXECUTE: 4
// DOWNLOAD: 4
// CONTAINS: 4
// HIGHLIGHT: 3
// DETECT: 3
// DISTRIBUTED_AS: 3
// IS: 2
// DELIVERS: 2
// PROVIDE_COVERAGE_FOR: 2
// DELIVER: 2
// AUTHOR: 2
// DETECTED: 2
// ANALYZE: 1
// COMMUNICATE_WITH: 1
// LAUNCH: 1
// HAS_SUBJECT: 1
// INVESTIGATES: 1
// DERIVED_FROM: 1
// USED_IN: 1
// ADD: 1
// PUBLISHED: 1
// PART_OF: 1
// LOADS: 1
// AKA: 1
// IS_A: 1
// WRITTEN_IN: 1
// TRIGGERS: 1
// COMMUNICATESWITH: 1
// FETCHES: 1
// RELEASED: 1
// IDENTIFIED: 1
// OFFER: 1
// ISSUED_BY: 1
// PROTECTS_AGAINST: 1
// PARTNERS_WITH: 1
// MITIGATES: 1
// OBSERVES: 1