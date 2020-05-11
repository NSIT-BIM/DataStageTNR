# RtTnrGetKeys


**Retrieve keys from a table**

| Key               | Val                                      |
| ----------------- | ---------------------------------------- |
| Category          | \T_NR\routines                           |
| type              | Server routine                           |
| last modification | 2020/05/07 10:27:39 isadmin              |
| checksum          | bdb3270bd31ae394ca6e66aa6e6359e551af30a6 |




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


