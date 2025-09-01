
// ========================================
// SAFE DELETION SCRIPT - RUN STEP BY STEP
// ========================================

// STEP 1: Count current relationships
MATCH (a:Attackers)-[r:RELATES_TO]-()
RETURN count(r) AS current_attacker_relationships;

// STEP 2: Preview specific relationships to delete
MATCH ()-[r:RELATES_TO]->()
WHERE r.relationship_id IN [
    'REL6', 'REL7', 'REL12', 'REL19', 'REL22', 'REL26', 'REL27', 'REL28',
    'REL34', 'REL35', 'REL36', 'REL37', 'REL38', 'REL39', 'REL42', 'REL43',
    'REL46', 'REL47', 'REL49', 'REL50', 'REL52', 'REL53', 'REL54', 'REL55',
    'REL57', 'REL58'
]
RETURN r.relationship_id AS rel_id, 
       r.type AS relationship_type,
       r.source_name AS source,
       r.target_name AS target
ORDER BY rel_id;

// STEP 3: If preview looks correct, run this to delete
MATCH ()-[r:RELATES_TO]->()
WHERE r.relationship_id IN [
    'REL6', 'REL7', 'REL12', 'REL19', 'REL22', 'REL26', 'REL27', 'REL28',
    'REL34', 'REL35', 'REL36', 'REL37', 'REL38', 'REL39', 'REL42', 'REL43',
    'REL46', 'REL47', 'REL49', 'REL50', 'REL52', 'REL53', 'REL54', 'REL55',
    'REL57', 'REL58'
]
DELETE r
RETURN count(r) AS deleted_relationships;

// STEP 4: Verify deletion
MATCH (a:Attackers)
OPTIONAL MATCH (a)-[r:RELATES_TO]-()
RETURN count(DISTINCT a) AS total_attackers,
       count(r) AS remaining_attacker_relationships;

// STEP 5: Check for any remaining orphaned relationships
MATCH ()-[r:RELATES_TO]-()
WHERE r.relationship_id STARTS WITH 'REL'
RETURN count(r) AS remaining_rel_relationships;
