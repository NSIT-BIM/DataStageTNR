# Jx_NR_Lvl1_0

![](https://img.shields.io/badge/size-6.83-green)
![](https://img.shields.io/badge/complexity-5-green)
![](https://img.shields.io/badge/cost-6-green)
![](https://img.shields.io/badge/documentation-33.3-green)
![](https://img.shields.io/badge/atomicity-0-blue)

**Generate satistics for 2 tables**

| Key               | Val                                      |
| ----------------- | ---------------------------------------- |
| Category          | \T_NR\jobs                               |
| type              | Parallel job                             |
| last modification | 2020/05/07 12:55:14 isadmin              |
| checksum          | 7268e419eb82040493130422f49f3409d3e70cde |



![Jx_NR_Lvl1_0](./Jx_NR_Lvl1_0.png)

NSITBIM - 20200506 - Init

Select all fields for 2 tables to compare and generate statistics for each numeric field of each table.

This job is a used as a dependency for the Level 1 job [Jx_NR_Lvl1](../../Jx_NR_Lvl1)

It uses a custom stage implementation of the statistics operator


## Dependencies

* [Stage StTnrWrStats](../../stages/StTnrWrStats)


## Parameters

| Parameter | Prompt              | Default          |
| --------- | ------------------- | ---------------- |
| Ps_NR_Db  | Ps_NR_Db parameters | (As pre-defined) |
| table     | table               |                  |




## Inputs

| Name     | Type            | Server                          | Tables                        |
| -------- | --------------- | ------------------------------- | ----------------------------- |
| jdbc_db1 | JDBCConnectorPX | #Ps_NR_Db.dbConnectionString_1# | #Ps_NR_Db.dbSchema_1#.#table# |
| jdbc_db2 | JDBCConnectorPX | #Ps_NR_Db.dbConnectionString_1# | #Ps_NR_Db.dbSchema_2#.#table# |



## Outputs

| Name    | Type   |
| ------- | ------ |
| Copy_13 | PxCopy |



## Graph

```mermaid
graph TD;#Ps_NR_Db.dbSchema_1#.#table#["#Ps_NR_Db.dbSchema_1#.#table#"]-->|<br/>undefined<br/>undefined|jdbc_db1["JDBCConnectorPX"];#Ps_NR_Db.dbSchema_2#.#table#["#Ps_NR_Db.dbSchema_2#.#table#"]-->|<br/>undefined<br/>undefined|jdbc_db2["JDBCConnectorPX"];jdbc_db1["JDBCConnectorPX"]-->|<br/>roundrobin<br/>|StTnrWrStats_1["StTnrWrStats"];jdbc_db2["JDBCConnectorPX"]-->|<br/>roundrobin<br/>|StTnrWrStats_2["StTnrWrStats"];StTnrWrStats_1["StTnrWrStats"]-->|<br/>|Fu_null["PxFunnel"];StTnrWrStats_2["StTnrWrStats"]-->|<br/>|Fu_null["PxFunnel"];click Fu_null callback "funnel</br>[{}]";Fu_null["PxFunnel"]-->|<br/>|Copy_13["PxCopy"]
```

