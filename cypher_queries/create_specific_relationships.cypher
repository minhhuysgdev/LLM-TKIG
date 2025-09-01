// ========================================
// CREATE SPECIFIC RELATIONSHIP TYPES
// ========================================
// This creates relationships with specific names instead of generic RELATES_TO

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

// ========================================
// 2. SPECIFIC ATTACKER RELATIONSHIPS WITH EXACT NAMES
// ========================================

// ATT18,Condi,spreads_via,VUL4,CVE-2023-1389
MATCH (a:Attackers {id: 'ATT18'}), (v:Vulnerabilities {id: 'VUL4'})
MERGE (a)-[:SPREADS_VIA {
    source_name: 'Condi',
    target_name: 'CVE-2023-1389',
    relationship_id: 'REL6'
}]->(v);

// ATT17,Cl0p,exploits,VUL21,CVE-2023-34362
MATCH (a:Attackers {id: 'ATT17'}), (v:Vulnerabilities {id: 'VUL21'})
MERGE (a)-[:EXPLOITS {
    source_name: 'Cl0p',
    target_name: 'CVE-2023-34362',
    relationship_id: 'REL7'
}]->(v);

// ATT27,EvilExtractor,targets,TOO96,Windows
MATCH (a:Attackers {id: 'ATT27'}), (t:Tools {id: 'TOO96'})
MERGE (a)-[:TARGETS {
    source_name: 'EvilExtractor',
    target_name: 'Windows',
    relationship_id: 'REL12'
}]->(t);

// ATT1,8220 Gang,uses,TOO78,ScrubCrypt
MATCH (a:Attackers {id: 'ATT1'}), (t:Tools {id: 'TOO78'})
MERGE (a)-[:USES {
    source_name: '8220 Gang',
    target_name: 'ScrubCrypt',
    relationship_id: 'REL19'
}]->(t);

// ATT67,Trexon,publishes,TOO95,web3-essential
MATCH (a:Attackers {id: 'ATT67'}), (t:Tools {id: 'TOO95'})
MERGE (a)-[:PUBLISHES {
    source_name: 'Trexon',
    target_name: 'web3-essential',
    relationship_id: 'REL22'
}]->(t);

// ATT38,Lolip0p,publishes,TOO25,colorslib
MATCH (a:Attackers {id: 'ATT38'}), (t:Tools {id: 'TOO25'})
MERGE (a)-[:PUBLISHES {
    source_name: 'Lolip0p',
    target_name: 'colorslib',
    relationship_id: 'REL26'
}]->(t);

// ATT38,Lolip0p,publishes,TOO38,httpslib
MATCH (a:Attackers {id: 'ATT38'}), (t:Tools {id: 'TOO38'})
MERGE (a)-[:PUBLISHES {
    source_name: 'Lolip0p',
    target_name: 'httpslib',
    relationship_id: 'REL27'
}]->(t);

// ATT38,Lolip0p,publishes,TOO45,libhttps
MATCH (a:Attackers {id: 'ATT38'}), (t:Tools {id: 'TOO45'})
MERGE (a)-[:PUBLISHES {
    source_name: 'Lolip0p',
    target_name: 'libhttps',
    relationship_id: 'REL28'
}]->(t);

// ATT48,Play,associated_with,ATT6,Balloonfly
MATCH (a1:Attackers {id: 'ATT48'}), (a2:Attackers {id: 'ATT6'})
MERGE (a1)-[:ASSOCIATED_WITH {
    source_name: 'Play',
    target_name: 'Balloonfly',
    relationship_id: 'REL34'
}]->(a2);

// ATT6,Balloonfly,uses,TOO88,theGrixba
MATCH (a:Attackers {id: 'ATT6'}), (t:Tools {id: 'TOO88'})
MERGE (a)-[:USES {
    source_name: 'Balloonfly',
    target_name: 'theGrixba',
    relationship_id: 'REL35'
}]->(t);

// ATT56,Shuckworm,targets,TOO92,Ukraine
MATCH (a:Attackers {id: 'ATT56'}), (t:Tools {id: 'TOO92'})
MERGE (a)-[:TARGETS {
    source_name: 'Shuckworm',
    target_name: 'Ukraine',
    relationship_id: 'REL36'
}]->(t);

// ATT56,Shuckworm,uses,TOO31,GammaSteel
MATCH (a:Attackers {id: 'ATT56'}), (t:Tools {id: 'TOO31'})
MERGE (a)-[:USES {
    source_name: 'Shuckworm',
    target_name: 'GammaSteel',
    relationship_id: 'REL37'
}]->(t);

// ATT53,RansomHub,uses,MAL5,Backdoor.Betruger
MATCH (a:Attackers {id: 'ATT53'}), (m:Malware {id: 'MAL5'})
MERGE (a)-[:USES {
    source_name: 'RansomHub',
    target_name: 'Backdoor.Betruger',
    relationship_id: 'REL38'
}]->(m);

// ATT53,RansomHub,develops,MAL5,Backdoor.Betruger
MATCH (a:Attackers {id: 'ATT53'}), (m:Malware {id: 'MAL5'})
MERGE (a)-[:DEVELOPS {
    source_name: 'RansomHub',
    target_name: 'Backdoor.Betruger',
    relationship_id: 'REL39'
}]->(m);

// ATT60,Spearwing,operates,MAL24,Medusa
MATCH (a:Attackers {id: 'ATT60'}), (m:Malware {id: 'MAL24'})
MERGE (a)-[:OPERATES {
    source_name: 'Spearwing',
    target_name: 'Medusa',
    relationship_id: 'REL42'
}]->(m);

// ATT53,RansomHub,overtakes,TOO47,LockBit
MATCH (a:Attackers {id: 'ATT53'}), (t:Tools {id: 'TOO47'})
MERGE (a)-[:OVERTAKES {
    source_name: 'RansomHub',
    target_name: 'LockBit',
    relationship_id: 'REL43'
}]->(t);

// ATT62,Stonefly,tries_to_deploy,MAL34,ransomware
MATCH (a:Attackers {id: 'ATT62'}), (m:Malware {id: 'MAL34'})
MERGE (a)-[:TRIES_TO_DEPLOY {
    source_name: 'Stonefly',
    target_name: 'ransomware',
    relationship_id: 'REL46'
}]->(m);

// ATT64,Syrphid,operates,TOO47,LockBit
MATCH (a:Attackers {id: 'ATT64'}), (t:Tools {id: 'TOO47'})
MERGE (a)-[:OPERATES {
    source_name: 'Syrphid',
    target_name: 'LockBit',
    relationship_id: 'REL47'
}]->(t);

// ATT21,Daggerfly,delivers,MAL25,MgBot
MATCH (a:Attackers {id: 'ATT21'}), (m:Malware {id: 'MAL25'})
MERGE (a)-[:DELIVERS {
    source_name: 'Daggerfly',
    target_name: 'MgBot',
    relationship_id: 'REL49'
}]->(m);

// ATT21,Daggerfly,updates,MAL22,Macma
MATCH (a:Attackers {id: 'ATT21'}), (m:Malware {id: 'MAL22'})
MERGE (a)-[:UPDATES {
    source_name: 'Daggerfly',
    target_name: 'Macma',
    relationship_id: 'REL50'
}]->(m);

// ATT9,Black Basta,may_have_been_exploiting,VUL22,CVE-2024-26169
MATCH (a:Attackers {id: 'ATT9'}), (v:Vulnerabilities {id: 'VUL22'})
MERGE (a)-[:MAY_HAVE_BEEN_EXPLOITING {
    source_name: 'Black Basta',
    target_name: 'CVE-2024-26169',
    relationship_id: 'REL52'
}]->(v);

// ATT13,Cardinal,operates,ATT9,Black Basta
MATCH (a1:Attackers {id: 'ATT13'}), (a2:Attackers {id: 'ATT9'})
MERGE (a1)-[:OPERATES {
    source_name: 'Cardinal',
    target_name: 'Black Basta',
    relationship_id: 'REL53'
}]->(a2);

// ATT63,Storm-1811,is_alias_for,ATT13,Cardinal
MATCH (a1:Attackers {id: 'ATT63'}), (a2:Attackers {id: 'ATT13'})
MERGE (a1)-[:IS_ALIAS_FOR {
    source_name: 'Storm-1811',
    target_name: 'Cardinal',
    relationship_id: 'REL54'
}]->(a2);

// ATT69,UNC4393,is_alias_for,ATT13,Cardinal
MATCH (a1:Attackers {id: 'ATT69'}), (a2:Attackers {id: 'ATT13'})
MERGE (a1)-[:IS_ALIAS_FOR {
    source_name: 'UNC4393',
    target_name: 'Cardinal',
    relationship_id: 'REL55'
}]->(a2);

// ATT61,Springtail,developed,MAL19,Linux.Gomir
MATCH (a:Attackers {id: 'ATT61'}), (m:Malware {id: 'MAL19'})
MERGE (a)-[:DEVELOPED {
    source_name: 'Springtail',
    target_name: 'Linux.Gomir',
    relationship_id: 'REL57'
}]->(m);

// ATT61,Springtail,used,ATT41,Malware
MATCH (a1:Attackers {id: 'ATT61'}), (a2:Attackers {id: 'ATT41'})
MERGE (a1)-[:USED {
    source_name: 'Springtail',
    target_name: 'Malware',
    relationship_id: 'REL58'
}]->(a2);

// ========================================
// 3. CREATE ALSO OTHER RELATIONSHIPS FROM CSV
// ========================================

// TOO77,Rust,used_by,TOO19,Buer loader
MATCH (t1:Tools {id: 'TOO77'}), (t2:Tools {id: 'TOO19'})
MERGE (t1)-[:USED_BY {
    source_name: 'Rust',
    target_name: 'Buer loader',
    relationship_id: 'REL2'
}]->(t2);

// TOO77,Rust,used_by,ATT33,Hive
MATCH (t:Tools {id: 'TOO77'}), (a:Attackers {id: 'ATT33'})
MERGE (t)-[:USED_BY {
    source_name: 'Rust',
    target_name: 'Hive',
    relationship_id: 'REL3'
}]->(a);

// TOO77,Rust,used_by,ATT52,RansomExx
MATCH (t:Tools {id: 'TOO77'}), (a:Attackers {id: 'ATT52'})
MERGE (t)-[:USED_BY {
    source_name: 'Rust',
    target_name: 'RansomExx',
    relationship_id: 'REL4'
}]->(a);

// TOO29,FortiGuard Labs,detects,MAL46,XWorm
MATCH (t:Tools {id: 'TOO29'}), (m:Malware {id: 'MAL46'})
MERGE (t)-[:DETECTS {
    source_name: 'FortiGuard Labs',
    target_name: 'XWorm',
    relationship_id: 'REL1'
}]->(m);

// ========================================
// 4. VERIFICATION QUERIES
// ========================================

// Count relationships by type
CALL db.relationshipTypes() YIELD relationshipType
CALL apoc.cypher.run('MATCH ()-[r:' + relationshipType + ']->() RETURN count(r) as count', {})
YIELD value
RETURN relationshipType, value.count AS count
ORDER BY count DESC;

// Show sample of each relationship type
MATCH ()-[r]->()
WITH type(r) AS rel_type, collect(r)[0] AS sample_rel
RETURN rel_type, 
       sample_rel.source_name AS source_example,
       sample_rel.target_name AS target_example
ORDER BY rel_type;

// Count attacker relationships by type
MATCH (a:Attackers)-[r]->()
RETURN type(r) AS relationship_type, count(r) AS count
ORDER BY count DESC;

// Show attacker network
MATCH (a:Attackers)-[r]->(target)
RETURN a.name AS attacker, type(r) AS relationship, 
       labels(target)[0] AS target_type, target.name AS target
ORDER BY attacker, relationship;
