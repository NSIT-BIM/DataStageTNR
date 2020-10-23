# Jx_NR_Lvl1x

![](https://img.shields.io/badge/size-12.92-green)
![](https://img.shields.io/badge/complexity-23-yellow)
![](https://img.shields.io/badge/cost-23-yellow)
![](https://img.shields.io/badge/documentation-12.11-yellow)
![](https://img.shields.io/badge/atomicity-20-yellow)

**[TNR] Level 1 : Statistics comparison**

| Key               | Val                                      |
| ----------------- | ---------------------------------------- |
| Category          | \T_NR                                    |
| type              | Parallel job                             |
| last modification | 2020/07/13 06:52:05 isadmin              |
| checksum          | 979ee6abdd65becc768b8b262e53b4319b695f0f |



![Jx_NR_Lvl1x](./Jx_NR_Lvl1x.png)

NSITBIM - 20200506 - Init

Compares 2 statistics files and generates a report with one line for each field that has a difference on one of the metrics bellow:

* numberOfValues
* minimum
* maximum
* sum
* mean

The job calls [Jx_NR_Lvl1_0](../jobs/Jx_NR_Lvl1_0) in the job's control code to generate the statistics files.


## Dependencies

* [Job Jx_NR_Lvl1_0](../jobs/Jx_NR_Lvl1_0)


## Parameters

| Parameter | Prompt              | Default          |
| --------- | ------------------- | ---------------- |
| Ps_NR_Db  | Ps_NR_Db parameters | (As pre-defined) |
| table     | table               |                  |




## Inputs

| Name           | Type         |
| -------------- | ------------ |
| StTnrRdStats_1 | StTnrRdStats |
| StTnrRdStats_2 | StTnrRdStats |



## Outputs

| Name      | Type             |
| --------- | ---------------- |
| Sf_errors | PxSequentialFile |



## Graph

```mermaid
graph TD;Sf_errors["PxSequentialFile"]-->#Ps_NR_Db.output#/TNR.#table#.level1.csv["#Ps_NR_Db.output#/TNR.#table#.level1.csv"];StTnrRdStats_1["StTnrRdStats"]-->|<br/>roundrobin<br/>|Md_drop1["PxModify"];StTnrRdStats_2["StTnrRdStats"]-->|<br/>roundrobin<br/>|Md_drop2["PxModify"];click Md_drop1 callback "[{modifyspec:KEEP CHAMP, numberofValues,minimum,maximum,sum,mean,specsuffix:;},{modifyspec:numberOfValues:decimal[10]=decimal_from_dfloat(numberOfValues),specsuffix:;},{modifyspec:minimum:decimal[30,5]=decimal_from_dfloat(minimum),specsuffix:;},{modifyspec:maximum:decimal[30,5]=decimal_from_dfloat(maximum),specsuffix:;},{modifyspec:sum:decimal[30,5]=decimal_from_dfloat(sum),specsuffix:;},{modifyspec:mean:decimal[30,5]=decimal_from_dfloat(mean),specsuffix:;},{modifyspec:nowarn,specsuffix:;}]";Md_drop1["PxModify"]-->|<br/>hash -key CHAMP -cs<br/>CHAMP|Sr_Field_1["PxSort"];click Sr_Field_1 callback "[{key:CHAMP,asc\\\\desc:asc,sorted\\\\clustered: }]";click Sr_Field_1 callback "tsort</br>[{key:CHAMP,asc\\\\\\\\desc:asc,sorted\\\\\\\\clustered: }]";Sr_Field_1["PxSort"]-->|<br/>|Co_stats["PxCompare"];click Md_drop2 callback "[{modifyspec:KEEP CHAMP, numberofValues,minimum,maximum,sum,mean,specsuffix:;},{modifyspec:numberOfValues:decimal[10]=decimal_from_dfloat(numberOfValues),specsuffix:;},{modifyspec:minimum:decimal[30,5]=decimal_from_dfloat(minimum),specsuffix:;},{modifyspec:maximum:decimal[30,5]=decimal_from_dfloat(maximum),specsuffix:;},{modifyspec:sum:decimal[30,5]=decimal_from_dfloat(sum),specsuffix:;},{modifyspec:mean:decimal[30,5]=decimal_from_dfloat(mean),specsuffix:;},{modifyspec:nowarn,specsuffix:;}]";Md_drop2["PxModify"]-->|<br/>hash -key CHAMP -cs<br/>CHAMP|Sr_Field_2["PxSort"];click Sr_Field_2 callback "[{key:CHAMP,asc\\\\desc:asc,sorted\\\\clustered: }]";click Sr_Field_2 callback "tsort</br>[{key:CHAMP,asc\\\\\\\\desc:asc,sorted\\\\\\\\clustered: }]";Sr_Field_2["PxSort"]-->|<br/>|Co_stats["PxCompare"];Co_stats["PxCompare"]-->|<br/>|Fi_errs["PxFilter"];click Fi_errs callback "[{where:first.numberOfValues<>second.numberOfValues OR first.sum<>second.sum OR first.mean<>second.mean or first.minimum<>second.minimum OR first.maximum<>second.maximum}]";Fi_errs["PxFilter"]-->|<br/>|Md_rename["PxModify"];click Md_rename callback "[{modifyspec:DROP second.CHAMP; second.minimum2=second.minimum;second.maximum2=second.maximum;second.sum2=second.sum;second.mean2=second.mean;second.numberOfValues2=second.numberOfValues,specsuffix:;}]";Md_rename["PxModify"]-->|<br/>|Ps_1["PxPromoteSubRec"];Ps_1["PxPromoteSubRec"]-->|<br/>|Ps_2["PxPromoteSubRec"];Ps_2["PxPromoteSubRec"]-->|<br/>ordered<br/>|Sf_errors["PxSequentialFile"]
```

