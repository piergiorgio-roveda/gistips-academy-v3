# GEOVAR_TB

[> webgis-v5](../README.md) > Struttura tabelle
* * *

## Creazione

```sql
CREATE TABLE geovar_tb
(
    item_token character varying,
    post_date timestamp without time zone DEFAULT now(),
    post_modified timestamp without time zone DEFAULT now(),
    post_status character varying DEFAULT 'publish',
    g_master character varying,
    g_slug character varying,
    g_type character varying
);
--
ALTER TABLE geovar_tb
    ADD COLUMN pid serial NOT NULL;
ALTER TABLE geovar_tb
    ADD PRIMARY KEY (pid);
--
UPDATE geovar_tb
SET 
  item_token = md5((pid::text || '-'::text) || (now())::text);
--
ALTER TABLE geovar_tb
    ADD CONSTRAINT geovar_tb_unique3 UNIQUE (item_token);
--
ALTER TABLE public.geovar_tb
    ADD COLUMN g_preview boolean DEFAULT true;
--
ALTER TABLE public.geovar_tb
    ADD COLUMN g_meta boolean DEFAULT true;
--
COMMENT ON TABLE geovar_tb
    IS 'live:220716';
```

## Trigger

```sql
--DROP TRIGGER twd_update1_geovar_tb ON public.geovar_tb;
--DROP FUNCTION public.fwd_update1_geovar_tb();
CREATE OR REPLACE FUNCTION public.fwd_update1_geovar_tb()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
    AS $BODY$
BEGIN
    UPDATE geovar_tb
    SET 
        item_token = md5((pid::text || '-'::text) || (now())::text)
    WHERE pid = NEW.pid;
        RETURN NEW;
    END;
$BODY$;
--
CREATE TRIGGER twd_update1_geovar_tb
    AFTER INSERT
    ON public.geovar_tb
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update1_geovar_tb();
--
```

```sql
CREATE TRIGGER twd_update3_geovar_tb
    BEFORE UPDATE
    ON public.geovar_tb
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update_post_modified();
```

## Update all

```sql
SELECT 
  g_master, 
  g_slug, 
  g_type 
FROM 
  public.geovar_tb 
ORDER BY 
  g_master;
INSERT INTO public.geovar_tb(g_master, g_slug, g_type) 
SELECT 
  UPPER(table_name) AS g_master, 
  column_name AS g_slug, 
  data_type AS g_type 
FROM 
  information_schema.columns 
WHERE 
  table_schema = 'public' 
  AND NOT(
    UPPER(table_name) IN (
      'GEOVAR_ACTION', 'GEOVAR_BUTTON', 
      'GEOVAR_COLLECTION', 'GEOVAR_COLLECTION_PARAMS', 
      'GEOVAR_DIALOG', 'GEOVAR_LABEL', 
      'GEOVAR_LYR_MAP', 'GEOVAR_TB', 'TB_LYR', 
      'TB_MAP', 'TB_OD', 'TB_OD_DIRECTIONS', 
      'TB_PLACES', 'TB_TRANSACTIONS', 
      'GEOGRAPHY_COLUMNS', 'GEOMETRY_COLUMNS', 
      'RASTER_COLUMNS', 'RASTER_OVERVIEWS', 
      'SPATIAL_REF_SYS'
    )
  ) 
ORDER BY 
  UPPER(table_name);
```

```sql
ALTER TABLE geovar_tb ADD COLUMN g_callback character varying DEFAULT 'none';
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_TB','g_callback','character varying',true,true);
--
ALTER TABLE geovar_tb ADD COLUMN g_label character varying;
ALTER TABLE geovar_tb ADD COLUMN g_description character varying;
ALTER TABLE geovar_tb ADD COLUMN g_options json;
ALTER TABLE geovar_tb ADD COLUMN g_placeholder character varying DEFAULT '...';
ALTER TABLE geovar_tb ADD COLUMN g_required smallint DEFAULT 0;
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) 
  VALUES ('GEOVAR_TB','g_label','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) 
  VALUES ('GEOVAR_TB','g_description','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) 
  VALUES ('GEOVAR_TB','g_options','json',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) 
  VALUES ('GEOVAR_TB','g_placeholder','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) 
  VALUES ('GEOVAR_TB','g_required','smallint',true,true);
--
COMMENT ON TABLE geovar_tb
    IS 'live:220721';
```
