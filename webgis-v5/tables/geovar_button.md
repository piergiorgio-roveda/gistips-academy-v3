# GEOVAR_BUTTON

[> webgis-v5](../README.md) > Struttura tabelle
* * *

## Create

```sql
CREATE TABLE geovar_button
(
    item_token character varying,
    post_date timestamp without time zone DEFAULT now(),
    post_modified timestamp without time zone DEFAULT now(),
    post_status character varying DEFAULT 'publish',
    g_slug character varying
);
--
ALTER TABLE geovar_button
    ADD COLUMN pid serial NOT NULL;
ALTER TABLE geovar_button
    ADD PRIMARY KEY (pid);
--
UPDATE geovar_button
SET 
  item_token = md5((pid::text || '-'::text) || (now())::text);
--
ALTER TABLE geovar_button
    ADD CONSTRAINT geovar_button_unique3 UNIQUE (item_token);
--
-- Trigger
--
--DROP TRIGGER twd_update1_geovar_button ON public.geovar_button;
--DROP FUNCTION public.fwd_update1_geovar_button();
CREATE OR REPLACE FUNCTION public.fwd_update1_geovar_button()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
    AS $BODY$
BEGIN
    UPDATE geovar_button
    SET 
        item_token = md5((pid::text || '-'::text) || (now())::text)
    WHERE pid = NEW.pid;
        RETURN NEW;
    END;
$BODY$;
--
CREATE TRIGGER twd_update1_geovar_button
    AFTER INSERT
    ON public.geovar_button
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update1_geovar_button();
-- F2
CREATE TRIGGER twd_update3_geovar_button
    BEFORE UPDATE
    ON public.geovar_button
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update_post_modified();
--
COMMENT ON TABLE geovar_button
    IS 'live:220716';
```

## Popolate other tables

```sql
INSERT INTO geovar_master(g_slug,g_description,g_type,g_label) VALUES ('GEOVAR_BUTTON','','geovar_auto','geovar_button');
--
COMMENT ON TABLE geovar_master
    IS 'live:220716';
--
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_BUTTON','pid','serial',false,false);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_BUTTON','post_date','timestamp without time zone',false,false);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_BUTTON','post_modified','timestamp without time zone',false,false);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_BUTTON','post_status','character varying',false,false);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_BUTTON','g_slug','character varying',true,true);
--
COMMENT ON TABLE geovar_tb
    IS 'live:220716';
```

## Update

```sql
ALTER TABLE geovar_button ADD COLUMN g_label character varying;
ALTER TABLE geovar_button ADD COLUMN g_description character varying;
ALTER TABLE geovar_button ADD COLUMN g_template character varying;
ALTER TABLE geovar_button ADD COLUMN g_faw character varying;
--
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_BUTTON','g_label','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_BUTTON','g_description','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_BUTTON','g_template','character varying',true,true);
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_BUTTON','g_faw','character varying',true,true);
--
COMMENT ON TABLE geovar_button
    IS 'live:220716';
--
COMMENT ON TABLE geovar_tb
    IS 'live:220716';
```

```sql
INSERT INTO public.geovar_button(g_slug,g_label,g_description,g_template) VALUES ('btn_explorer','EXPLORER','...','a');
INSERT INTO public.geovar_button(g_slug,g_label,g_description,g_template) VALUES ('btn_closedlg','CLOSE','...','b');
INSERT INTO public.geovar_button(g_slug,g_label,g_description,g_template) VALUES ('btn_closeexplorer','CLOSE','...','b');
--
COMMENT ON TABLE geovar_button
    IS 'live:220716';
```

```sql
ALTER TABLE geovar_button ADD COLUMN g_callback character varying;
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) VALUES ('GEOVAR_BUTTON','g_callback','character varying',true,true);
--
COMMENT ON TABLE geovar_button
    IS 'live:220717';
```
