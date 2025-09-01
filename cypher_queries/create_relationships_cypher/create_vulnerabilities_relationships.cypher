// ========================================
// CREATE VULNERABILITIES RELATIONSHIPS
// Auto-generated from relationships_norm.csv
// ========================================

// Total Vulnerabilities relationships: 1

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
// 2. VULNERABILITIES RELATIONSHIPS
// ========================================

// CVE-2021-40444 part of Microsoft Office
MATCH (source:Vulnerabilities {id: 'VUL12'}), (target:Tools {id: 'TOO167'})
MERGE (source)-[:PART_OF {
    source_name: 'CVE-2021-40444',
    target_name: 'Microsoft Office',
    relationship_id: 'REL278',
    original_relation: 'part of',
    created_at: datetime()
}]->(target);

// ========================================
// 3. VERIFICATION QUERIES
// ========================================

// Count Vulnerabilities outgoing relationships
MATCH (s:Vulnerabilities)-[r]->()
RETURN type(r) AS relationship_type, count(r) AS count
ORDER BY count DESC;

// Show sample Vulnerabilities relationships
MATCH (s:Vulnerabilities)-[r]->(target)
RETURN s.name AS source, type(r) AS relationship,
       labels(target)[0] AS target_type, target.name AS target
ORDER BY source, relationship
LIMIT 20;

// Summary: Relationship types for Vulnerabilities
// PART_OF: 1