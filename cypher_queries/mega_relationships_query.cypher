// MEGA RELATIONSHIP QUERY
// Total relationships: 62

// FortiGuard Labs (TOO34)
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
  {source: source, target: target_MAL46, relation: 'detects'}  ,
  {source: source, target: target_VUL21, relation: 'discovers'}  ,
  {source: source, target: target_MAL35, relation: 'reported'}  ,
  {source: source, target: target_ATT27, relation: 'observes'}  ,
  {source: source, target: target_TOO46, relation: 'researches'}  ,
  {source: source, target: target_ATT41, relation: 'researches'}  ,
  {source: source, target: target_ATT45, relation: 'detects'}  ,
  {source: source, target: target_MAL28, relation: 'comes_across'}  ,
  {source: source, target: target_ATT34, relation: 'monitors'}  ,
  {source: source, target: target_TOO42, relation: 'uses'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// Rust (TOO90)
MATCH (source:Too {id: 'TOO90'})
OPTIONAL MATCH (target_TOO21:Too {id: 'TOO21'})
OPTIONAL MATCH (target_ATT33:Att {id: 'ATT33'})
OPTIONAL MATCH (target_ATT52:Att {id: 'ATT52'})
FOREACH (rel IN [
  {source: source, target: target_TOO21, relation: 'used_by'}  ,
  {source: source, target: target_ATT33, relation: 'used_by'}  ,
  {source: source, target: target_ATT52, relation: 'used_by'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// MOVEit Transfer (TOO68)
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

// CISA (TOO25)
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

// Kodex (TOO51)
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

// Windows Users (TOO118)
MATCH (source:Too {id: 'TOO118'})
OPTIONAL MATCH (target_ATT65:Att {id: 'ATT65'})
OPTIONAL MATCH (target_ATT41:Att {id: 'ATT41'})
FOREACH (rel IN [
  {source: source, target: target_ATT65, relation: 'are impacted by'}  ,
  {source: source, target: target_ATT41, relation: 'are affected by'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// Russia (TOO88)
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

// PyPI (TOO83)
MATCH (source:Too {id: 'TOO83'})
OPTIONAL MATCH (target_TOO27:Too {id: 'TOO27'})
OPTIONAL MATCH (target_TOO43:Too {id: 'TOO43'})
OPTIONAL MATCH (target_TOO55:Too {id: 'TOO55'})
FOREACH (rel IN [
  {source: source, target: target_TOO27, relation: 'hosts'}  ,
  {source: source, target: target_TOO43, relation: 'hosts'}  ,
  {source: source, target: target_TOO55, relation: 'hosts'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// Microsoft (TOO60)
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

// ToolShell (TOO107)
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

// Symantec (TOO101)
MATCH (source:Too {id: 'TOO101'})
OPTIONAL MATCH (target_ATT62:Att {id: 'ATT62'})
OPTIONAL MATCH (target_TOO73:Too {id: 'TOO73'})
OPTIONAL MATCH (target_MAL14:Mal {id: 'MAL14'})
OPTIONAL MATCH (target_MAL19:Mal {id: 'MAL19'})
FOREACH (rel IN [
  {source: source, target: target_ATT62, relation: 'finds evidence of'}  ,
  {source: source, target: target_TOO73, relation: 'attributes to'}  ,
  {source: source, target: target_MAL14, relation: 'names'}  ,
  {source: source, target: target_MAL19, relation: 'uncovered'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// LokiBot (MAL21)
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

// AndoryuBot (MAL3)
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

// MyDoom (MAL28)
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

// Backdoor.Betruger (MAL5)
MATCH (source:Mal {id: 'MAL5'})
OPTIONAL MATCH (target_TOO66:Too {id: 'TOO66'})
OPTIONAL MATCH (target_TOO26:Too {id: 'TOO26'})
FOREACH (rel IN [
  {source: source, target: target_TOO66, relation: 'uses'}  ,
  {source: source, target: target_TOO26, relation: 'uses'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// Coolclient:A (MAL10)
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

// BirdyClient (MAL7)
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

// Condi (ATT18)
MATCH (source:Att {id: 'ATT18'})
OPTIONAL MATCH (target_VUL4:Vul {id: 'VUL4'})
FOREACH (rel IN [
  {source: source, target: target_VUL4, relation: 'spreads_via'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// Cl0p (ATT17)
MATCH (source:Att {id: 'ATT17'})
OPTIONAL MATCH (target_VUL21:Vul {id: 'VUL21'})
FOREACH (rel IN [
  {source: source, target: target_VUL21, relation: 'exploits'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// EvilExtractor (ATT27)
MATCH (source:Att {id: 'ATT27'})
OPTIONAL MATCH (target_TOO115:Too {id: 'TOO115'})
FOREACH (rel IN [
  {source: source, target: target_TOO115, relation: 'targets'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// 8220 Gang (ATT1)
MATCH (source:Att {id: 'ATT1'})
OPTIONAL MATCH (target_TOO91:Too {id: 'TOO91'})
FOREACH (rel IN [
  {source: source, target: target_TOO91, relation: 'uses'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// Trexon (ATT67)
MATCH (source:Att {id: 'ATT67'})
OPTIONAL MATCH (target_TOO114:Too {id: 'TOO114'})
FOREACH (rel IN [
  {source: source, target: target_TOO114, relation: 'publishes'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// Lolip0p (ATT38)
MATCH (source:Att {id: 'ATT38'})
OPTIONAL MATCH (target_TOO27:Too {id: 'TOO27'})
OPTIONAL MATCH (target_TOO43:Too {id: 'TOO43'})
OPTIONAL MATCH (target_TOO55:Too {id: 'TOO55'})
FOREACH (rel IN [
  {source: source, target: target_TOO27, relation: 'publishes'}  ,
  {source: source, target: target_TOO43, relation: 'publishes'}  ,
  {source: source, target: target_TOO55, relation: 'publishes'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// Play (ATT48)
MATCH (source:Att {id: 'ATT48'})
OPTIONAL MATCH (target_ATT6:Att {id: 'ATT6'})
FOREACH (rel IN [
  {source: source, target: target_ATT6, relation: 'associated_with'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// Balloonfly (ATT6)
MATCH (source:Att {id: 'ATT6'})
OPTIONAL MATCH (target_TOO105:Too {id: 'TOO105'})
FOREACH (rel IN [
  {source: source, target: target_TOO105, relation: 'uses'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// Shuckworm (ATT56)
MATCH (source:Att {id: 'ATT56'})
OPTIONAL MATCH (target_TOO110:Too {id: 'TOO110'})
OPTIONAL MATCH (target_TOO36:Too {id: 'TOO36'})
FOREACH (rel IN [
  {source: source, target: target_TOO110, relation: 'targets'}  ,
  {source: source, target: target_TOO36, relation: 'uses'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// RansomHub (ATT53)
MATCH (source:Att {id: 'ATT53'})
OPTIONAL MATCH (target_MAL5:Mal {id: 'MAL5'})
OPTIONAL MATCH (target_MAL5:Mal {id: 'MAL5'})
OPTIONAL MATCH (target_TOO57:Too {id: 'TOO57'})
FOREACH (rel IN [
  {source: source, target: target_MAL5, relation: 'uses'}  ,
  {source: source, target: target_MAL5, relation: 'develops'}  ,
  {source: source, target: target_TOO57, relation: 'overtakes'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// Spearwing (ATT60)
MATCH (source:Att {id: 'ATT60'})
OPTIONAL MATCH (target_MAL24:Mal {id: 'MAL24'})
FOREACH (rel IN [
  {source: source, target: target_MAL24, relation: 'operates'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// Stonefly (ATT62)
MATCH (source:Att {id: 'ATT62'})
OPTIONAL MATCH (target_MAL34:Mal {id: 'MAL34'})
FOREACH (rel IN [
  {source: source, target: target_MAL34, relation: 'tries to deploy'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// Syrphid (ATT64)
MATCH (source:Att {id: 'ATT64'})
OPTIONAL MATCH (target_TOO57:Too {id: 'TOO57'})
FOREACH (rel IN [
  {source: source, target: target_TOO57, relation: 'operates'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// Daggerfly (ATT21)
MATCH (source:Att {id: 'ATT21'})
OPTIONAL MATCH (target_MAL25:Mal {id: 'MAL25'})
OPTIONAL MATCH (target_MAL22:Mal {id: 'MAL22'})
FOREACH (rel IN [
  {source: source, target: target_MAL25, relation: 'delivers'}  ,
  {source: source, target: target_MAL22, relation: 'updates'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// Black Basta (ATT9)
MATCH (source:Att {id: 'ATT9'})
OPTIONAL MATCH (target_VUL22:Vul {id: 'VUL22'})
FOREACH (rel IN [
  {source: source, target: target_VUL22, relation: 'may_have_been_exploiting'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// Cardinal (ATT13)
MATCH (source:Att {id: 'ATT13'})
OPTIONAL MATCH (target_ATT9:Att {id: 'ATT9'})
FOREACH (rel IN [
  {source: source, target: target_ATT9, relation: 'operates'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// Storm-1811 (ATT63)
MATCH (source:Att {id: 'ATT63'})
OPTIONAL MATCH (target_ATT13:Att {id: 'ATT13'})
FOREACH (rel IN [
  {source: source, target: target_ATT13, relation: 'is_alias_for'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// UNC4393 (ATT69)
MATCH (source:Att {id: 'ATT69'})
OPTIONAL MATCH (target_ATT13:Att {id: 'ATT13'})
FOREACH (rel IN [
  {source: source, target: target_ATT13, relation: 'is_alias_for'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// Springtail (ATT61)
MATCH (source:Att {id: 'ATT61'})
OPTIONAL MATCH (target_MAL19:Mal {id: 'MAL19'})
OPTIONAL MATCH (target_ATT41:Att {id: 'ATT41'})
FOREACH (rel IN [
  {source: source, target: target_MAL19, relation: 'developed'}  ,
  {source: source, target: target_ATT41, relation: 'used'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

// Malware (ATT41)
MATCH (source:Att {id: 'ATT41'})
OPTIONAL MATCH (target_TOO61:Too {id: 'TOO61'})
FOREACH (rel IN [
  {source: source, target: target_TOO61, relation: 'uses'}
] |
  CASE WHEN rel.target IS NOT NULL
    THEN CREATE (rel.source)-[:RELATES_TO {type: rel.relation}]->(rel.target)
    ELSE NULL
  END
);

