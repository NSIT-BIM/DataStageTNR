# RtTnrGetKeys


**Retrieve keys from a table**

| Key               | Val                                      |
| ----------------- | ---------------------------------------- |
| Category          | \T_NR\routines                           |
| type              | Server routine                           |
| last modification | 2020/05/20 07:01:26 isadmin              |
| checksum          | ab42444cd11b66ae904f449371ef32a78244acf3 |




NSITBIM - 20200520 -  Update

In case of table with no primary key generates a checksum for all columns

NSITBIM - 20200506 - Init

This routine is called in a Before Job for which we need the primary keys of a table.

If the calling job's `keys` parameter is not supplied it will run the job [Jx_NR_00_GetKeys](../../jobs/Jx_NR_00_GetKeys) to retrieve the keys.

2 environnement variables are populated with the keys to be used in the job depending on the need
```bash
Keys=\(22)-key key1 -key key2...\(22)
MdKeys=\(22)key1, key2...
```

## Dependencies

* [Job Jx_NR_00_GetKeys](../../jobs/Jx_NR_00_GetKeys)


