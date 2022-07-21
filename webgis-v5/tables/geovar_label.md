# GEOVAR_LABEL

[> webgis-v5](../README.md) > Struttura tabelle
* * *

## Creazione

```sql
CREATE TABLE geovar_label
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
ALTER TABLE geovar_label
    ADD COLUMN pid serial NOT NULL;
ALTER TABLE geovar_label
    ADD PRIMARY KEY (pid);
--
UPDATE geovar_label
SET 
  item_token = md5((pid::text || '-'::text) || (now())::text);
--
ALTER TABLE geovar_label
    ADD CONSTRAINT geovar_label_unique3 UNIQUE (item_token);
--
ALTER TABLE geovar_label
    ADD COLUMN g_label character varying;
--
ALTER TABLE geovar_label
    ADD COLUMN g_master character varying DEFAULT 'en_GB';
--
COMMENT ON TABLE geovar_label
    IS 'live:220716';
```

## Trigger

```sql
--DROP TRIGGER twd_update1_geovar_label ON public.geovar_label;
--DROP FUNCTION public.fwd_update1_geovar_label();
CREATE OR REPLACE FUNCTION public.fwd_update1_geovar_label()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
    AS $BODY$
BEGIN
    UPDATE geovar_label
    SET 
        item_token = md5((pid::text || '-'::text) || (now())::text)
    WHERE pid = NEW.pid;
        RETURN NEW;
    END;
$BODY$;
--
CREATE TRIGGER twd_update1_geovar_label
    AFTER INSERT
    ON public.geovar_label
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update1_geovar_label();
--
CREATE TRIGGER twd_update3_geovar_label
    BEFORE UPDATE
    ON public.geovar_label
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update_post_modified();
```
