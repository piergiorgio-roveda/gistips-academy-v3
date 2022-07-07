# Calculate area 3857

```sql
ALTER TABLE public.pg_sezioni
    ADD COLUMN area_3857 double precision;
```

```sql
UPDATE public.pg_sezioni
	SET area_3857=ST_AREA(ST_TRANSFORM(geom,3857));
```

```sql
ALTER TABLE rel_geohash_sezioni
    ADD COLUMN area_3857 double precision;
ALTER TABLE rel_geohash_sezioni
    ADD COLUMN sezioni_fraction double precision;
```

```sql
UPDATE rel_geohash_sezioni
	SET area_3857=ST_AREA(ST_TRANSFORM(
    ST_SETSRID(ST_GeomFromGeoHash(geohash),4326)
  ,3857));
--Query returned successfully in 1 min 56 secs.
```

```sql
CREATE TABLE pg_sezioni_geohash AS
  SELECT 
    ST_UNION(
      ST_SETSRID(ST_GeomFromGeoHash(geohash),4326)
    ) as  geom,
    codsez
  FROM public.rel_geohash_sezioni
  GROUP BY codsez
--SELECT 402.678 (all!)
--Query returned successfully in 15 min 36 secs.
```

```sql
ALTER TABLE pg_sezioni_geohash
    ADD COLUMN area_3857 double precision;
UPDATE pg_sezioni_geohash
	SET area_3857=ST_AREA(ST_TRANSFORM(geom,3857));
```

```sql
UPDATE rel_geohash_sezioni AS foo
SET
  sezioni_fraction = foo.area_3857/bar.area_3857
FROM pg_sezioni_geohash AS bar
WHERE foo.codsez = bar.codsez
--UPDATE 22909725
--Query returned successfully in 7 min 59 secs.
```

# test

```sql
CREATE TABLE rel_geohash_sezioni_042018_tmp AS
SELECT 
geohash, codsez, area_3857, sezioni_fraction,
ST_SETSRID(ST_GeomFromGeoHash(geohash),4326) as geom
FROM public.rel_geohash_sezioni
WHERE codsez like '042018%';
```