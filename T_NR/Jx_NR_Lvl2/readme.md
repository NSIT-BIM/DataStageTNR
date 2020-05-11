# Jx_NR_Lvl2

![](https://img.shields.io/badge/size-14.93-green)
![](https://img.shields.io/badge/complexity-32-orange)
![](https://img.shields.io/badge/cost-19-yellow)
![](https://img.shields.io/badge/documentation-6.29-orange)
![](https://img.shields.io/badge/atomicity-20-yellow)

**[TNR] Level 2 : Simple table comparison**

| Key               | Val                                      |
| ----------------- | ---------------------------------------- |
| Category          | \T_NR                                    |
| type              | Parallel job                             |
| last modification | 2020/05/07 14:53:34 isadmin              |
| checksum          | ee6438cb2c82b5ea9976ffcbe8e167f59797237a |



![Jx_NR_Lvl2](./Jx_NR_Lvl2.png)

NSITBIM - 20200506 - Init

Compares 2 tables and generates a report for each inserted, deleted, modified line. The report contains only the key values and the type of difference



## Dependencies

* [Routine RtTnrGetKeys](../routines/RtTrnGetKeys)


## Parameters

| Parameter | Prompt              |
| --------- | ------------------- |
| table     | Table               |
| keys      | Keys                |
| Md_Before | Md_Before           |
| Md_After  | Md_After            |
| Ps_NR_Db  | Ps_NR_Db parameters |




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
graph TD;#Ps_NR_Db.dbSchema_1#.#table#["#Ps_NR_Db.dbSchema_1#.#table#"]-->|<br/>undefined<br/>undefined|jdbc_db1["JDBCConnectorPX"];#Ps_NR_Db.dbSchema_2#.#table#["#Ps_NR_Db.dbSchema_2#.#table#"]-->|<br/>undefined<br/>undefined|jdbc_db2["JDBCConnectorPX"];Sf_errors["PxSequentialFile"]-->#Ps_NR_Db.output#/TNR.#table#.level2.csv["#Ps_NR_Db.output#/TNR.#table#.level2.csv"];jdbc_db1["JDBCConnectorPX"]-->|<br/>roundrobin<br/>|Md_1["PxModify"];click Md_1 callback "[{modifyspec:#Md_Before#,specsuffix:;}]";Md_1["PxModify"]-->|<br/>auto<br/>|Gn_Hash_1["PxGeneric"];click Gn_Hash_1 callback "hash [&Keys]</br>[{}]";Gn_Hash_1["PxGeneric"]-->|<br/>auto<br/>|Gn_Sort_1["PxGeneric"];click Gn_Sort_1 callback "tsort [&Keys] </br>[{}]";Gn_Sort_1["PxGeneric"]-->|<br/>|Gn_ChCap["PxGeneric"];click Md_2 callback "[{modifyspec:#Md_After#,specsuffix:;}]";Md_2["PxModify"]-->|<br/>auto<br/>|Gn_Hash_2["PxGeneric"];click Gn_Hash_2 callback "hash [&Keys]</br>[{}]";Gn_Hash_2["PxGeneric"]-->|<br/>auto<br/>|Gn_Sort_2["PxGeneric"];click Gn_Sort_2 callback "tsort [&Keys] </br>[{}]";Gn_Sort_2["PxGeneric"]-->|<br/>|Gn_ChCap["PxGeneric"];jdbc_db2["JDBCConnectorPX"]-->|<br/>roundrobin<br/>|Md_2["PxModify"];click Gn_ChCap callback "changecapture   [&Keys] -allvalues -dropCopy -editCode 3 -insertCode 1 -deleteCode 2</br>[{}]";Gn_ChCap["PxGeneric"]-->|<br/>|Md_keepCols["PxModify"];click Md_keepCols callback "[{modifyspec:keep change_code,[&MdKeys],specsuffix:;}]";Md_keepCols["PxModify"]-->|<br/>|Lk_status["PxLookup"];Rg_status["PxRowGenerator"]-->|<br/>entire<br/>|Lk_status["PxLookup"];click Lk_status callback "lookup</br>[{}]";Lk_status["PxLookup"]-->|<br/>|Md_dropCode["PxModify"];click Md_dropCode callback "[{modifyspec:drop change_code,specsuffix:;}]";Md_dropCode["PxModify"]-->|<br/>ordered<br/>|Sf_errors["PxSequentialFile"]
```

