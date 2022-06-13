
# Download planet OSM

[> GTA-v3](../README.md) [> Technical articles](README.md)
* * *

Get magnet link from https://planet.openstreetmap.org/
File planet-210614.osm.pbf size 61GB

# Extract shop from planet

Use OSMIUM for extraction

```
osmium tags-filter /media/sf_world/planet-210614.osm.pbf nwr/shop -o /media/sf_world/planet-210614_shop.osm.pbf
```

This file size is 320MB. It is a compress file.

## nwr?

n=node
w=way
r=relation

## Filter with OSMIUM

It is possibile apply filter here like

```generic

n/shop=supermarket
osmium tags-filter /media/sf_world/planet-210614.osm.pbf n/shop=supermarket -o /media/sf_world/planet-210614_shop_supermarket_points.osm.pbf

osmium tags-filter /media/sf_world/planet-210614.osm.pbf n/historic=castle -o /media/sf_Documents/planet-210614_historic_castle_node.osm.pbf

```

# Convert extract to o5m

Use OSMCONVERT

```
osmconvert /media/sf_world/planet-210614_shop.osm.pbf > /media/sf_world/planet-210614_shop.o5m
```

Conversion to *.osm is similar. The osm files can be loaded in QGIS, but only for count geometries

# Filter supermarket from shop

Use OSMFILTER

```
osmfilter /media/sf_world/planet-210614_shop.o5m --keep="shop=supermarket" > /media/sf_world/planet-210614_shop_supermarket.o5m
```

# Convert OSM to GeoJSON

Use OGR2OGR from *.osm or from *.o5m

```
ogr2ogr -f GeoJSON /media/sf_world/planet-210614_shop_supermarket.geojson /media/sf_world/planet-210614_shop_supermarket.o5m points
```

If apply filter directly in osm.pbf

```
ogr2ogr -f GeoJSON /media/sf_world/planet-210614_shop_supermarket_pbf.geojson /media/sf_world/planet-210614_shop_supermarket.osm.pbf points
```

# HSTORE

HSTORE documentation: https://www.postgresql.org/docs/9.1/hstore.html
HSTORE install: https://www.postgresqltutorial.com/postgresql-hstore/

CREATE EXTENSION hstore;

# Load GeoJSON in Postgres

From gejson in QGIS import in Postgres

# HSTORE

Tutorial hstore: https://www.postgresqltutorial.com/postgresql-hstore/
Tutorial JSON: https://www.postgresqltutorial.com/postgresql-json/

## Add hstore column

```sql
ALTER TABLE public."planet-210614_shop_supermarket_pt"
ADD COLUMN mytags hstore;
```

## Convert other_tags (charvar) to mytags(hstore)

```sql
UPDATE public."planet-210614_shop_supermarket_pt"
SET mytags=other_tags::hstore
```

## Try select from HSTORE

```sql
SELECT 
--other_tags --, 
mytags->\'shop\'--, 
FROM public."planet-210614_shop_supermarket_pt" 
--WHERE select myjsonbcol->\'foo\' from mytable;
LIMIT 10;
```

```sql
SELECT 
mytags, 
mytags->\'shop\'--, 
FROM public."planet-210614_shop_supermarket_pt" 
--WHERE select myjsonbcol->\'foo\' from mytable;
WHERE NOT(mytags->\'brand\' IS NULL)
LIMIT 100;
```

# GEOHASH

```sql
UPDATE public.planet_210614_shop_supermarket_pt
SET hash9=ST_GeoHash(ST_SetSRID(geom,4326),9)
```

# QUERY

DROP TABLE public.tmp_supermarket_max;
CREATE TABLE tmp_supermarket_max AS SELECT max(codemax), hash3
FROM(
SELECT 
--pid, geom, osm_id, name, other_tags, ref, man_made, 
--highway, is_in, place, barrier, address, mytags, 
name,
count(*) as count,
substring(hash9 from 1 for 3) as hash3,
--ST_SETSRID(ST_GeomFromGeoHash(substring(hash9 from 1 for 3)),4326),
LPAD(count(*)::text, 9, \'0\')||\'-\'|| substring(hash9 from 1 for 3) as codemax
FROM public.planet_210614_shop_supermarket_pt
WHERE NOT(name IS NULL)
GROUP BY name,substring(hash9 from 1 for 3)
--LIMIT 10
) foo
WHERE count >=10
GROUP BY hash3

DROP TABLE public.max_supermarket;
CREATE TABLE max_supermarket AS 
SELECT foo.*
FROM(
    SELECT 
    --pid, geom, osm_id, name, other_tags, ref, man_made, 
    --highway, is_in, place, barrier, address, mytags, 
    name,
    count(*) as count,
    substring(hash9 from 1 for 3) as hash3,
    ST_SETSRID(ST_GeomFromGeoHash(substring(hash9 from 1 for 3)),4326),
    LPAD(count(*)::text, 9, \'0\')||\'-\'|| substring(hash9 from 1 for 3) as codemax
    FROM public.planet_210614_shop_supermarket_pt
    WHERE NOT(name IS NULL)
    GROUP BY name,substring(hash9 from 1 for 3)
    --LIMIT 10
) foo,
tmp_supermarket_max bar
WHERE foo.codemax=bar.max
AND count >=10    