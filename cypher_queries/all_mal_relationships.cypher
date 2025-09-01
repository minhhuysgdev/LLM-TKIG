// MAL Relationships
// Total: 7 relationships

// LokiBot (MAL21) relationships
MATCH (source:Mal {id: 'MAL21'})
OPTIONAL MATCH (target_ATT41:Att {id: 'ATT41'})
FOREACH (rel IN [
  {source: source, target: target_ATT41, relation: 'drops'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// AndoryuBot (MAL3) relationships
MATCH (source:Mal {id: 'MAL3'})
OPTIONAL MATCH (target_TOO87:Too {id: 'TOO87'})
FOREACH (rel IN [
  {source: source, target: target_TOO87, relation: 'targets'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// MyDoom (MAL28) relationships
MATCH (source:Mal {id: 'MAL28'})
OPTIONAL MATCH (target_TOO115:Too {id: 'TOO115'})
FOREACH (rel IN [
  {source: source, target: target_TOO115, relation: 'uses'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// Backdoor.Betruger (MAL5) relationships
MATCH (source:Mal {id: 'MAL5'})
OPTIONAL MATCH (target_TOO66:Too {id: 'TOO66'})
OPTIONAL MATCH (target_TOO26:Too {id: 'TOO26'})
FOREACH (rel IN [
  {source: source, target: target_TOO66, relation: 'uses'}
  ,
  {source: source, target: target_TOO26, relation: 'uses'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// Coolclient:A (MAL10) relationships
MATCH (source:Mal {id: 'MAL10'})
OPTIONAL MATCH (target_ATT30:Att {id: 'ATT30'})
FOREACH (rel IN [
  {source: source, target: target_ATT30, relation: 'associated with'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// BirdyClient (MAL7) relationships
MATCH (source:Mal {id: 'MAL7'})
OPTIONAL MATCH (target_TOO74:Too {id: 'TOO74'})
FOREACH (rel IN [
  {source: source, target: target_TOO74, relation: 'communicates_with'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);
