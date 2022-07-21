# GEOVAR_LYR_MAP

[> webgis-v5](../README.md) > Struttura tabelle
* * *

## Create

```sql
CREATE TABLE geovar_lyr_map
(
    item_token character varying,
    post_date timestamp without time zone DEFAULT now(),
    post_modified timestamp without time zone DEFAULT now(),
    post_status character varying DEFAULT 'publish',
    g_slug character varying
);
--
ALTER TABLE geovar_lyr_map
    ADD COLUMN pid serial NOT NULL;
ALTER TABLE geovar_lyr_map
    ADD PRIMARY KEY (pid);
--
UPDATE geovar_lyr_map
SET 
  item_token = md5((pid::text || '-'::text) || (now())::text);
--
ALTER TABLE geovar_lyr_map
    ADD CONSTRAINT geovar_lyr_map_unique3 UNIQUE (item_token);
--
-- Trigger
--
--DROP TRIGGER twd_update1_geovar_lyr_map ON public.geovar_lyr_map;
--DROP FUNCTION public.fwd_update1_geovar_lyr_map();
CREATE OR REPLACE FUNCTION public.fwd_update1_geovar_lyr_map()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
    AS $BODY$
BEGIN
    UPDATE geovar_lyr_map
    SET 
        item_token = md5((pid::text || '-'::text) || (now())::text)
    WHERE pid = NEW.pid;
        RETURN NEW;
    END;
$BODY$;
--
CREATE TRIGGER twd_update1_geovar_lyr_map
    AFTER INSERT
    ON public.geovar_lyr_map
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update1_geovar_lyr_map();
-- F2
CREATE TRIGGER twd_update3_geovar_lyr_map
    BEFORE UPDATE
    ON public.geovar_lyr_map
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update_post_modified();
--
COMMENT ON TABLE geovar_lyr_map
    IS 'live:220718';
```

```sql
--
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_LYR_MAP','pid','serial',false,false);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_LYR_MAP','post_date','timestamp without time zone',false,false);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_LYR_MAP','post_modified','timestamp without time zone',false,false);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_LYR_MAP','post_status','character varying',false,false);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_LYR_MAP','g_slug','character varying',true,true);
--
```
