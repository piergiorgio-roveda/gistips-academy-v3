# GEOVAR_ACTION

[> webgis-v5](../README.md) > Struttura tabelle
* * *

## Create

```sql
CREATE TABLE geovar_action
(
    item_token character varying,
    post_date timestamp without time zone DEFAULT now(),
    post_modified timestamp without time zone DEFAULT now(),
    post_status character varying DEFAULT 'publish',
    g_slug character varying
);
--
ALTER TABLE geovar_action
    ADD COLUMN pid serial NOT NULL;
ALTER TABLE geovar_action
    ADD PRIMARY KEY (pid);
--
UPDATE geovar_action
SET 
  item_token = md5((pid::text || '-'::text) || (now())::text);
--
ALTER TABLE geovar_action
    ADD CONSTRAINT geovar_action_unique3 UNIQUE (item_token);
--
-- Trigger
--
--DROP TRIGGER twd_update1_geovar_action ON public.geovar_action;
--DROP FUNCTION public.fwd_update1_geovar_action();
CREATE OR REPLACE FUNCTION public.fwd_update1_geovar_action()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
    AS $BODY$
BEGIN
    UPDATE geovar_action
    SET 
        item_token = md5((pid::text || '-'::text) || (now())::text)
    WHERE pid = NEW.pid;
        RETURN NEW;
    END;
$BODY$;
--
CREATE TRIGGER twd_update1_geovar_action
    AFTER INSERT
    ON public.geovar_action
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update1_geovar_action();
-- F2
CREATE TRIGGER twd_update3_geovar_action
    BEFORE UPDATE
    ON public.geovar_action
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update_post_modified();
--
COMMENT ON TABLE geovar_action
    IS 'live:220716';
```

## Popolate other tables

```sql
INSERT INTO geovar_master(g_slug,g_description,g_type,g_label) VALUES ('GEOVAR_ACTION','','geovar_auto','geovar_action');
--
COMMENT ON TABLE geovar_master
    IS 'live:220716';
--
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_ACTION','pid','serial',false,false);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_ACTION','post_date','timestamp without time zone',false,false);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_ACTION','post_modified','timestamp without time zone',false,false);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_ACTION','post_status','character varying',false,false);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_ACTION','g_slug','character varying',true,true);
--
COMMENT ON TABLE geovar_tb
    IS 'live:220716';
```

## Update

```sql
ALTER TABLE geovar_action ADD COLUMN g_label character varying;
ALTER TABLE geovar_action ADD COLUMN g_description character varying;
--
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_ACTION','g_label','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_ACTION','g_description','character varying',true,true);
--
COMMENT ON TABLE geovar_action
    IS 'live:220716';
--
COMMENT ON TABLE geovar_tb
    IS 'live:220716';
```

```sql
INSERT INTO public.geovar_action(g_slug,g_label,g_description) VALUES ('get_data','GET','Select a function to run.');
INSERT INTO public.geovar_action(g_slug,g_label,g_description) VALUES ('update_data','UPDATE','Select a function to run.');
INSERT INTO public.geovar_action(g_slug,g_label,g_description) VALUES ('create_data','CREATE','Select a function to run.');
--
COMMENT ON TABLE geovar_action
    IS 'live:220716';
```
