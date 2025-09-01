// ========================================
// DELETE ATTACKER RELATIONSHIPS
// ========================================
// These queries help you delete attacker relationships that were created

// ========================================
// 1. CHECK CURRENT RELATIONSHIPS
// ========================================

// Count current attacker relationships
MATCH (a:Attackers)-[r:RELATES_TO]-()
RETURN count(r) AS total_attacker_relationships;

// Show all attacker relationships (preview before deletion)
MATCH (a:Attackers)-[r:RELATES_TO]-(target)
RETURN a.name AS attacker, r.type AS relationship, 
       labels(target)[0] AS target_type, target.name AS target,
       r.relationship_id AS rel_id
ORDER BY attacker
LIMIT 20;

// ========================================
// 2. DELETE SPECIFIC RELATIONSHIPS BY ID
// ========================================

// Delete by specific relationship IDs (from our data)
MATCH ()-[r:RELATES_TO]->()
WHERE r.relationship_id IN [
    'REL6', 'REL7', 'REL12', 'REL19', 'REL22', 'REL26', 'REL27', 'REL28',
    'REL34', 'REL35', 'REL36', 'REL37', 'REL38', 'REL39', 'REL42', 'REL43',
    'REL46', 'REL47', 'REL49', 'REL50', 'REL52', 'REL53', 'REL54', 'REL55',
    'REL57', 'REL58'
]
DELETE r
RETURN count(r) AS deleted_relationships;

// ========================================
// 3. DELETE ALL ATTACKER RELATIONSHIPS
// ========================================

// Delete ALL relationships involving attackers (BE CAREFUL!)
MATCH (a:Attackers)-[r:RELATES_TO]-()
DELETE r
RETURN count(r) AS deleted_attacker_relationships;

// ========================================
// 4. DELETE SPECIFIC RELATIONSHIP TYPES
// ========================================

// Delete only 'uses' relationships
MATCH (a:Attackers)-[r:RELATES_TO]-()
WHERE r.type = 'uses'
DELETE r
RETURN count(r) AS deleted_uses_relationships;

// Delete only 'publishes' relationships
MATCH (a:Attackers)-[r:RELATES_TO]-()
WHERE r.type = 'publishes'
DELETE r
RETURN count(r) AS deleted_publishes_relationships;

// Delete only 'exploits' relationships
MATCH (a:Attackers)-[r:RELATES_TO]-()
WHERE r.type = 'exploits'
DELETE r
RETURN count(r) AS deleted_exploits_relationships;

// Delete only 'operates' relationships
MATCH (a:Attackers)-[r:RELATES_TO]-()
WHERE r.type = 'operates'
DELETE r
RETURN count(r) AS deleted_operates_relationships;

// Delete alias relationships
MATCH (a:Attackers)-[r:RELATES_TO]-()
WHERE r.type IN ['is_alias_for', 'associated_with']
DELETE r
RETURN count(r) AS deleted_alias_relationships;

// ========================================
// 5. DELETE RELATIONSHIPS BY ATTACKER
// ========================================

// Delete relationships for specific attackers
MATCH (a:Attackers)-[r:RELATES_TO]-()
WHERE a.id IN ['ATT17', 'ATT18', 'ATT27', 'ATT1', 'ATT67']
DELETE r
RETURN count(r) AS deleted_relationships_for_specific_attackers;

// Delete relationships for attacker by name
MATCH (a:Attackers {name: 'Cl0p'})-[r:RELATES_TO]-()
DELETE r
RETURN count(r) AS deleted_clop_relationships;

// ========================================
// 6. BATCH DELETE WITH CONFIRMATION
// ========================================

// Safe delete with preview - Step 1: Preview what will be deleted
MATCH (a:Attackers)-[r:RELATES_TO]-(target)
WHERE r.created_at >= datetime('2024-01-01')  // Only recent relationships
RETURN a.name AS attacker, r.type AS relationship, 
       target.name AS target, r.relationship_id AS rel_id
ORDER BY attacker;

// Safe delete with confirmation - Step 2: Actually delete (run after review)
MATCH (a:Attackers)-[r:RELATES_TO]-()
WHERE r.created_at >= datetime('2024-01-01')  // Only recent relationships
DELETE r
RETURN count(r) AS deleted_recent_relationships;

// ========================================
// 7. DELETE ALL RELATES_TO RELATIONSHIPS (NUCLEAR OPTION)
// ========================================

// WARNING: This deletes ALL RELATES_TO relationships in the database
// MATCH ()-[r:RELATES_TO]-()
// DELETE r
// RETURN count(r) AS total_deleted_relationships;

// ========================================
// 8. VERIFICATION AFTER DELETION
// ========================================

// Check if any attacker relationships remain
MATCH (a:Attackers)
OPTIONAL MATCH (a)-[r:RELATES_TO]-()
RETURN a.name AS attacker, count(r) AS remaining_relationships
ORDER BY remaining_relationships DESC;

// Count all remaining relationships in database
MATCH ()-[r:RELATES_TO]-()
RETURN count(r) AS total_remaining_relationships;

// Check for orphaned relationship IDs (relationships that should have been deleted)
MATCH ()-[r:RELATES_TO]-()
WHERE r.relationship_id STARTS WITH 'REL'
RETURN r.relationship_id AS remaining_rel_id, 
       r.type AS relationship_type,
       r.source_name AS source,
       r.target_name AS target;

// ========================================
// 9. CLEAN UP SPECIFIC ISSUES
// ========================================

// Delete duplicate relationships (same source, target, type)
MATCH (source)-[r:RELATES_TO]->(target)
WITH source, target, r.type AS rel_type, collect(r) AS rels
WHERE size(rels) > 1
UNWIND tail(rels) AS duplicate_rel
DELETE duplicate_rel
RETURN count(duplicate_rel) AS duplicates_removed;

// Delete relationships with empty or null properties
MATCH ()-[r:RELATES_TO]-()
WHERE r.type IS NULL OR r.type = '' OR 
      r.source_name IS NULL OR r.source_name = '' OR
      r.target_name IS NULL OR r.target_name = ''
DELETE r
RETURN count(r) AS invalid_relationships_deleted;
