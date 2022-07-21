# GEOVAR_MASTER

[> webgis-v5](../README.md) > Struttura tabelle
* * *

## Creazione

```sql
CREATE TABLE geovar_master
(
    item_token character varying,
    post_date timestamp without time zone DEFAULT now(),
    post_modified timestamp without time zone DEFAULT now(),
    post_status character varying DEFAULT 'publish',
    g_slug character varying,
    g_description character varying,
    g_type character varying
);
--
ALTER TABLE geovar_master
    ADD COLUMN pid serial NOT NULL;
ALTER TABLE geovar_master
    ADD PRIMARY KEY (pid);
--
ALTER TABLE geovar_master
    ADD COLUMN g_label character varying;
--
UPDATE geovar_master
SET 
  item_token = md5((pid::text || '-'::text) || (now())::text);
--
ALTER TABLE geovar_master
    ADD CONSTRAINT geovar_master_unique3 UNIQUE (item_token);
--
COMMENT ON TABLE geovar_master
    IS 'live:220716';
```

## Trigger

```sql
--DROP TRIGGER twd_update1_geovar_master ON public.geovar_master;
--DROP FUNCTION public.fwd_update1_geovar_master();
CREATE OR REPLACE FUNCTION public.fwd_update1_geovar_master()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
    AS $BODY$
BEGIN
    UPDATE geovar_master
    SET 
        item_token = md5((pid::text || '-'::text) || (now())::text)
    WHERE pid = NEW.pid;
        RETURN NEW;
    END;
$BODY$;
--
CREATE TRIGGER twd_update1_geovar_master
    AFTER INSERT
    ON public.geovar_master
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update1_geovar_master();
--
CREATE TRIGGER twd_update3_geovar_master
    BEFORE UPDATE
    ON public.geovar_master
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update_post_modified();
```

```sql
ALTER TABLE geovar_master
    ALTER COLUMN g_type SET NOT NULL;
ALTER TABLE geovar_master
    ADD CONSTRAINT geovar_master_unique4 UNIQUE (g_slug);
ALTER TABLE geovar_master
    ADD CONSTRAINT geovar_master_unique5 UNIQUE (g_label);
```

## Update all

```sql
INSERT INTO geovar_master(
  g_slug, g_description, g_type, g_label
) 
SELECT 
  UPPER(table_name) AS g_slug, 
  '', 
  'geodata', 
  table_name 
FROM 
  information_schema.tables 
WHERE 
  table_schema = 'public' 
  AND NOT(
    table_name IN (
      'geovar_action', 'geovar_button', 
      'geovar_collection', 'geovar_collection_params', 
      'geovar_dialog', 'geovar_label', 
      'geovar_tb', 'geovar_master', 'spatial_ref_sys', 
      'raster_columns', 'raster_overviews', 
      'geography_columns', 'geometry_columns'
    )
  );
```
