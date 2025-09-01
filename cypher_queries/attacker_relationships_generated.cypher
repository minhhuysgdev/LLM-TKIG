// ========================================
// ATTACKER RELATIONSHIPS - AUTO GENERATED
// ========================================
// Generated from relationships_norm.csv

// Create constraints first
CREATE CONSTRAINT IF NOT EXISTS FOR (a:Attackers) REQUIRE a.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (m:Malware) REQUIRE m.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (t:Tools) REQUIRE t.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (v:Vulnerabilities) REQUIRE v.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (f:Files) REQUIRE f.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (u:Urls) REQUIRE u.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (tech:Techniques) REQUIRE tech.id IS UNIQUE;

// Individual attacker relationships
// Rust used_by Hive
MATCH (source:Tools {id: 'TOO77'}), (target:Attackers {id: 'ATT33'})
MERGE (source)-[:RELATES_TO {
    type: 'used_by',
    source_name: 'Rust',
    target_name: 'Hive',
    relationship_id: 'REL3',
    created_at: datetime()
}]->(target);

// Rust used_by RansomExx
MATCH (source:Tools {id: 'TOO77'}), (target:Attackers {id: 'ATT52'})
MERGE (source)-[:RELATES_TO {
    type: 'used_by',
    source_name: 'Rust',
    target_name: 'RansomExx',
    relationship_id: 'REL4',
    created_at: datetime()
}]->(target);

// LokiBot drops Malware
MATCH (source:Malware {id: 'MAL21'}), (target:Attackers {id: 'ATT41'})
MERGE (source)-[:RELATES_TO {
    type: 'drops',
    source_name: 'LokiBot',
    target_name: 'Malware',
    relationship_id: 'REL5',
    created_at: datetime()
}]->(target);

// Condi spreads_via CVE-2023-1389
MATCH (source:Attackers {id: 'ATT18'}), (target:Vulnerabilities {id: 'VUL4'})
MERGE (source)-[:RELATES_TO {
    type: 'spreads_via',
    source_name: 'Condi',
    target_name: 'CVE-2023-1389',
    relationship_id: 'REL6',
    created_at: datetime()
}]->(target);

// Cl0p exploits CVE-2023-34362
MATCH (source:Attackers {id: 'ATT17'}), (target:Vulnerabilities {id: 'VUL21'})
MERGE (source)-[:RELATES_TO {
    type: 'exploits',
    source_name: 'Cl0p',
    target_name: 'CVE-2023-34362',
    relationship_id: 'REL7',
    created_at: datetime()
}]->(target);

// EvilExtractor targets Windows
MATCH (source:Attackers {id: 'ATT27'}), (target:Tools {id: 'TOO96'})
MERGE (source)-[:RELATES_TO {
    type: 'targets',
    source_name: 'EvilExtractor',
    target_name: 'Windows',
    relationship_id: 'REL12',
    created_at: datetime()
}]->(target);

// Kodex developed EvilExtractor
MATCH (source:Tools {id: 'TOO43'}), (target:Attackers {id: 'ATT27'})
MERGE (source)-[:RELATES_TO {
    type: 'developed',
    source_name: 'Kodex',
    target_name: 'EvilExtractor',
    relationship_id: 'REL13',
    created_at: datetime()
}]->(target);

// FortiGuard Labs observes EvilExtractor
MATCH (source:Tools {id: 'TOO29'}), (target:Attackers {id: 'ATT27'})
MERGE (source)-[:RELATES_TO {
    type: 'observes',
    source_name: 'FortiGuard Labs',
    target_name: 'EvilExtractor',
    relationship_id: 'REL14',
    created_at: datetime()
}]->(target);

// Windows Users are impacted by Threat actor
MATCH (source:Tools {id: 'TOO99'}), (target:Attackers {id: 'ATT65'})
MERGE (source)-[:RELATES_TO {
    type: 'are impacted by',
    source_name: 'Windows Users',
    target_name: 'Threat actor',
    relationship_id: 'REL15',
    created_at: datetime()
}]->(target);

// FortiGuard Labs researches Malware
MATCH (source:Tools {id: 'TOO29'}), (target:Attackers {id: 'ATT41'})
MERGE (source)-[:RELATES_TO {
    type: 'researches',
    source_name: 'FortiGuard Labs',
    target_name: 'Malware',
    relationship_id: 'REL16',
    created_at: datetime()
}]->(target);

// FortiGuard Labs detects Moobot
MATCH (source:Tools {id: 'TOO29'}), (target:Attackers {id: 'ATT45'})
MERGE (source)-[:RELATES_TO {
    type: 'detects',
    source_name: 'FortiGuard Labs',
    target_name: 'Moobot',
    relationship_id: 'REL17',
    created_at: datetime()
}]->(target);

// 8220 Gang uses ScrubCrypt
MATCH (source:Attackers {id: 'ATT1'}), (target:Tools {id: 'TOO78'})
MERGE (source)-[:RELATES_TO {
    type: 'uses',
    source_name: '8220 Gang',
    target_name: 'ScrubCrypt',
    relationship_id: 'REL19',
    created_at: datetime()
}]->(target);

// Trexon publishes web3-essential
MATCH (source:Attackers {id: 'ATT67'}), (target:Tools {id: 'TOO95'})
MERGE (source)-[:RELATES_TO {
    type: 'publishes',
    source_name: 'Trexon',
    target_name: 'web3-essential',
    relationship_id: 'REL22',
    created_at: datetime()
}]->(target);

// Lolip0p publishes colorslib
MATCH (source:Attackers {id: 'ATT38'}), (target:Tools {id: 'TOO25'})
MERGE (source)-[:RELATES_TO {
    type: 'publishes',
    source_name: 'Lolip0p',
    target_name: 'colorslib',
    relationship_id: 'REL26',
    created_at: datetime()
}]->(target);

// Lolip0p publishes httpslib
MATCH (source:Attackers {id: 'ATT38'}), (target:Tools {id: 'TOO38'})
MERGE (source)-[:RELATES_TO {
    type: 'publishes',
    source_name: 'Lolip0p',
    target_name: 'httpslib',
    relationship_id: 'REL27',
    created_at: datetime()
}]->(target);

// Lolip0p publishes libhttps
MATCH (source:Attackers {id: 'ATT38'}), (target:Tools {id: 'TOO45'})
MERGE (source)-[:RELATES_TO {
    type: 'publishes',
    source_name: 'Lolip0p',
    target_name: 'libhttps',
    relationship_id: 'REL28',
    created_at: datetime()
}]->(target);

// FortiGuard Labs monitors IoT botnet
MATCH (source:Tools {id: 'TOO29'}), (target:Attackers {id: 'ATT34'})
MERGE (source)-[:RELATES_TO {
    type: 'monitors',
    source_name: 'FortiGuard Labs',
    target_name: 'IoT botnet',
    relationship_id: 'REL29',
    created_at: datetime()
}]->(target);

// Windows Users are affected by Malware
MATCH (source:Tools {id: 'TOO99'}), (target:Attackers {id: 'ATT41'})
MERGE (source)-[:RELATES_TO {
    type: 'are affected by',
    source_name: 'Windows Users',
    target_name: 'Malware',
    relationship_id: 'REL31',
    created_at: datetime()
}]->(target);

// Play associated_with Balloonfly
MATCH (source:Attackers {id: 'ATT48'}), (target:Attackers {id: 'ATT6'})
MERGE (source)-[:RELATES_TO {
    type: 'associated_with',
    source_name: 'Play',
    target_name: 'Balloonfly',
    relationship_id: 'REL34',
    created_at: datetime()
}]->(target);

// Balloonfly uses theGrixba
MATCH (source:Attackers {id: 'ATT6'}), (target:Tools {id: 'TOO88'})
MERGE (source)-[:RELATES_TO {
    type: 'uses',
    source_name: 'Balloonfly',
    target_name: 'theGrixba',
    relationship_id: 'REL35',
    created_at: datetime()
}]->(target);

// Shuckworm targets Ukraine
MATCH (source:Attackers {id: 'ATT56'}), (target:Tools {id: 'TOO92'})
MERGE (source)-[:RELATES_TO {
    type: 'targets',
    source_name: 'Shuckworm',
    target_name: 'Ukraine',
    relationship_id: 'REL36',
    created_at: datetime()
}]->(target);

// Shuckworm uses GammaSteel
MATCH (source:Attackers {id: 'ATT56'}), (target:Tools {id: 'TOO31'})
MERGE (source)-[:RELATES_TO {
    type: 'uses',
    source_name: 'Shuckworm',
    target_name: 'GammaSteel',
    relationship_id: 'REL37',
    created_at: datetime()
}]->(target);

// RansomHub uses Backdoor.Betruger
MATCH (source:Attackers {id: 'ATT53'}), (target:Malware {id: 'MAL5'})
MERGE (source)-[:RELATES_TO {
    type: 'uses',
    source_name: 'RansomHub',
    target_name: 'Backdoor.Betruger',
    relationship_id: 'REL38',
    created_at: datetime()
}]->(target);

// RansomHub develops Backdoor.Betruger
MATCH (source:Attackers {id: 'ATT53'}), (target:Malware {id: 'MAL5'})
MERGE (source)-[:RELATES_TO {
    type: 'develops',
    source_name: 'RansomHub',
    target_name: 'Backdoor.Betruger',
    relationship_id: 'REL39',
    created_at: datetime()
}]->(target);

// Spearwing operates Medusa
MATCH (source:Attackers {id: 'ATT60'}), (target:Malware {id: 'MAL24'})
MERGE (source)-[:RELATES_TO {
    type: 'operates',
    source_name: 'Spearwing',
    target_name: 'Medusa',
    relationship_id: 'REL42',
    created_at: datetime()
}]->(target);

// RansomHub overtakes LockBit
MATCH (source:Attackers {id: 'ATT53'}), (target:Tools {id: 'TOO47'})
MERGE (source)-[:RELATES_TO {
    type: 'overtakes',
    source_name: 'RansomHub',
    target_name: 'LockBit',
    relationship_id: 'REL43',
    created_at: datetime()
}]->(target);

// Symantec finds evidence of Stonefly
MATCH (source:Tools {id: 'TOO85'}), (target:Attackers {id: 'ATT62'})
MERGE (source)-[:RELATES_TO {
    type: 'finds evidence of',
    source_name: 'Symantec',
    target_name: 'Stonefly',
    relationship_id: 'REL44',
    created_at: datetime()
}]->(target);

// Stonefly tries to deploy ransomware
MATCH (source:Attackers {id: 'ATT62'}), (target:Malware {id: 'MAL34'})
MERGE (source)-[:RELATES_TO {
    type: 'tries to deploy',
    source_name: 'Stonefly',
    target_name: 'ransomware',
    relationship_id: 'REL46',
    created_at: datetime()
}]->(target);

// Syrphid operates LockBit
MATCH (source:Attackers {id: 'ATT64'}), (target:Tools {id: 'TOO47'})
MERGE (source)-[:RELATES_TO {
    type: 'operates',
    source_name: 'Syrphid',
    target_name: 'LockBit',
    relationship_id: 'REL47',
    created_at: datetime()
}]->(target);

// Daggerfly delivers MgBot
MATCH (source:Attackers {id: 'ATT21'}), (target:Malware {id: 'MAL25'})
MERGE (source)-[:RELATES_TO {
    type: 'delivers',
    source_name: 'Daggerfly',
    target_name: 'MgBot',
    relationship_id: 'REL49',
    created_at: datetime()
}]->(target);

// Daggerfly updates Macma
MATCH (source:Attackers {id: 'ATT21'}), (target:Malware {id: 'MAL22'})
MERGE (source)-[:RELATES_TO {
    type: 'updates',
    source_name: 'Daggerfly',
    target_name: 'Macma',
    relationship_id: 'REL50',
    created_at: datetime()
}]->(target);

// Coolclient:A associated with Fireant group
MATCH (source:Malware {id: 'MAL10'}), (target:Attackers {id: 'ATT30'})
MERGE (source)-[:RELATES_TO {
    type: 'associated with',
    source_name: 'Coolclient:A',
    target_name: 'Fireant group',
    relationship_id: 'REL51',
    created_at: datetime()
}]->(target);

// Black Basta may_have_been_exploiting CVE-2024-26169
MATCH (source:Attackers {id: 'ATT9'}), (target:Vulnerabilities {id: 'VUL22'})
MERGE (source)-[:RELATES_TO {
    type: 'may_have_been_exploiting',
    source_name: 'Black Basta',
    target_name: 'CVE-2024-26169',
    relationship_id: 'REL52',
    created_at: datetime()
}]->(target);

// Cardinal operates Black Basta
MATCH (source:Attackers {id: 'ATT13'}), (target:Attackers {id: 'ATT9'})
MERGE (source)-[:RELATES_TO {
    type: 'operates',
    source_name: 'Cardinal',
    target_name: 'Black Basta',
    relationship_id: 'REL53',
    created_at: datetime()
}]->(target);

// Storm-1811 is_alias_for Cardinal
MATCH (source:Attackers {id: 'ATT63'}), (target:Attackers {id: 'ATT13'})
MERGE (source)-[:RELATES_TO {
    type: 'is_alias_for',
    source_name: 'Storm-1811',
    target_name: 'Cardinal',
    relationship_id: 'REL54',
    created_at: datetime()
}]->(target);

// UNC4393 is_alias_for Cardinal
MATCH (source:Attackers {id: 'ATT69'}), (target:Attackers {id: 'ATT13'})
MERGE (source)-[:RELATES_TO {
    type: 'is_alias_for',
    source_name: 'UNC4393',
    target_name: 'Cardinal',
    relationship_id: 'REL55',
    created_at: datetime()
}]->(target);

// Springtail developed Linux.Gomir
MATCH (source:Attackers {id: 'ATT61'}), (target:Malware {id: 'MAL19'})
MERGE (source)-[:RELATES_TO {
    type: 'developed',
    source_name: 'Springtail',
    target_name: 'Linux.Gomir',
    relationship_id: 'REL57',
    created_at: datetime()
}]->(target);

// Springtail used Malware
MATCH (source:Attackers {id: 'ATT61'}), (target:Attackers {id: 'ATT41'})
MERGE (source)-[:RELATES_TO {
    type: 'used',
    source_name: 'Springtail',
    target_name: 'Malware',
    relationship_id: 'REL58',
    created_at: datetime()
}]->(target);

// ========================================
// BATCH CREATION USING PARAMETERS
// ========================================

// Use this query with parameters in Neo4j Browser or application
// Parameters (copy this to Neo4j Browser):
{
  "relationships": [{"source_id": "TOO77", "target_id": "ATT33", "relation": "used_by", "source_name": "Rust", "target_name": "Hive", "id": "REL3"}, {"source_id": "TOO77", "target_id": "ATT52", "relation": "used_by", "source_name": "Rust", "target_name": "RansomExx", "id": "REL4"}, {"source_id": "MAL21", "target_id": "ATT41", "relation": "drops", "source_name": "LokiBot", "target_name": "Malware", "id": "REL5"}, {"source_id": "ATT18", "target_id": "VUL4", "relation": "spreads_via", "source_name": "Condi", "target_name": "CVE-2023-1389", "id": "REL6"}, {"source_id": "ATT17", "target_id": "VUL21", "relation": "exploits", "source_name": "Cl0p", "target_name": "CVE-2023-34362", "id": "REL7"}, {"source_id": "ATT27", "target_id": "TOO96", "relation": "targets", "source_name": "EvilExtractor", "target_name": "Windows", "id": "REL12"}, {"source_id": "TOO43", "target_id": "ATT27", "relation": "developed", "source_name": "Kodex", "target_name": "EvilExtractor", "id": "REL13"}, {"source_id": "TOO29", "target_id": "ATT27", "relation": "observes", "source_name": "FortiGuard Labs", "target_name": "EvilExtractor", "id": "REL14"}, {"source_id": "TOO99", "target_id": "ATT65", "relation": "are impacted by", "source_name": "Windows Users", "target_name": "Threat actor", "id": "REL15"}, {"source_id": "TOO29", "target_id": "ATT41", "relation": "researches", "source_name": "FortiGuard Labs", "target_name": "Malware", "id": "REL16"}, {"source_id": "TOO29", "target_id": "ATT45", "relation": "detects", "source_name": "FortiGuard Labs", "target_name": "Moobot", "id": "REL17"}, {"source_id": "ATT1", "target_id": "TOO78", "relation": "uses", "source_name": "8220 Gang", "target_name": "ScrubCrypt", "id": "REL19"}, {"source_id": "ATT67", "target_id": "TOO95", "relation": "publishes", "source_name": "Trexon", "target_name": "web3-essential", "id": "REL22"}, {"source_id": "ATT38", "target_id": "TOO25", "relation": "publishes", "source_name": "Lolip0p", "target_name": "colorslib", "id": "REL26"}, {"source_id": "ATT38", "target_id": "TOO38", "relation": "publishes", "source_name": "Lolip0p", "target_name": "httpslib", "id": "REL27"}, {"source_id": "ATT38", "target_id": "TOO45", "relation": "publishes", "source_name": "Lolip0p", "target_name": "libhttps", "id": "REL28"}, {"source_id": "TOO29", "target_id": "ATT34", "relation": "monitors", "source_name": "FortiGuard Labs", "target_name": "IoT botnet", "id": "REL29"}, {"source_id": "TOO99", "target_id": "ATT41", "relation": "are affected by", "source_name": "Windows Users", "target_name": "Malware", "id": "REL31"}, {"source_id": "ATT48", "target_id": "ATT6", "relation": "associated_with", "source_name": "Play", "target_name": "Balloonfly", "id": "REL34"}, {"source_id": "ATT6", "target_id": "TOO88", "relation": "uses", "source_name": "Balloonfly", "target_name": "theGrixba", "id": "REL35"}, {"source_id": "ATT56", "target_id": "TOO92", "relation": "targets", "source_name": "Shuckworm", "target_name": "Ukraine", "id": "REL36"}, {"source_id": "ATT56", "target_id": "TOO31", "relation": "uses", "source_name": "Shuckworm", "target_name": "GammaSteel", "id": "REL37"}, {"source_id": "ATT53", "target_id": "MAL5", "relation": "uses", "source_name": "RansomHub", "target_name": "Backdoor.Betruger", "id": "REL38"}, {"source_id": "ATT53", "target_id": "MAL5", "relation": "develops", "source_name": "RansomHub", "target_name": "Backdoor.Betruger", "id": "REL39"}, {"source_id": "ATT60", "target_id": "MAL24", "relation": "operates", "source_name": "Spearwing", "target_name": "Medusa", "id": "REL42"}, {"source_id": "ATT53", "target_id": "TOO47", "relation": "overtakes", "source_name": "RansomHub", "target_name": "LockBit", "id": "REL43"}, {"source_id": "TOO85", "target_id": "ATT62", "relation": "finds evidence of", "source_name": "Symantec", "target_name": "Stonefly", "id": "REL44"}, {"source_id": "ATT62", "target_id": "MAL34", "relation": "tries to deploy", "source_name": "Stonefly", "target_name": "ransomware", "id": "REL46"}, {"source_id": "ATT64", "target_id": "TOO47", "relation": "operates", "source_name": "Syrphid", "target_name": "LockBit", "id": "REL47"}, {"source_id": "ATT21", "target_id": "MAL25", "relation": "delivers", "source_name": "Daggerfly", "target_name": "MgBot", "id": "REL49"}, {"source_id": "ATT21", "target_id": "MAL22", "relation": "updates", "source_name": "Daggerfly", "target_name": "Macma", "id": "REL50"}, {"source_id": "MAL10", "target_id": "ATT30", "relation": "associated with", "source_name": "Coolclient:A", "target_name": "Fireant group", "id": "REL51"}, {"source_id": "ATT9", "target_id": "VUL22", "relation": "may_have_been_exploiting", "source_name": "Black Basta", "target_name": "CVE-2024-26169", "id": "REL52"}, {"source_id": "ATT13", "target_id": "ATT9", "relation": "operates", "source_name": "Cardinal", "target_name": "Black Basta", "id": "REL53"}, {"source_id": "ATT63", "target_id": "ATT13", "relation": "is_alias_for", "source_name": "Storm-1811", "target_name": "Cardinal", "id": "REL54"}, {"source_id": "ATT69", "target_id": "ATT13", "relation": "is_alias_for", "source_name": "UNC4393", "target_name": "Cardinal", "id": "REL55"}, {"source_id": "ATT61", "target_id": "MAL19", "relation": "developed", "source_name": "Springtail", "target_name": "Linux.Gomir", "id": "REL57"}, {"source_id": "ATT61", "target_id": "ATT41", "relation": "used", "source_name": "Springtail", "target_name": "Malware", "id": "REL58"}]
}

// Query:
UNWIND $relationships AS rel
MATCH (source) WHERE source.id = rel.source_id
MATCH (target) WHERE target.id = rel.target_id
MERGE (source)-[:RELATES_TO {
    type: rel.relation,
    source_name: rel.source_name,
    target_name: rel.target_name,
    relationship_id: rel.id,
    created_at: datetime()
}]->(target)
RETURN count(*) AS relationships_created;

// ========================================
// ANALYSIS QUERIES
// ========================================

// Count attacker relationships
MATCH (a:Attackers)-[r:RELATES_TO]-()
RETURN count(r) AS total_attacker_relationships;

// Most connected attackers
MATCH (a:Attackers)
OPTIONAL MATCH (a)-[r:RELATES_TO]-()
WITH a, count(r) AS connections
WHERE connections > 0
RETURN a.name AS attacker, connections
ORDER BY connections DESC;

// Relationship types involving attackers
MATCH (a:Attackers)-[r:RELATES_TO]-()
RETURN r.type AS relationship_type, count(r) AS frequency
ORDER BY frequency DESC;

// Attackers and their targets
MATCH (a:Attackers)-[r:RELATES_TO]->(target)
RETURN a.name AS attacker, r.type AS relationship,
       labels(target)[0] AS target_type, target.name AS target
ORDER BY attacker, relationship;