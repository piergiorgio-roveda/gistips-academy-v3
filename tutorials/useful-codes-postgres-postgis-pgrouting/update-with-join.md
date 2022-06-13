# UPDATE with join



```sql
UPDATE gioiellerie AS foo
SET
c01 = bar.c01,
c02 = bar.c02
FROM reseller_ok AS bar
WHERE foo.progressivo = bar.progressivo
```

## with case

```sql
UPDATE public.map003_tb_users AS foo
SET
	usr_water = CASE 
	  WHEN s_water=true THEN usr_water + 5 + (5 * x_water)
      ELSE usr_water + 5
	END
FROM public.map003_tb_lands AS bar
WHERE
	foo.usr_geohash=bar.geohash
	AND foo.post_status='publish'
	AND bar.post_status='publish'
;
```
