# Js_NR

![](https://img.shields.io/badge/size-9.13-green)
![](https://img.shields.io/badge/complexity-11-green)
![](https://img.shields.io/badge/cost--)
![](https://img.shields.io/badge/documentation-0-red)
![](https://img.shields.io/badge/atomicity--)

**undefined**

| Key               | Val                                      |
| ----------------- | ---------------------------------------- |
| Category          | \T_NR                                    |
| type              | Sequence job                             |
| last modification | 2020/05/07 14:53:23 isadmin              |
| checksum          | 497d5ee5ea927f65a8f6d04f713b57559af96aac |



![Js_NR](./Js_NR.png)




## Parameters

| Parameter | Prompt              | Default          |
| --------- | ------------------- | ---------------- |
| Ps_NR_Db  | Ps_NR_Db parameters | (As pre-defined) |
| table     | table               |                  |
| level     | level               | 2                |




## Inputs

| Name               | Type        |
| ------------------ | ----------- |
| Nested_Condition_4 | JSCondition |



## Outputs

| Name              | Type          |
| ----------------- | ------------- |
| Copy_of_Ja_Level2 | JSJobActivity |



## Graph

```mermaid
graph TD;Nested_Condition_4["CCondition"]-->|<br/>undefined<br/>undefined|Ja_Level1["Jx_NR_Lvl1"];Ja_Level1["Jx_NR_Lvl1"]-->|<br/>undefined<br/>undefined|Nested_Condition_16["CCondition"];Nested_Condition_4["CCondition"]-->|<br/>undefined<br/>undefined|Sequencer_19["CSequencer"];Nested_Condition_4["CCondition"]-->|<br/>undefined<br/>undefined|Sequencer_25["CSequencer"];Sequencer_19["CSequencer"]-->|<br/>undefined<br/>undefined|Ja_Level2["Jx_NR_Lvl2"];Ja_Level2["Jx_NR_Lvl2"]-->|<br/>undefined<br/>undefined|Nested_Condition_24["CCondition"];Sequencer_25["CSequencer"]-->|<br/>undefined<br/>undefined|Copy_of_Ja_Level2["Jx_NR_Lvl3"];Nested_Condition_16["CCondition"]-->|<br/>undefined<br/>undefined|Sequencer_19["CSequencer"];Nested_Condition_24["CCondition"]-->|<br/>undefined<br/>undefined|Sequencer_25["CSequencer"]
```

