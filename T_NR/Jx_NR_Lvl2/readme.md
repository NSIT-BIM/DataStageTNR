# Jx_NR_Lvl2

![](https://img.shields.io/badge/size-17.94-yellow)
![](https://img.shields.io/badge/complexity-39-orange)
![](https://img.shields.io/badge/cost-22-yellow)
![](https://img.shields.io/badge/documentation-11.27-yellow)
![](https://img.shields.io/badge/atomicity-20-yellow)

**[TNR] Level 2 : Simple table comparison**

| Key               | Val                                      |
| ----------------- | ---------------------------------------- |
| Category          | \T_NR                                    |
| type              | Parallel job                             |
| last modification | 2020/08/07 09:02:48 isadmin              |
| checksum          | 3f352b41c63e5059c481188b6cf1800f946643cf |



![Jx_NR_Lvl2](./Jx_NR_Lvl2.png)

NSITBIM - 20200807 -  Update

* Options OutPercent: samples a percentage of produced rows
* Options OutMax: outputs only *OutMax* first rows (default 0 outputs all rows)

**OutPercent preceds OutMax**


NSITBIM - 20200520 -  Update

In case of table with no primary key generates a checksum for all columns and uses the result as key

NSITBIM - 20200506 - Init

Compares 2 tables and generates a report for each inserted, deleted, modified line. The report contains only the key values and the type of difference



## Dependencies

* [Routine RtTnrGetKeys](../routines/RtTrnGetKeys)


## Parameters

| Parameter  | Prompt              |
| ---------- | ------------------- |
| table      | Table               |
| keys       | Keys                |
| Md_Before  | Md_Before           |
| Md_After   | Md_After            |
| Ps_NR_Db   | Ps_NR_Db parameters |
| OutPercent | OutPercent          |
| OutMax     | OutMax              |




## Inputs

| Name      | Type            | Server                          | Tables                        |
| --------- | --------------- | ------------------------------- | ----------------------------- |
| jdbc_db1  | JDBCConnectorPX | #Ps_NR_Db.dbConnectionString_1# | #Ps_NR_Db.dbSchema_1#.#table# |
| jdbc_db2  | JDBCConnectorPX | #Ps_NR_Db.dbConnectionString_2# | #Ps_NR_Db.dbSchema_2#.#table# |
| Rg_status | PxRowGenerator  |                                 |                               |



## Outputs

| Name      | Type             |
| --------- | ---------------- |
| Sf_errors | PxSequentialFile |



## Graph

```mermaid
graph TD;#Ps_NR_Db.dbSchema_1#.#table#["#Ps_NR_Db.dbSchema_1#.#table#"]-->|<br/>undefined<br/>undefined|jdbc_db1["JDBCConnectorPX"];#Ps_NR_Db.dbSchema_2#.#table#["#Ps_NR_Db.dbSchema_2#.#table#"]-->|<br/>undefined<br/>undefined|jdbc_db2["JDBCConnectorPX"];Sf_errors["PxSequentialFile"]-->#Ps_NR_Db.output#/TNR.#table#.level2.tmp["#Ps_NR_Db.output#/TNR.#table#.level2.tmp"];jdbc_db1["JDBCConnectorPX"]-->|<br/>roundrobin<br/>|Md_1["PxModify"];click Md_1 callback "[{modifyspec:#Md_Before#,specsuffix:;}]";Md_1["PxModify"]-->|<br/>|Gn_Csum_1["PxGeneric"];click Gn_Hash_1 callback "hash [&Keys]</br>[{}]";Gn_Hash_1["PxGeneric"]-->|<br/>auto<br/>|Gn_Sort_1["PxGeneric"];click Gn_Sort_1 callback "tsort [&Keys] </br>[{}]";Gn_Sort_1["PxGeneric"]-->|<br/>|Gn_ChCap["PxGeneric"];click Gn_Csum_1 callback "[&csum]</br>[{}]";Gn_Csum_1["PxGeneric"]-->|<br/>auto<br/>|Gn_Hash_1["PxGeneric"];click Gn_Csum_2 callback "[&csum]</br>[{}]";Gn_Csum_2["PxGeneric"]-->|<br/>auto<br/>|Gn_Hash_2["PxGeneric"];click Gn_Hash_2 callback "hash [&Keys]</br>[{}]";Gn_Hash_2["PxGeneric"]-->|<br/>auto<br/>|Gn_Sort_2["PxGeneric"];click Gn_Sort_2 callback "tsort [&Keys] </br>[{}]";Gn_Sort_2["PxGeneric"]-->|<br/>|Gn_ChCap["PxGeneric"];jdbc_db2["JDBCConnectorPX"]-->|<br/>roundrobin<br/>|Md_2["PxModify"];click Md_2 callback "[{modifyspec:#Md_After#,specsuffix:;}]";Md_2["PxModify"]-->|<br/>|Gn_Csum_2["PxGeneric"];click Gn_ChCap callback "changecapture   [&Keys] -allvalues -dropCopy -editCode 3 -insertCode 1 -deleteCode 2</br>[{}]";Gn_ChCap["PxGeneric"]-->|<br/>|Sp_limit["PxSample"];click Md_keepCols callback "[{modifyspec:keep change_code,[&MdKeys],specsuffix:;}]";Md_keepCols["PxModify"]-->|<br/>|Lk_status["PxLookup"];Rg_status["PxRowGenerator"]-->|<br/>entire<br/>|Lk_status["PxLookup"];click Lk_status callback "lookup</br>[{}]";Lk_status["PxLookup"]-->|<br/>|Md_dropCode["PxModify"];Sp_limit["PxSample"]-->|<br/>|Md_keepCols["PxModify"];click Md_dropCode callback "[{modifyspec:drop change_code,specsuffix:;}]";Md_dropCode["PxModify"]-->|<br/>ordered<br/>|Sf_errors["PxSequentialFile"]
```

