// TOO Relationships
// Total: 28 relationships

// FortiGuard Labs (TOO34) relationships
MATCH (source:Too {id: 'TOO34'})
OPTIONAL MATCH (target_MAL46:Mal {id: 'MAL46'})
OPTIONAL MATCH (target_VUL21:Vul {id: 'VUL21'})
OPTIONAL MATCH (target_MAL35:Mal {id: 'MAL35'})
OPTIONAL MATCH (target_ATT27:Att {id: 'ATT27'})
OPTIONAL MATCH (target_TOO46:Too {id: 'TOO46'})
OPTIONAL MATCH (target_ATT41:Att {id: 'ATT41'})
OPTIONAL MATCH (target_ATT45:Att {id: 'ATT45'})
OPTIONAL MATCH (target_MAL28:Mal {id: 'MAL28'})
OPTIONAL MATCH (target_ATT34:Att {id: 'ATT34'})
OPTIONAL MATCH (target_TOO42:Too {id: 'TOO42'})
FOREACH (rel IN [
  {source: source, target: target_MAL46, relation: 'detects'}
  ,
  {source: source, target: target_VUL21, relation: 'discovers'}
  ,
  {source: source, target: target_MAL35, relation: 'reported'}
  ,
  {source: source, target: target_ATT27, relation: 'observes'}
  ,
  {source: source, target: target_TOO46, relation: 'researches'}
  ,
  {source: source, target: target_ATT41, relation: 'researches'}
  ,
  {source: source, target: target_ATT45, relation: 'detects'}
  ,
  {source: source, target: target_MAL28, relation: 'comes_across'}
  ,
  {source: source, target: target_ATT34, relation: 'monitors'}
  ,
  {source: source, target: target_TOO42, relation: 'uses'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// Rust (TOO90) relationships
MATCH (source:Too {id: 'TOO90'})
OPTIONAL MATCH (target_TOO21:Too {id: 'TOO21'})
OPTIONAL MATCH (target_ATT33:Att {id: 'ATT33'})
OPTIONAL MATCH (target_ATT52:Att {id: 'ATT52'})
FOREACH (rel IN [
  {source: source, target: target_TOO21, relation: 'used_by'}
  ,
  {source: source, target: target_ATT33, relation: 'used_by'}
  ,
  {source: source, target: target_ATT52, relation: 'used_by'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// MOVEit Transfer (TOO68) relationships
MATCH (source:Too {id: 'TOO68'})
OPTIONAL MATCH (target_TOO99:Too {id: 'TOO99'})
FOREACH (rel IN [
  {source: source, target: target_TOO99, relation: 'is_vulnerable_to'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// CISA (TOO25) relationships
MATCH (source:Too {id: 'TOO25'})
OPTIONAL MATCH (target_VUL21:Vul {id: 'VUL21'})
FOREACH (rel IN [
  {source: source, target: target_VUL21, relation: 'releases_advisory_for'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// Kodex (TOO51) relationships
MATCH (source:Too {id: 'TOO51'})
OPTIONAL MATCH (target_ATT27:Att {id: 'ATT27'})
FOREACH (rel IN [
  {source: source, target: target_ATT27, relation: 'developed'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// Windows Users (TOO118) relationships
MATCH (source:Too {id: 'TOO118'})
OPTIONAL MATCH (target_ATT65:Att {id: 'ATT65'})
OPTIONAL MATCH (target_ATT41:Att {id: 'ATT41'})
FOREACH (rel IN [
  {source: source, target: target_ATT65, relation: 'are impacted by'}
  ,
  {source: source, target: target_ATT41, relation: 'are affected by'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// Russia (TOO88) relationships
MATCH (source:Too {id: 'TOO88'})
OPTIONAL MATCH (target_MAL44:Mal {id: 'MAL44'})
FOREACH (rel IN [
  {source: source, target: target_MAL44, relation: 'uses'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// PyPI (TOO83) relationships
MATCH (source:Too {id: 'TOO83'})
OPTIONAL MATCH (target_TOO27:Too {id: 'TOO27'})
OPTIONAL MATCH (target_TOO43:Too {id: 'TOO43'})
OPTIONAL MATCH (target_TOO55:Too {id: 'TOO55'})
FOREACH (rel IN [
  {source: source, target: target_TOO27, relation: 'hosts'}
  ,
  {source: source, target: target_TOO43, relation: 'hosts'}
  ,
  {source: source, target: target_TOO55, relation: 'hosts'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// Microsoft (TOO60) relationships
MATCH (source:Too {id: 'TOO60'})
OPTIONAL MATCH (target_TOO107:Too {id: 'TOO107'})
FOREACH (rel IN [
  {source: source, target: target_TOO107, relation: 'patches'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// ToolShell (TOO107) relationships
MATCH (source:Too {id: 'TOO107'})
OPTIONAL MATCH (target_VUL24:Vul {id: 'VUL24'})
FOREACH (rel IN [
  {source: source, target: target_VUL24, relation: 'exploits'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// Symantec (TOO101) relationships
MATCH (source:Too {id: 'TOO101'})
OPTIONAL MATCH (target_ATT62:Att {id: 'ATT62'})
OPTIONAL MATCH (target_TOO73:Too {id: 'TOO73'})
OPTIONAL MATCH (target_MAL14:Mal {id: 'MAL14'})
OPTIONAL MATCH (target_MAL19:Mal {id: 'MAL19'})
FOREACH (rel IN [
  {source: source, target: target_ATT62, relation: 'finds evidence of'}
  ,
  {source: source, target: target_TOO73, relation: 'attributes to'}
  ,
  {source: source, target: target_MAL14, relation: 'names'}
  ,
  {source: source, target: target_MAL19, relation: 'uncovered'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);
