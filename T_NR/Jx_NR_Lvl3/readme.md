# Jx_NR_Lvl3

![](https://img.shields.io/badge/size-38.43-red)
![](https://img.shields.io/badge/complexity-79.64-red)
![](https://img.shields.io/badge/cost-54-red)
![](https://img.shields.io/badge/documentation-6.18-orange)
![](https://img.shields.io/badge/atomicity-20-yellow)

**[TNR] Level 3 : Deep table comparison**

| Key               | Val                                      |
| ----------------- | ---------------------------------------- |
| Category          | \T_NR                                    |
| type              | Parallel job                             |
| last modification | 2020/05/07 14:53:42 isadmin              |
| checksum          | 40436d336389c9c780e549f881e8c1f5f49de32c |



![Jx_NR_Lvl3](./Jx_NR_Lvl3.png)

NSITBIM - 20200506 - Init

Compares 2 tables and generates a report with one line  for each column that has a difference:
* Level:field: level of comparison and field name
* Before: value of the field before
* After: value of the field after
* Keys: value of the keys

Most differences should be of level 3 but inserted/deleted lines (level 2)  and duplicates (level 3) will also be present.

Parameters `Md_Before` and `Md_After` can be used to convert or drop columns that are to be ignored or unhandled data types (e.g. floats are not correctly compared by datastage, they should be converted to decimal).


## Dependencies

* [Routine RtTnrGetKeys](../routines/RtTrnGetKeys)


## Parameters

| Parameter | Prompt              | Default          |
| --------- | ------------------- | ---------------- |
| Md_Before | Md_Before           | nowarn           |
| Md_After  | Md_After            | nowarn           |
| keys      | Keys                |                  |
| Ps_NR_Db  | Ps_NR_Db parameters | (As pre-defined) |
| table     | Table               |                  |




## Inputs

| Name     | Type            | Server                          | Tables                        |
| -------- | --------------- | ------------------------------- | ----------------------------- |
| jdbc_db1 | JDBCConnectorPX | #Ps_NR_Db.dbConnectionString_1# | #Ps_NR_Db.dbSchema_1#.#table# |
| jdbc_db2 | JDBCConnectorPX | #Ps_NR_Db.dbConnectionString_2# | #Ps_NR_Db.dbSchema_2#.#table# |



## Outputs

| Name      | Type             |
| --------- | ---------------- |
| Copy_73   | PxCopy           |
| Sf_errors | PxSequentialFile |
| Peek_253  | PxPeek           |



## Graph

```mermaid
graph TD;Sf_errors["PxSequentialFile"]-->#Ps_NR_Db.output#/TNR.#table#.level3.csv["#Ps_NR_Db.output#/TNR.#table#.level3.csv"];#Ps_NR_Db.dbSchema_1#.#table#["#Ps_NR_Db.dbSchema_1#.#table#"]-->|<br/>undefined<br/>undefined|jdbc_db1["JDBCConnectorPX"];#Ps_NR_Db.dbSchema_2#.#table#["#Ps_NR_Db.dbSchema_2#.#table#"]-->|<br/>undefined<br/>undefined|jdbc_db2["JDBCConnectorPX"];jdbc_db1["JDBCConnectorPX"]-->|<br/>roundrobin<br/>|Md_db1["PxModify"];click Md_db1 callback "[{modifyspec:#Md_Before#,specsuffix:;}]";Md_db1["PxModify"]-->|<br/>auto<br/>|Cg_source1["PxColumnGenerator"];Cg_source1["PxColumnGenerator"]-->|<br/>auto<br/>|Fu_in["PxFunnel"];click Md_db2 callback "[{modifyspec:#Md_After#,specsuffix:;}]";Md_db2["PxModify"]-->|<br/>auto<br/>|Cg_source2["PxColumnGenerator"];Cg_source2["PxColumnGenerator"]-->|<br/>auto<br/>|Fu_in["PxFunnel"];jdbc_db2["JDBCConnectorPX"]-->|<br/>roundrobin<br/>|Md_db2["PxModify"];click Fu_in callback "funnel</br>[{}]";Fu_in["PxFunnel"]-->|<br/>auto<br/>|Cp_1["PxCopy"];Cp_1["PxCopy"]-->|<br/>auto<br/>|Gn_hash["PxGeneric"];click Gn_hash callback "hash [&Cles]</br>[{}]";Gn_hash["PxGeneric"]-->|<br/>auto<br/>|Gn_sort["PxGeneric"];click Gn_sort callback "tsort [&Cles] -key T_SOURCE -flagKey</br>[{}]";Gn_sort["PxGeneric"]-->|<br/>auto<br/>|Fi_dups["PxFilter"];Ck_all["PxChecksum"]-->|<br/>auto<br/>|Cg_CombineRecs["PxGeneric"];click Cg_CombineRecs callback "aggtorec\r\n-subrecname 'subrec'\r\n[&Cles]\r\n-toplevelkeys\r\n</br>[{}]";Cg_CombineRecs["PxGeneric"]-->|<br/>auto<br/>|Sr_subrec["PxSplitSubRec"];Sr_subrec["PxSplitSubRec"]-->|<br/>auto<br/>|Gn_trVecs["PxGeneric"];click Gn_trVecs callback "transform\r\n-reject\r\n-flag compileAndRun\r\n-compiler 'g++'\r\n-compileopt '-c -O -fPIC -Wno-deprecated -m64 -mtune=generic -mcmodel=small'\r\n-linker 'g++'\r\n-linkopt '-shared -m64'\r\n-name #DSJobName#_#DSJobInvocationId#\r\n-dir #DSProjectDirectory#/buildop/\r\n-expression '\r\ninputname 0 In ;\r\noutputname 0 Out ;\r\ninitialize {\r\n int8 RowRejected0;\r\n uint64 VecLen0;\r\n}\r\nmainloop {\r\n RowRejected0 = 1;\r\n VecLen0 = get_vector_length(In.T_SOURCE[]);\r\n Out.Len=VecLen0;\r\n writerecord 0;\r\n RowRejected0 = 0;\r\n}\r\nfinish {\r\n}'\r\n</br>[{}]";Gn_trVecs["PxGeneric"]-->|<br/>auto<br/>|Fi_errs["PxFilter"];click Gn_trVecs callback "transform\r\n-reject\r\n-flag compileAndRun\r\n-compiler 'g++'\r\n-compileopt '-c -O -fPIC -Wno-deprecated -m64 -mtune=generic -mcmodel=small'\r\n-linker 'g++'\r\n-linkopt '-shared -m64'\r\n-name #DSJobName#_#DSJobInvocationId#\r\n-dir #DSProjectDirectory#/buildop/\r\n-expression '\r\ninputname 0 In ;\r\noutputname 0 Out ;\r\ninitialize {\r\n int8 RowRejected0;\r\n uint64 VecLen0;\r\n}\r\nmainloop {\r\n RowRejected0 = 1;\r\n VecLen0 = get_vector_length(In.T_SOURCE[]);\r\n Out.Len=VecLen0;\r\n writerecord 0;\r\n RowRejected0 = 0;\r\n}\r\nfinish {\r\n}'\r\n</br>[{}]";Gn_trVecs["PxGeneric"]-->|<br/>auto<br/>|Copy_73["PxCopy"];click Fi_errs callback "[{where:len<>2 and len < 10,target:0},{where:len=2 and checksum[0]<>checksum[1],target:1},{where:len>=10,target:2}]";Fi_errs["PxFilter"]-->|<br/>auto<br/>|Tr_errs2["CTransformerStage"];click Fi_errs callback "[{where:len<>2 and len < 10,target:0},{where:len=2 and checksum[0]<>checksum[1],target:1},{where:len>=10,target:2}]";Fi_errs["PxFilter"]-->|<br/>auto<br/>|Cg_const["PxColumnGenerator"];click Fi_errs callback "[{where:len<>2 and len < 10,target:0},{where:len=2 and checksum[0]<>checksum[1],target:1},{where:len>=10,target:2}]";Fi_errs["PxFilter"]-->|<br/>auto<br/>|Peek_253["PxPeek"];click Lkp_fields callback "lookup</br>[{}]";Lkp_fields["PxLookup"]-->|<br/>auto<br/>|Tr_errs3["CTransformerStage"];Tr_errs3["CTransformerStage"]-->|<br/>auto<br/>|Md_errs3["PxModify"];click Md_errs3 callback "[{modifyspec:keep [&MdKeys],LEVEL,BEFORE,AFTER,specsuffix:;}]";Md_errs3["PxModify"]-->|<br/>auto<br/>|Fu_errors["PxFunnel"];Cp_1["PxCopy"]-->|<br/>auto<br/>|Md_dropSrc["PxModify"];click Md_dropSrc callback "[{modifyspec:drop T_SOURCE,specsuffix:;}]";Md_dropSrc["PxModify"]-->|<br/>auto<br/>|Gn_peek["PxGeneric"];click Gn_peek callback "peek\r\n-nrecs 1\r\n-dataset\r\n-name\r\n-delim '\\\\x1E'\r\n-part 0</br>[{}]";Gn_peek["PxGeneric"]-->|<br/>auto<br/>|Md_rec["PxModify"];click Md_rec callback "[{modifyspec:T_COLS=rec,specsuffix:;}]";Md_rec["PxModify"]-->|<br/>auto<br/>|Tr_fields["CTransformerStage"];Cg_const["PxColumnGenerator"]-->|<br/>auto<br/>|Lkp_fields["PxLookup"];Sr_fields["PxSplitSubRec"]-->|<br/>entire<br/>|Lkp_fields["PxLookup"];click Md_dropChg callback "[{modifyspec:drop keyChange,specsuffix:;}]";Md_dropChg["PxModify"]-->|<br/>auto<br/>|Ck_all["PxChecksum"];Tr_errs2["CTransformerStage"]-->|<br/>auto<br/>|Md_errs2["PxModify"];click Md_errs2 callback "[{modifyspec:KEEP [&MdKeys],LEVEL,BEFORE,AFTER,specsuffix:;}]";Md_errs2["PxModify"]-->|<br/>auto<br/>|Fu_errors["PxFunnel"];Cg_errs1["PxColumnGenerator"]-->|<br/>auto<br/>|Fu_errors["PxFunnel"];click Fu_errors callback "[{key:LEVEL,asc\\\\desc:asc}]";click Fu_errors callback "sortfunnel</br>[{key:LEVEL,asc\\\\\\\\desc:asc}]";Fu_errors["PxFunnel"]-->|<br/>auto<br/>|Sf_errors["PxSequentialFile"];click Fi_dups callback "[{where:keyChange=1,target:0},{where:keyChange=0,target:1}]";Fi_dups["PxFilter"]-->|<br/>auto<br/>|Md_dropChg["PxModify"];click Fi_dups callback "[{where:keyChange=1,target:0},{where:keyChange=0,target:1}]";Fi_dups["PxFilter"]-->|<br/>auto<br/>|Cp_dups["PxCopy"];Tr_fields["CTransformerStage"]-->|<br/>hash -key T_KEY<br/>T_KEY,T_COLS|Cg_Fields["PxCombineRecords"];click Cg_Fields callback "[{key:T_KEY}]";Cg_Fields["PxCombineRecords"]-->|<br/>auto<br/>|Sr_fields["PxSplitSubRec"];Cp_dups["PxCopy"]-->|<br/>hash -key T_SOURCE<br/>T_SOURCE|Agg_dups["PxAggregator"];click Agg_dups callback "[{key:T_SOURCE}]";Agg_dups["PxAggregator"]-->|<br/>auto<br/>|Md_errs1["PxModify"];click Md_errs1 callback "[{modifyspec:BEFORE=lookup_string_from_int16[( \1\=0;\0\=1)] (T_SOURCE),specsuffix:;},{modifyspec:AFTER=lookup_string_from_int16[( \1\=1;\0\=0)] (T_SOURCE),specsuffix:;},{modifyspec:nowarn,specsuffix:;},{modifyspec:Keep T_SOURCE,specsuffix:;}]";Md_errs1["PxModify"]-->|<br/>auto<br/>|Cg_errs1["PxColumnGenerator"]
```

