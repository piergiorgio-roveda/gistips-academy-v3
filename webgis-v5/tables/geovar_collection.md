# GEOVAR_COLLECTION

[> webgis-v5](../README.md) > Struttura tabelle
* * *

## Creazione

```sql
CREATE TABLE geovar_collection
(
    item_token character varying,
    post_date timestamp without time zone DEFAULT now(),
    post_modified timestamp without time zone DEFAULT now(),
    post_status character varying DEFAULT 'publish',
    g_slug character varying,
    g_label character varying,
    g_type character varying
);
--
ALTER TABLE geovar_collection
    ADD COLUMN pid serial NOT NULL;
ALTER TABLE geovar_collection
    ADD PRIMARY KEY (pid);
--
UPDATE geovar_collection
SET 
  item_token = md5((pid::text || '-'::text) || (now())::text);
--
ALTER TABLE geovar_collection
    ADD CONSTRAINT geovar_collection_unique3 UNIQUE (item_token);
--
ALTER TABLE geovar_collection
    ADD COLUMN g_block_params boolean DEFAULT true;
--
ALTER TABLE geovar_collection
    ADD COLUMN g_response_table boolean DEFAULT false;
ALTER TABLE geovar_collection
    ADD COLUMN g_response_map boolean DEFAULT false;
ALTER TABLE geovar_collection
    ADD COLUMN g_sub json;
--
COMMENT ON TABLE geovar_collection
    IS 'live:220702';
```

## Trigger

```sql
--DROP TRIGGER twd_update1_geovar_collection ON public.geovar_collection;
--DROP FUNCTION public.fwd_update1_geovar_collection();
CREATE OR REPLACE FUNCTION public.fwd_update1_geovar_collection()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
    AS $BODY$
BEGIN
    UPDATE geovar_collection
    SET 
        item_token = md5((pid::text || '-'::text) || (now())::text)
    WHERE pid = NEW.pid;
        RETURN NEW;
    END;
$BODY$;
--
CREATE TRIGGER twd_update1_geovar_collection
    AFTER INSERT
    ON public.geovar_collection
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update1_geovar_collection();
--
```

```sql
CREATE TRIGGER twd_update3_geovar_collection
    BEFORE UPDATE
    ON public.geovar_collection
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update_post_modified();
```
