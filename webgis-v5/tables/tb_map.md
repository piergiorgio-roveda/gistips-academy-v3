# tb_map

[> webgis-v5](../README.md) > Struttura tabelle
* * *

## Create

```sql
CREATE TABLE tb_map
(
    item_token character varying,
    post_date timestamp without time zone DEFAULT now(),
    post_modified timestamp without time zone DEFAULT now(),
    post_status character varying DEFAULT 'publish',
    g_slug character varying,
    g_lyr json
);
--
ALTER TABLE tb_map
    ADD COLUMN pid serial NOT NULL;
ALTER TABLE tb_map
    ADD PRIMARY KEY (pid);
--
UPDATE tb_map
SET 
  item_token = md5((pid::text || '-'::text) || (now())::text);
--
ALTER TABLE tb_map
    ADD CONSTRAINT tb_map_unique3 UNIQUE (item_token);
--
-- Trigger
--
--DROP TRIGGER twd_update1_tb_map ON public.tb_map;
--DROP FUNCTION public.fwd_update1_tb_map();
CREATE OR REPLACE FUNCTION public.fwd_update1_tb_map()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
    AS $BODY$
BEGIN
    UPDATE tb_map
    SET 
        item_token = md5((pid::text || '-'::text) || (now())::text)
    WHERE pid = NEW.pid;
        RETURN NEW;
    END;
$BODY$;
--
CREATE TRIGGER twd_update1_tb_map
    AFTER INSERT
    ON public.tb_map
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update1_tb_map();
-- F2
CREATE TRIGGER twd_update3_tb_map
    BEFORE UPDATE
    ON public.tb_map
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update_post_modified();
--
COMMENT ON TABLE tb_map
    IS 'live:220718';
```

```sql
--
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_MAP','pid','serial',false,false);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_MAP','post_date','timestamp without time zone',false,false);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_MAP','post_modified','timestamp without time zone',false,false);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_MAP','post_status','character varying',false,false);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_MAP','g_slug','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_MAP','g_lyr','json',true,true);
--
ALTER TABLE tb_map ADD COLUMN g_table json;
--
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('TB_MAP','g_table','json',true,true);
```
