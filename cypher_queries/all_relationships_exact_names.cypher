// ========================================
// ALL RELATIONSHIPS WITH EXACT NAMES
// Auto-generated from relationships_norm.csv
// ========================================

// Create constraints first
CREATE CONSTRAINT IF NOT EXISTS FOR (a:Attackers) REQUIRE a.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (m:Malware) REQUIRE m.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (t:Tools) REQUIRE t.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (v:Vulnerabilities) REQUIRE v.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (f:Files) REQUIRE f.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (u:Urls) REQUIRE u.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (tech:Techniques) REQUIRE tech.id IS UNIQUE;

// ========================================
// RELATIONSHIPS
// ========================================

// FortiGuard Labs detects XWorm
MATCH (source:Tools {id: 'TOO29'}), (target:Malware {id: 'MAL46'})
MERGE (source)-[:DETECTS {
    source_name: 'FortiGuard Labs',
    target_name: 'XWorm',
    relationship_id: 'REL1',
    original_relation: 'detects',
    created_at: datetime()
}]->(target);

// Rust used_by Buer loader
MATCH (source:Tools {id: 'TOO77'}), (target:Tools {id: 'TOO19'})
MERGE (source)-[:USED_BY {
    source_name: 'Rust',
    target_name: 'Buer loader',
    relationship_id: 'REL2',
    original_relation: 'used_by',
    created_at: datetime()
}]->(target);

// Rust used_by Hive
MATCH (source:Tools {id: 'TOO77'}), (target:Attackers {id: 'ATT33'})
MERGE (source)-[:USED_BY {
    source_name: 'Rust',
    target_name: 'Hive',
    relationship_id: 'REL3',
    original_relation: 'used_by',
    created_at: datetime()
}]->(target);

// Rust used_by RansomExx
MATCH (source:Tools {id: 'TOO77'}), (target:Attackers {id: 'ATT52'})
MERGE (source)-[:USED_BY {
    source_name: 'Rust',
    target_name: 'RansomExx',
    relationship_id: 'REL4',
    original_relation: 'used_by',
    created_at: datetime()
}]->(target);

// LokiBot drops Malware
MATCH (source:Malware {id: 'MAL21'}), (target:Attackers {id: 'ATT41'})
MERGE (source)-[:DROPS {
    source_name: 'LokiBot',
    target_name: 'Malware',
    relationship_id: 'REL5',
    original_relation: 'drops',
    created_at: datetime()
}]->(target);

// Condi spreads_via CVE-2023-1389
MATCH (source:Attackers {id: 'ATT18'}), (target:Vulnerabilities {id: 'VUL4'})
MERGE (source)-[:SPREADS_VIA {
    source_name: 'Condi',
    target_name: 'CVE-2023-1389',
    relationship_id: 'REL6',
    original_relation: 'spreads_via',
    created_at: datetime()
}]->(target);

// Cl0p exploits CVE-2023-34362
MATCH (source:Attackers {id: 'ATT17'}), (target:Vulnerabilities {id: 'VUL21'})
MERGE (source)-[:EXPLOITS {
    source_name: 'Cl0p',
    target_name: 'CVE-2023-34362',
    relationship_id: 'REL7',
    original_relation: 'exploits',
    created_at: datetime()
}]->(target);

// FortiGuard Labs discovers CVE-2023-34362
MATCH (source:Tools {id: 'TOO29'}), (target:Vulnerabilities {id: 'VUL21'})
MERGE (source)-[:DISCOVERS {
    source_name: 'FortiGuard Labs',
    target_name: 'CVE-2023-34362',
    relationship_id: 'REL8',
    original_relation: 'discovers',
    created_at: datetime()
}]->(target);

// CISA releases_advisory_for CVE-2023-34362
MATCH (source:Tools {id: 'TOO23'}), (target:Vulnerabilities {id: 'VUL21'})
MERGE (source)-[:RELEASES_ADVISORY_FOR {
    source_name: 'CISA',
    target_name: 'CVE-2023-34362',
    relationship_id: 'REL9',
    original_relation: 'releases_advisory_for',
    created_at: datetime()
}]->(target);

// FortiGuard Labs reported RapperBot
MATCH (source:Tools {id: 'TOO29'}), (target:Malware {id: 'MAL35'})
MERGE (source)-[:REPORTED {
    source_name: 'FortiGuard Labs',
    target_name: 'RapperBot',
    relationship_id: 'REL10',
    original_relation: 'reported',
    created_at: datetime()
}]->(target);

// AndoryuBot targets Ruckus
MATCH (source:Malware {id: 'MAL3'}), (target:Tools {id: 'TOO74'})
MERGE (source)-[:TARGETS {
    source_name: 'AndoryuBot',
    target_name: 'Ruckus',
    relationship_id: 'REL11',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// EvilExtractor targets Windows
MATCH (source:Attackers {id: 'ATT27'}), (target:Tools {id: 'TOO96'})
MERGE (source)-[:TARGETS {
    source_name: 'EvilExtractor',
    target_name: 'Windows',
    relationship_id: 'REL12',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// Kodex developed EvilExtractor
MATCH (source:Tools {id: 'TOO43'}), (target:Attackers {id: 'ATT27'})
MERGE (source)-[:DEVELOPED {
    source_name: 'Kodex',
    target_name: 'EvilExtractor',
    relationship_id: 'REL13',
    original_relation: 'developed',
    created_at: datetime()
}]->(target);

// FortiGuard Labs observes EvilExtractor
MATCH (source:Tools {id: 'TOO29'}), (target:Attackers {id: 'ATT27'})
MERGE (source)-[:OBSERVES {
    source_name: 'FortiGuard Labs',
    target_name: 'EvilExtractor',
    relationship_id: 'REL14',
    original_relation: 'observes',
    created_at: datetime()
}]->(target);

// Windows Users are impacted by Threat actor
MATCH (source:Tools {id: 'TOO99'}), (target:Attackers {id: 'ATT65'})
MERGE (source)-[:ARE_IMPACTED_BY {
    source_name: 'Windows Users',
    target_name: 'Threat actor',
    relationship_id: 'REL15',
    original_relation: 'are impacted by',
    created_at: datetime()
}]->(target);

// FortiGuard Labs researches Malware
MATCH (source:Tools {id: 'TOO29'}), (target:Attackers {id: 'ATT41'})
MERGE (source)-[:RESEARCHES {
    source_name: 'FortiGuard Labs',
    target_name: 'Malware',
    relationship_id: 'REL16',
    original_relation: 'researches',
    created_at: datetime()
}]->(target);

// FortiGuard Labs detects Moobot
MATCH (source:Tools {id: 'TOO29'}), (target:Attackers {id: 'ATT45'})
MERGE (source)-[:DETECTS {
    source_name: 'FortiGuard Labs',
    target_name: 'Moobot',
    relationship_id: 'REL17',
    original_relation: 'detects',
    created_at: datetime()
}]->(target);

// Russia uses wiper malware
MATCH (source:Tools {id: 'TOO75'}), (target:Malware {id: 'MAL44'})
MERGE (source)-[:USES {
    source_name: 'Russia',
    target_name: 'wiper malware',
    relationship_id: 'REL18',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// 8220 Gang uses ScrubCrypt
MATCH (source:Attackers {id: 'ATT1'}), (target:Tools {id: 'TOO78'})
MERGE (source)-[:USES {
    source_name: '8220 Gang',
    target_name: 'ScrubCrypt',
    relationship_id: 'REL19',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// FortiGuard Labs comes_across MyDoom
MATCH (source:Tools {id: 'TOO29'}), (target:Malware {id: 'MAL28'})
MERGE (source)-[:COMES_ACROSS {
    source_name: 'FortiGuard Labs',
    target_name: 'MyDoom',
    relationship_id: 'REL20',
    original_relation: 'comes_across',
    created_at: datetime()
}]->(target);

// MyDoom uses Windows
MATCH (source:Malware {id: 'MAL28'}), (target:Tools {id: 'TOO96'})
MERGE (source)-[:USES {
    source_name: 'MyDoom',
    target_name: 'Windows',
    relationship_id: 'REL21',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Trexon publishes web3-essential
MATCH (source:Attackers {id: 'ATT67'}), (target:Tools {id: 'TOO95'})
MERGE (source)-[:PUBLISHES {
    source_name: 'Trexon',
    target_name: 'web3-essential',
    relationship_id: 'REL22',
    original_relation: 'publishes',
    created_at: datetime()
}]->(target);

// PyPI hosts colorslib
MATCH (source:Tools {id: 'TOO71'}), (target:Tools {id: 'TOO25'})
MERGE (source)-[:HOSTS {
    source_name: 'PyPI',
    target_name: 'colorslib',
    relationship_id: 'REL23',
    original_relation: 'hosts',
    created_at: datetime()
}]->(target);

// PyPI hosts httpslib
MATCH (source:Tools {id: 'TOO71'}), (target:Tools {id: 'TOO38'})
MERGE (source)-[:HOSTS {
    source_name: 'PyPI',
    target_name: 'httpslib',
    relationship_id: 'REL24',
    original_relation: 'hosts',
    created_at: datetime()
}]->(target);

// PyPI hosts libhttps
MATCH (source:Tools {id: 'TOO71'}), (target:Tools {id: 'TOO45'})
MERGE (source)-[:HOSTS {
    source_name: 'PyPI',
    target_name: 'libhttps',
    relationship_id: 'REL25',
    original_relation: 'hosts',
    created_at: datetime()
}]->(target);

// Lolip0p publishes colorslib
MATCH (source:Attackers {id: 'ATT38'}), (target:Tools {id: 'TOO25'})
MERGE (source)-[:PUBLISHES {
    source_name: 'Lolip0p',
    target_name: 'colorslib',
    relationship_id: 'REL26',
    original_relation: 'publishes',
    created_at: datetime()
}]->(target);

// Lolip0p publishes httpslib
MATCH (source:Attackers {id: 'ATT38'}), (target:Tools {id: 'TOO38'})
MERGE (source)-[:PUBLISHES {
    source_name: 'Lolip0p',
    target_name: 'httpslib',
    relationship_id: 'REL27',
    original_relation: 'publishes',
    created_at: datetime()
}]->(target);

// Lolip0p publishes libhttps
MATCH (source:Attackers {id: 'ATT38'}), (target:Tools {id: 'TOO45'})
MERGE (source)-[:PUBLISHES {
    source_name: 'Lolip0p',
    target_name: 'libhttps',
    relationship_id: 'REL28',
    original_relation: 'publishes',
    created_at: datetime()
}]->(target);

// FortiGuard Labs monitors IoT botnet
MATCH (source:Tools {id: 'TOO29'}), (target:Attackers {id: 'ATT34'})
MERGE (source)-[:MONITORS {
    source_name: 'FortiGuard Labs',
    target_name: 'IoT botnet',
    relationship_id: 'REL29',
    original_relation: 'monitors',
    created_at: datetime()
}]->(target);

// FortiGuard Labs uses honeypots
MATCH (source:Tools {id: 'TOO29'}), (target:Tools {id: 'TOO37'})
MERGE (source)-[:USES {
    source_name: 'FortiGuard Labs',
    target_name: 'honeypots',
    relationship_id: 'REL30',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Windows Users are affected by Malware
MATCH (source:Tools {id: 'TOO99'}), (target:Attackers {id: 'ATT41'})
MERGE (source)-[:ARE_AFFECTED_BY {
    source_name: 'Windows Users',
    target_name: 'Malware',
    relationship_id: 'REL31',
    original_relation: 'are affected by',
    created_at: datetime()
}]->(target);

// Microsoft patches ToolShell
MATCH (source:Tools {id: 'TOO49'}), (target:Tools {id: 'TOO89'})
MERGE (source)-[:PATCHES {
    source_name: 'Microsoft',
    target_name: 'ToolShell',
    relationship_id: 'REL32',
    original_relation: 'patches',
    created_at: datetime()
}]->(target);

// ToolShell exploits CVE-2025-53770
MATCH (source:Tools {id: 'TOO89'}), (target:Vulnerabilities {id: 'VUL24'})
MERGE (source)-[:EXPLOITS {
    source_name: 'ToolShell',
    target_name: 'CVE-2025-53770',
    relationship_id: 'REL33',
    original_relation: 'exploits',
    created_at: datetime()
}]->(target);

// Play associated_with Balloonfly
MATCH (source:Attackers {id: 'ATT48'}), (target:Attackers {id: 'ATT6'})
MERGE (source)-[:ASSOCIATED_WITH {
    source_name: 'Play',
    target_name: 'Balloonfly',
    relationship_id: 'REL34',
    original_relation: 'associated_with',
    created_at: datetime()
}]->(target);

// Balloonfly uses theGrixba
MATCH (source:Attackers {id: 'ATT6'}), (target:Tools {id: 'TOO88'})
MERGE (source)-[:USES {
    source_name: 'Balloonfly',
    target_name: 'theGrixba',
    relationship_id: 'REL35',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Shuckworm targets Ukraine
MATCH (source:Attackers {id: 'ATT56'}), (target:Tools {id: 'TOO92'})
MERGE (source)-[:TARGETS {
    source_name: 'Shuckworm',
    target_name: 'Ukraine',
    relationship_id: 'REL36',
    original_relation: 'targets',
    created_at: datetime()
}]->(target);

// Shuckworm uses GammaSteel
MATCH (source:Attackers {id: 'ATT56'}), (target:Tools {id: 'TOO31'})
MERGE (source)-[:USES {
    source_name: 'Shuckworm',
    target_name: 'GammaSteel',
    relationship_id: 'REL37',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// RansomHub uses Backdoor.Betruger
MATCH (source:Attackers {id: 'ATT53'}), (target:Malware {id: 'MAL5'})
MERGE (source)-[:USES {
    source_name: 'RansomHub',
    target_name: 'Backdoor.Betruger',
    relationship_id: 'REL38',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// RansomHub develops Backdoor.Betruger
MATCH (source:Attackers {id: 'ATT53'}), (target:Malware {id: 'MAL5'})
MERGE (source)-[:DEVELOPS {
    source_name: 'RansomHub',
    target_name: 'Backdoor.Betruger',
    relationship_id: 'REL39',
    original_relation: 'develops',
    created_at: datetime()
}]->(target);

// Backdoor.Betruger uses Mimikatz
MATCH (source:Malware {id: 'MAL5'}), (target:Tools {id: 'TOO54'})
MERGE (source)-[:USES {
    source_name: 'Backdoor.Betruger',
    target_name: 'Mimikatz',
    relationship_id: 'REL40',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Backdoor.Betruger uses Cobalt Strike
MATCH (source:Malware {id: 'MAL5'}), (target:Tools {id: 'TOO24'})
MERGE (source)-[:USES {
    source_name: 'Backdoor.Betruger',
    target_name: 'Cobalt Strike',
    relationship_id: 'REL41',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// Spearwing operates Medusa
MATCH (source:Attackers {id: 'ATT60'}), (target:Malware {id: 'MAL24'})
MERGE (source)-[:OPERATES {
    source_name: 'Spearwing',
    target_name: 'Medusa',
    relationship_id: 'REL42',
    original_relation: 'operates',
    created_at: datetime()
}]->(target);

// RansomHub overtakes LockBit
MATCH (source:Attackers {id: 'ATT53'}), (target:Tools {id: 'TOO47'})
MERGE (source)-[:OVERTAKES {
    source_name: 'RansomHub',
    target_name: 'LockBit',
    relationship_id: 'REL43',
    original_relation: 'overtakes',
    created_at: datetime()
}]->(target);

// Symantec finds evidence of Stonefly
MATCH (source:Tools {id: 'TOO85'}), (target:Attackers {id: 'ATT62'})
MERGE (source)-[:FINDS_EVIDENCE_OF {
    source_name: 'Symantec',
    target_name: 'Stonefly',
    relationship_id: 'REL44',
    original_relation: 'finds evidence of',
    created_at: datetime()
}]->(target);

// Symantec attributes to North Korea
MATCH (source:Tools {id: 'TOO85'}), (target:Tools {id: 'TOO61'})
MERGE (source)-[:ATTRIBUTES_TO {
    source_name: 'Symantec',
    target_name: 'North Korea',
    relationship_id: 'REL45',
    original_relation: 'attributes to',
    created_at: datetime()
}]->(target);

// Stonefly tries to deploy ransomware
MATCH (source:Attackers {id: 'ATT62'}), (target:Malware {id: 'MAL34'})
MERGE (source)-[:TRIES_TO_DEPLOY {
    source_name: 'Stonefly',
    target_name: 'ransomware',
    relationship_id: 'REL46',
    original_relation: 'tries to deploy',
    created_at: datetime()
}]->(target);

// Syrphid operates LockBit
MATCH (source:Attackers {id: 'ATT64'}), (target:Tools {id: 'TOO47'})
MERGE (source)-[:OPERATES {
    source_name: 'Syrphid',
    target_name: 'LockBit',
    relationship_id: 'REL47',
    original_relation: 'operates',
    created_at: datetime()
}]->(target);

// Symantec names GoGra
MATCH (source:Tools {id: 'TOO85'}), (target:Malware {id: 'MAL14'})
MERGE (source)-[:NAMES {
    source_name: 'Symantec',
    target_name: 'GoGra',
    relationship_id: 'REL48',
    original_relation: 'names',
    created_at: datetime()
}]->(target);

// Daggerfly delivers MgBot
MATCH (source:Attackers {id: 'ATT21'}), (target:Malware {id: 'MAL25'})
MERGE (source)-[:DELIVERS {
    source_name: 'Daggerfly',
    target_name: 'MgBot',
    relationship_id: 'REL49',
    original_relation: 'delivers',
    created_at: datetime()
}]->(target);

// Daggerfly updates Macma
MATCH (source:Attackers {id: 'ATT21'}), (target:Malware {id: 'MAL22'})
MERGE (source)-[:UPDATES {
    source_name: 'Daggerfly',
    target_name: 'Macma',
    relationship_id: 'REL50',
    original_relation: 'updates',
    created_at: datetime()
}]->(target);

// Coolclient:A associated with Fireant group
MATCH (source:Malware {id: 'MAL10'}), (target:Attackers {id: 'ATT30'})
MERGE (source)-[:ASSOCIATED_WITH {
    source_name: 'Coolclient:A',
    target_name: 'Fireant group',
    relationship_id: 'REL51',
    original_relation: 'associated with',
    created_at: datetime()
}]->(target);

// Black Basta may_have_been_exploiting CVE-2024-26169
MATCH (source:Attackers {id: 'ATT9'}), (target:Vulnerabilities {id: 'VUL22'})
MERGE (source)-[:MAY_HAVE_BEEN_EXPLOITING {
    source_name: 'Black Basta',
    target_name: 'CVE-2024-26169',
    relationship_id: 'REL52',
    original_relation: 'may_have_been_exploiting',
    created_at: datetime()
}]->(target);

// Cardinal operates Black Basta
MATCH (source:Attackers {id: 'ATT13'}), (target:Attackers {id: 'ATT9'})
MERGE (source)-[:OPERATES {
    source_name: 'Cardinal',
    target_name: 'Black Basta',
    relationship_id: 'REL53',
    original_relation: 'operates',
    created_at: datetime()
}]->(target);

// Storm-1811 is_alias_for Cardinal
MATCH (source:Attackers {id: 'ATT63'}), (target:Attackers {id: 'ATT13'})
MERGE (source)-[:IS_ALIAS_FOR {
    source_name: 'Storm-1811',
    target_name: 'Cardinal',
    relationship_id: 'REL54',
    original_relation: 'is_alias_for',
    created_at: datetime()
}]->(target);

// UNC4393 is_alias_for Cardinal
MATCH (source:Attackers {id: 'ATT69'}), (target:Attackers {id: 'ATT13'})
MERGE (source)-[:IS_ALIAS_FOR {
    source_name: 'UNC4393',
    target_name: 'Cardinal',
    relationship_id: 'REL55',
    original_relation: 'is_alias_for',
    created_at: datetime()
}]->(target);

// Symantec uncovered Linux.Gomir
MATCH (source:Tools {id: 'TOO85'}), (target:Malware {id: 'MAL19'})
MERGE (source)-[:UNCOVERED {
    source_name: 'Symantec',
    target_name: 'Linux.Gomir',
    relationship_id: 'REL56',
    original_relation: 'uncovered',
    created_at: datetime()
}]->(target);

// Springtail developed Linux.Gomir
MATCH (source:Attackers {id: 'ATT61'}), (target:Malware {id: 'MAL19'})
MERGE (source)-[:DEVELOPED {
    source_name: 'Springtail',
    target_name: 'Linux.Gomir',
    relationship_id: 'REL57',
    original_relation: 'developed',
    created_at: datetime()
}]->(target);

// Springtail used Malware
MATCH (source:Attackers {id: 'ATT61'}), (target:Attackers {id: 'ATT41'})
MERGE (source)-[:USED {
    source_name: 'Springtail',
    target_name: 'Malware',
    relationship_id: 'REL58',
    original_relation: 'used',
    created_at: datetime()
}]->(target);

// BirdyClient communicates_with OneDrive
MATCH (source:Malware {id: 'MAL7'}), (target:Tools {id: 'TOO62'})
MERGE (source)-[:COMMUNICATES_WITH {
    source_name: 'BirdyClient',
    target_name: 'OneDrive',
    relationship_id: 'REL59',
    original_relation: 'communicates_with',
    created_at: datetime()
}]->(target);

// ========================================
// VERIFICATION QUERIES
// ========================================

// Count all relationships
MATCH ()-[r]->() RETURN count(r) AS total_relationships;

// Count by relationship type
MATCH ()-[r]->()
RETURN type(r) AS relationship_type, count(r) AS count
ORDER BY count DESC;

// Show unique relationship types created
// ARE_AFFECTED_BY
// ARE_IMPACTED_BY
// ASSOCIATED_WITH
// ATTRIBUTES_TO
// COMES_ACROSS
// COMMUNICATES_WITH
// DELIVERS
// DETECTS
// DEVELOPED
// DEVELOPS
// DISCOVERS
// DROPS
// EXPLOITS
// FINDS_EVIDENCE_OF
// HOSTS
// IS_ALIAS_FOR
// MAY_HAVE_BEEN_EXPLOITING
// MONITORS
// NAMES
// OBSERVES
// OPERATES
// OVERTAKES
// PATCHES
// PUBLISHES
// RELEASES_ADVISORY_FOR
// REPORTED
// RESEARCHES
// SPREADS_VIA
// TARGETS
// TRIES_TO_DEPLOY
// UNCOVERED
// UPDATES
// USED
// USED_BY
// USES

// Sample relationships
MATCH (source)-[r]->(target)
RETURN type(r) AS relationship_type,
       labels(source)[0] AS source_type, source.name AS source_name,
       labels(target)[0] AS target_type, target.name AS target_name
ORDER BY relationship_type
LIMIT 20;

// Attacker-specific relationships
MATCH (a:Attackers)-[r]->(target)
RETURN a.name AS attacker, type(r) AS relationship,
       labels(target)[0] AS target_type, target.name AS target
ORDER BY attacker, relationship;