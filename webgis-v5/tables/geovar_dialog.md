# GEOVAR_DIALOG

[> webgis-v5](../README.md) > Struttura tabelle
* * *

## Create

```sql
CREATE TABLE geovar_dialog
(
    item_token character varying,
    post_date timestamp without time zone DEFAULT now(),
    post_modified timestamp without time zone DEFAULT now(),
    post_status character varying DEFAULT 'publish',
    g_slug character varying
);
--
ALTER TABLE geovar_dialog
    ADD COLUMN pid serial NOT NULL;
ALTER TABLE geovar_dialog
    ADD PRIMARY KEY (pid);
--
UPDATE geovar_dialog
SET 
  item_token = md5((pid::text || '-'::text) || (now())::text);
--
ALTER TABLE geovar_dialog
    ADD CONSTRAINT geovar_dialog_unique3 UNIQUE (item_token);
--
-- Trigger
--
--DROP TRIGGER twd_update1_geovar_dialog ON public.geovar_dialog;
--DROP FUNCTION public.fwd_update1_geovar_dialog();
CREATE OR REPLACE FUNCTION public.fwd_update1_geovar_dialog()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
    AS $BODY$
BEGIN
    UPDATE geovar_dialog
    SET 
        item_token = md5((pid::text || '-'::text) || (now())::text)
    WHERE pid = NEW.pid;
        RETURN NEW;
    END;
$BODY$;
--
CREATE TRIGGER twd_update1_geovar_dialog
    AFTER INSERT
    ON public.geovar_dialog
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update1_geovar_dialog();
-- F2
CREATE TRIGGER twd_update3_geovar_dialog
    BEFORE UPDATE
    ON public.geovar_dialog
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update_post_modified();
--
COMMENT ON TABLE geovar_dialog
    IS 'live:220716';
```

## Popolate other tables

```sql
INSERT INTO geovar_master(g_slug,g_description,g_type,g_label) VALUES ('GEOVAR_DIALOG','','geovar_auto','geovar_dialog');
--
COMMENT ON TABLE geovar_master
    IS 'live:220716';
--
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_DIALOG','pid','serial',false,false);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_DIALOG','post_date','timestamp without time zone',false,false);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_DIALOG','post_modified','timestamp without time zone',false,false);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_DIALOG','post_status','character varying',false,false);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_DIALOG','g_slug','character varying',true,true);
--
COMMENT ON TABLE geovar_tb
    IS 'live:220716';
```

## Update

```sql
ALTER TABLE geovar_dialog ADD COLUMN g_label character varying;
ALTER TABLE geovar_dialog ADD COLUMN g_description character varying;
ALTER TABLE geovar_dialog ADD COLUMN g_template character varying;
--
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_DIALOG','g_label','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_DIALOG','g_description','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_DIALOG','g_template','character varying',true,true);
--
COMMENT ON TABLE geovar_dialog
    IS 'live:220716';
--
COMMENT ON TABLE geovar_tb
    IS 'live:220716';
```

```sql
INSERT INTO geovar_dialog(g_slug,g_label,g_template) VALUES ('btn_explorer','Explorer','explorer_simple');
INSERT INTO geovar_dialog(g_slug,g_label,g_template) VALUES ('btn_explorer2','Explorer2','explorer_simple');
INSERT INTO geovar_dialog(g_slug,g_label,g_template) VALUES ('lyr031_single','Shop: ','tab_x6');
--
COMMENT ON TABLE geovar_button
    IS 'live:220716';
```
