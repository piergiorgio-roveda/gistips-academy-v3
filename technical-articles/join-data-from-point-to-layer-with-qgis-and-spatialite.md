# Join data from point to layer with QGIS and Spatialite

[> GTA-v3](../README.md) [> Technical articles](README.md)
* * *

```sql
SELECT 
streetname,
street_men + place_a_men + place_b_men \'men\',
street_women + place_a_women + place_b_women \'women\'
FROM 
(
SELECT 
	streetname,
	street_men,
	street_women,
	table1.placename \'place_a\',
	place_a_men,
	place_a_women,
	pt_place_b_with_street.placename \'place_b\',
	pt_place_b_with_street.men \'place_b_men\',
	pt_place_b_with_street.women \'place_b_women\'
FROM (
	SELECT 
		pl_street.streetname,
		pl_street.men \'street_men\',
		pl_street.women \'street_women\',
		pt_place_a_with_street.placename,
		pt_place_a_with_street.men \'place_a_men\',
		pt_place_a_with_street.women \'place_a_women\'
	FROM pl_street, pt_place_a_with_street
	WHERE pl_street.streetname=pt_place_a_with_street.HubName
) table1, pt_place_b_with_street
WHERE table1.streetname=pt_place_b_with_street.HubName
)
```



```sql
--FULL OUTER JOIN cats
--    ON dogs.color = cats.color;
	
SELECT 
	pl_street.streetname,
	pl_street.men \'street_men\',
	pl_street.women \'street_women\',
	pt_place_a_with_street.placename,
	pt_place_a_with_street.men \'place_a_men\',
	pt_place_a_with_street.women \'place_a_women\'
FROM pl_street LEFT JOIN pt_place_a_with_street
	ON pl_street.streetname=pt_place_a_with_street.HubName
```

### Acknowledgements

1. [How To Emulate SQLite FULL OUTER JOIN Clause](https://www.sqlitetutorial.net/sqlite-full-outer-join/)

### YouTube video

| [![Join data from point to layer with QGIS and Spatialite](https://img.youtube.com/vi/Z5EnoWiT9tk/0.jpg)](https://www.youtube.com/watch?v=Z5EnoWiT9tk) |
| :----------------------------------------------------------------------------------------------------------------------------------------------------: |
|                                            _YouTube: Join data from point to layer with QGIS and Spatialite_                                           |
