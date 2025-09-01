// ========================================
// CREATE FILES RELATIONSHIPS
// Auto-generated from relationships_norm.csv
// ========================================

// Total Files relationships: 52

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
// 2. FILES RELATIONSHIPS
// ========================================

// hxxps://secfileshare[.]com download Укрспецзв_Акт_30_05_25_ДР25_2313_13 від 26_02_2025.rar
MATCH (source:Files {id: 'FIL91'}), (target:Files {id: 'FIL154'})
MERGE (source)-[:DOWNLOAD {
    source_name: 'hxxps://secfileshare[.]com',
    target_name: 'Укрспецзв_Акт_30_05_25_ДР25_2313_13 від 26_02_2025.rar',
    relationship_id: 'REL27',
    original_relation: 'download',
    created_at: datetime()
}]->(target);

// conhost.exe execute conhost.dll
MATCH (source:Files {id: 'FIL55'}), (target:Files {id: 'FIL54'})
MERGE (source)-[:EXECUTE {
    source_name: 'conhost.exe',
    target_name: 'conhost.dll',
    relationship_id: 'REL36',
    original_relation: 'execute',
    created_at: datetime()
}]->(target);

// faktura_1065170.lnk execute C:\WiNDOws\SYsTEM32\MShTA.exe
MATCH (source:Files {id: 'FIL78'}), (target:Files {id: 'FIL60'})
MERGE (source)-[:EXECUTE {
    source_name: 'faktura_1065170.lnk',
    target_name: 'C:\WiNDOws\SYsTEM32\MShTA.exe',
    relationship_id: 'REL44',
    original_relation: 'execute',
    created_at: datetime()
}]->(target);

// malicious Word document exploit CVE-2017-11882
MATCH (source:Files {id: 'FIL105'}), (target:Vulnerabilities {id: 'VUL7'})
MERGE (source)-[:EXPLOIT {
    source_name: 'malicious Word document',
    target_name: 'CVE-2017-11882',
    relationship_id: 'REL107',
    original_relation: 'exploit',
    created_at: datetime()
}]->(target);

// malicious Word document download FormBook
MATCH (source:Files {id: 'FIL105'}), (target:Malware {id: 'MAL37'})
MERGE (source)-[:DOWNLOAD {
    source_name: 'malicious Word document',
    target_name: 'FormBook',
    relationship_id: 'REL108',
    original_relation: 'download',
    created_at: datetime()
}]->(target);

// Documents.html uses PowerShell
MATCH (source:Files {id: 'FIL64'}), (target:Tools {id: 'TOO201'})
MERGE (source)-[:USES {
    source_name: 'Documents.html',
    target_name: 'PowerShell',
    relationship_id: 'REL119',
    original_relation: 'uses',
    created_at: datetime()
}]->(target);

// libsshd.so contains haha
MATCH (source:Files {id: 'FIL99'}), (target:Tools {id: 'TOO121'})
MERGE (source)-[:CONTAINS {
    source_name: 'libsshd.so',
    target_name: 'haha',
    relationship_id: 'REL149',
    original_relation: 'contains',
    created_at: datetime()
}]->(target);

// libsshd.so contains heihei
MATCH (source:Files {id: 'FIL99'}), (target:Tools {id: 'TOO123'})
MERGE (source)-[:CONTAINS {
    source_name: 'libsshd.so',
    target_name: 'heihei',
    relationship_id: 'REL150',
    original_relation: 'contains',
    created_at: datetime()
}]->(target);

// libsshd.so contains xixi
MATCH (source:Files {id: 'FIL99'}), (target:Tools {id: 'TOO283'})
MERGE (source)-[:CONTAINS {
    source_name: 'libsshd.so',
    target_name: 'xixi',
    relationship_id: 'REL151',
    original_relation: 'contains',
    created_at: datetime()
}]->(target);

// LNK file contains Machine ID
MATCH (source:Files {id: 'FIL100'}), (target:Files {id: 'FIL101'})
MERGE (source)-[:CONTAINS {
    source_name: 'LNK file',
    target_name: 'Machine ID',
    relationship_id: 'REL157',
    original_relation: 'contains',
    created_at: datetime()
}]->(target);

// install.sh executes sysinitd.ko
MATCH (source:Files {id: 'FIL94'}), (target:Files {id: 'FIL132'})
MERGE (source)-[:EXECUTES {
    source_name: 'install.sh',
    target_name: 'sysinitd.ko',
    relationship_id: 'REL165',
    original_relation: 'executes',
    created_at: datetime()
}]->(target);

// you.dll part of Winos4.0
MATCH (source:Files {id: 'FIL150'}), (target:Tools {id: 'TOO278'})
MERGE (source)-[:PART_OF {
    source_name: 'you.dll',
    target_name: 'Winos4.0',
    relationship_id: 'REL206',
    original_relation: 'part of',
    created_at: datetime()
}]->(target);

// you.dll contains 校园政务
MATCH (source:Files {id: 'FIL150'}), (target:Files {id: 'FIL155'})
MERGE (source)-[:CONTAINS {
    source_name: 'you.dll',
    target_name: '校园政务',
    relationship_id: 'REL207',
    original_relation: 'contains',
    created_at: datetime()
}]->(target);

// Purchase-Order.7z contains Purchase-Order.exe
MATCH (source:Files {id: 'FIL122'}), (target:Files {id: 'FIL123'})
MERGE (source)-[:CONTAINS {
    source_name: 'Purchase-Order.7z',
    target_name: 'Purchase-Order.exe',
    relationship_id: 'REL219',
    original_relation: 'contains',
    created_at: datetime()
}]->(target);

// swift copy.xls contains Snake Keylogger
MATCH (source:Files {id: 'FIL130'}), (target:Malware {id: 'MAL105'})
MERGE (source)-[:CONTAINS {
    source_name: 'swift copy.xls',
    target_name: 'Snake Keylogger',
    relationship_id: 'REL234',
    original_relation: 'contains',
    created_at: datetime()
}]->(target);

// Discord_token_grabber.py steal Discord tokens
MATCH (source:Files {id: 'FIL61'}), (target:Tools {id: 'TOO81'})
MERGE (source)-[:STEAL {
    source_name: 'Discord_token_grabber.py',
    target_name: 'Discord tokens',
    relationship_id: 'REL261',
    original_relation: 'steal',
    created_at: datetime()
}]->(target);

// get_cookies.py steal browser cookies
MATCH (source:Files {id: 'FIL89'}), (target:Tools {id: 'TOO34'})
MERGE (source)-[:STEAL {
    source_name: 'get_cookies.py',
    target_name: 'browser cookies',
    relationship_id: 'REL262',
    original_relation: 'steal',
    created_at: datetime()
}]->(target);

// password_grabber.py steal stored passwords
MATCH (source:Files {id: 'FIL114'}), (target:Tools {id: 'TOO236'})
MERGE (source)-[:STEAL {
    source_name: 'password_grabber.py',
    target_name: 'stored passwords',
    relationship_id: 'REL263',
    original_relation: 'steal',
    created_at: datetime()
}]->(target);

// Microsoft Word exploit CVE-2021-40444
MATCH (source:Files {id: 'FIL106'}), (target:Vulnerabilities {id: 'VUL12'})
MERGE (source)-[:EXPLOIT {
    source_name: 'Microsoft Word',
    target_name: 'CVE-2021-40444',
    relationship_id: 'REL273',
    original_relation: 'exploit',
    created_at: datetime()
}]->(target);

// Microsoft Word exploit CVE-2021-40444
MATCH (source:Files {id: 'FIL106'}), (target:Vulnerabilities {id: 'VUL12'})
MERGE (source)-[:EXPLOIT {
    source_name: 'Microsoft Word',
    target_name: 'CVE-2021-40444',
    relationship_id: 'REL277',
    original_relation: 'exploit',
    created_at: datetime()
}]->(target);

// u.ps1 same as bypass.ps1
MATCH (source:Files {id: 'FIL142'}), (target:Files {id: 'FIL48'})
MERGE (source)-[:SAME_AS {
    source_name: 'u.ps1',
    target_name: 'bypass.ps1',
    relationship_id: 'REL292',
    original_relation: 'same as',
    created_at: datetime()
}]->(target);

// malicious Excel document contains VBA macro
MATCH (source:Files {id: 'FIL103'}), (target:Tools {id: 'TOO265'})
MERGE (source)-[:CONTAINS {
    source_name: 'malicious Excel document',
    target_name: 'VBA macro',
    relationship_id: 'REL308',
    original_relation: 'contains',
    created_at: datetime()
}]->(target);

// XLS file deploy PicassoLoader
MATCH (source:Files {id: 'FIL148'}), (target:Malware {id: 'MAL78'})
MERGE (source)-[:DEPLOY {
    source_name: 'XLS file',
    target_name: 'PicassoLoader',
    relationship_id: 'REL312',
    original_relation: 'deploy',
    created_at: datetime()
}]->(target);

// XLS file deploy Cobalt Strike Beacon
MATCH (source:Files {id: 'FIL148'}), (target:Malware {id: 'MAL20'})
MERGE (source)-[:DEPLOY {
    source_name: 'XLS file',
    target_name: 'Cobalt Strike Beacon',
    relationship_id: 'REL313',
    original_relation: 'deploy',
    created_at: datetime()
}]->(target);

// require.exe execute chrome.exe
MATCH (source:Files {id: 'FIL125'}), (target:Files {id: 'FIL52'})
MERGE (source)-[:EXECUTE {
    source_name: 'require.exe',
    target_name: 'chrome.exe',
    relationship_id: 'REL351',
    original_relation: 'execute',
    created_at: datetime()
}]->(target);

// PDF download ZIP
MATCH (source:Files {id: 'FIL115'}), (target:Files {id: 'FIL151'})
MERGE (source)-[:DOWNLOAD {
    source_name: 'PDF',
    target_name: 'ZIP',
    relationship_id: 'REL372',
    original_relation: 'download',
    created_at: datetime()
}]->(target);

// ZIP execute CHAVECLOAK
MATCH (source:Files {id: 'FIL151'}), (target:Malware {id: 'MAL19'})
MERGE (source)-[:EXECUTE {
    source_name: 'ZIP',
    target_name: 'CHAVECLOAK',
    relationship_id: 'REL373',
    original_relation: 'execute',
    created_at: datetime()
}]->(target);

// Excel document contains VBA script
MATCH (source:Files {id: 'FIL74'}), (target:Tools {id: 'TOO266'})
MERGE (source)-[:CONTAINS {
    source_name: 'Excel document',
    target_name: 'VBA script',
    relationship_id: 'REL403',
    original_relation: 'contains',
    created_at: datetime()
}]->(target);

// Windows Update.bat protected by Abobus
MATCH (source:Files {id: 'FIL145'}), (target:Tools {id: 'TOO9'})
MERGE (source)-[:PROTECTED_BY {
    source_name: 'Windows Update.bat',
    target_name: 'Abobus',
    relationship_id: 'REL406',
    original_relation: 'protected by',
    created_at: datetime()
}]->(target);

// Windows Update.bat contains test.vbs
MATCH (source:Files {id: 'FIL145'}), (target:Files {id: 'FIL139'})
MERGE (source)-[:CONTAINS {
    source_name: 'Windows Update.bat',
    target_name: 'test.vbs',
    relationship_id: 'REL407',
    original_relation: 'contains',
    created_at: datetime()
}]->(target);

// test.vbs download script.py
MATCH (source:Files {id: 'FIL139'}), (target:Files {id: 'FIL126'})
MERGE (source)-[:DOWNLOAD {
    source_name: 'test.vbs',
    target_name: 'script.py',
    relationship_id: 'REL408',
    original_relation: 'download',
    created_at: datetime()
}]->(target);

// test.vbs download Document.zip
MATCH (source:Files {id: 'FIL139'}), (target:Files {id: 'FIL63'})
MERGE (source)-[:DOWNLOAD {
    source_name: 'test.vbs',
    target_name: 'Document.zip',
    relationship_id: 'REL409',
    original_relation: 'download',
    created_at: datetime()
}]->(target);

// test.vbs download bypass.vbs
MATCH (source:Files {id: 'FIL139'}), (target:Files {id: 'FIL49'})
MERGE (source)-[:DOWNLOAD {
    source_name: 'test.vbs',
    target_name: 'bypass.vbs',
    relationship_id: 'REL410',
    original_relation: 'download',
    created_at: datetime()
}]->(target);

// bypass.vbs execute script.py
MATCH (source:Files {id: 'FIL49'}), (target:Files {id: 'FIL126'})
MERGE (source)-[:EXECUTE {
    source_name: 'bypass.vbs',
    target_name: 'script.py',
    relationship_id: 'REL411',
    original_relation: 'execute',
    created_at: datetime()
}]->(target);

// XLAM document contains VBA script
MATCH (source:Files {id: 'FIL147'}), (target:Tools {id: 'TOO266'})
MERGE (source)-[:CONTAINS {
    source_name: 'XLAM document',
    target_name: 'VBA script',
    relationship_id: 'REL422',
    original_relation: 'contains',
    created_at: datetime()
}]->(target);

// XLSX file saved in TEMP folder
MATCH (source:Files {id: 'FIL149'}), (target:Files {id: 'FIL137'})
MERGE (source)-[:SAVED_IN {
    source_name: 'XLSX file',
    target_name: 'TEMP folder',
    relationship_id: 'REL424',
    original_relation: 'saved in',
    created_at: datetime()
}]->(target);

// modularseven-1.0 deploy CoinMiner
MATCH (source:Files {id: 'FIL107'}), (target:Malware {id: 'MAL21'})
MERGE (source)-[:DEPLOY {
    source_name: 'modularseven-1.0',
    target_name: 'CoinMiner',
    relationship_id: 'REL443',
    original_relation: 'deploy',
    created_at: datetime()
}]->(target);

// driftme-1.0 deploy CoinMiner
MATCH (source:Files {id: 'FIL66'}), (target:Malware {id: 'MAL21'})
MERGE (source)-[:DEPLOY {
    source_name: 'driftme-1.0',
    target_name: 'CoinMiner',
    relationship_id: 'REL444',
    original_relation: 'deploy',
    created_at: datetime()
}]->(target);

// catme-1.0 deploy CoinMiner
MATCH (source:Files {id: 'FIL50'}), (target:Malware {id: 'MAL21'})
MERGE (source)-[:DEPLOY {
    source_name: 'catme-1.0',
    target_name: 'CoinMiner',
    relationship_id: 'REL445',
    original_relation: 'deploy',
    created_at: datetime()
}]->(target);

// modularseven-1.0 originate from sastra
MATCH (source:Files {id: 'FIL107'}), (target:Tools {id: 'TOO222'})
MERGE (source)-[:ORIGINATE_FROM {
    source_name: 'modularseven-1.0',
    target_name: 'sastra',
    relationship_id: 'REL446',
    original_relation: 'originate from',
    created_at: datetime()
}]->(target);

// driftme-1.0 originate from sastra
MATCH (source:Files {id: 'FIL66'}), (target:Tools {id: 'TOO222'})
MERGE (source)-[:ORIGINATE_FROM {
    source_name: 'driftme-1.0',
    target_name: 'sastra',
    relationship_id: 'REL447',
    original_relation: 'originate from',
    created_at: datetime()
}]->(target);

// catme-1.0 originate from sastra
MATCH (source:Files {id: 'FIL50'}), (target:Tools {id: 'TOO222'})
MERGE (source)-[:ORIGINATE_FROM {
    source_name: 'catme-1.0',
    target_name: 'sastra',
    relationship_id: 'REL448',
    original_relation: 'originate from',
    created_at: datetime()
}]->(target);

// modularseven-1.0 similar to culturestreak
MATCH (source:Files {id: 'FIL107'}), (target:Files {id: 'FIL58'})
MERGE (source)-[:SIMILAR_TO {
    source_name: 'modularseven-1.0',
    target_name: 'culturestreak',
    relationship_id: 'REL449',
    original_relation: 'similar to',
    created_at: datetime()
}]->(target);

// driftme-1.0 similar to culturestreak
MATCH (source:Files {id: 'FIL66'}), (target:Files {id: 'FIL58'})
MERGE (source)-[:SIMILAR_TO {
    source_name: 'driftme-1.0',
    target_name: 'culturestreak',
    relationship_id: 'REL450',
    original_relation: 'similar to',
    created_at: datetime()
}]->(target);

// catme-1.0 similar to culturestreak
MATCH (source:Files {id: 'FIL50'}), (target:Files {id: 'FIL58'})
MERGE (source)-[:SIMILAR_TO {
    source_name: 'catme-1.0',
    target_name: 'culturestreak',
    relationship_id: 'REL451',
    original_relation: 'similar to',
    created_at: datetime()
}]->(target);

// modularseven-1.0 use PyPI
MATCH (source:Files {id: 'FIL107'}), (target:Tools {id: 'TOO206'})
MERGE (source)-[:USE {
    source_name: 'modularseven-1.0',
    target_name: 'PyPI',
    relationship_id: 'REL452',
    original_relation: 'use',
    created_at: datetime()
}]->(target);

// driftme-1.0 use PyPI
MATCH (source:Files {id: 'FIL66'}), (target:Tools {id: 'TOO206'})
MERGE (source)-[:USE {
    source_name: 'driftme-1.0',
    target_name: 'PyPI',
    relationship_id: 'REL453',
    original_relation: 'use',
    created_at: datetime()
}]->(target);

// catme-1.0 use PyPI
MATCH (source:Files {id: 'FIL50'}), (target:Tools {id: 'TOO206'})
MERGE (source)-[:USE {
    source_name: 'catme-1.0',
    target_name: 'PyPI',
    relationship_id: 'REL454',
    original_relation: 'use',
    created_at: datetime()
}]->(target);

// modularseven-1.0 target Linux
MATCH (source:Files {id: 'FIL107'}), (target:Tools {id: 'TOO154'})
MERGE (source)-[:TARGET {
    source_name: 'modularseven-1.0',
    target_name: 'Linux',
    relationship_id: 'REL455',
    original_relation: 'target',
    created_at: datetime()
}]->(target);

// malicious PDF file downloads .NET executable file
MATCH (source:Files {id: 'FIL104'}), (target:Files {id: 'FIL18'})
MERGE (source)-[:DOWNLOADS {
    source_name: 'malicious PDF file',
    target_name: '.NET executable file',
    relationship_id: 'REL467',
    original_relation: 'downloads',
    created_at: datetime()
}]->(target);

// .NET executable file created with PowerGUI
MATCH (source:Files {id: 'FIL18'}), (target:Tools {id: 'TOO200'})
MERGE (source)-[:CREATED_WITH {
    source_name: '.NET executable file',
    target_name: 'PowerGUI',
    relationship_id: 'REL468',
    original_relation: 'created with',
    created_at: datetime()
}]->(target);

// .NET executable file runs PowerShell
MATCH (source:Files {id: 'FIL18'}), (target:Tools {id: 'TOO201'})
MERGE (source)-[:RUNS {
    source_name: '.NET executable file',
    target_name: 'PowerShell',
    relationship_id: 'REL469',
    original_relation: 'runs',
    created_at: datetime()
}]->(target);

// ========================================
// 3. VERIFICATION QUERIES
// ========================================

// Count Files outgoing relationships
MATCH (s:Files)-[r]->()
RETURN type(r) AS relationship_type, count(r) AS count
ORDER BY count DESC;

// Show sample Files relationships
MATCH (s:Files)-[r]->(target)
RETURN s.name AS source, type(r) AS relationship,
       labels(target)[0] AS target_type, target.name AS target
ORDER BY source, relationship
LIMIT 20;

// Summary: Relationship types for Files
// CONTAINS: 11
// DOWNLOAD: 6
// EXECUTE: 5
// DEPLOY: 5
// EXPLOIT: 3
// STEAL: 3
// ORIGINATE_FROM: 3
// SIMILAR_TO: 3
// USE: 3
// USES: 1
// EXECUTES: 1
// PART_OF: 1
// SAME_AS: 1
// PROTECTED_BY: 1
// SAVED_IN: 1
// TARGET: 1
// DOWNLOADS: 1
// CREATED_WITH: 1
// RUNS: 1