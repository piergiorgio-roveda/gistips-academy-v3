# GEOVAR_COLLECTION_PARAMS

[> webgis-v5](../README.md) > Struttura tabelle
* * *

## Creazione

```sql
CREATE TABLE geovar_collection_params
(
    g_master character varying,
    g_slug character varying,
    g_label character varying,
    g_description character varying,
    g_format character varying,
    g_type character varying,
    g_required integer DEFAULT 0,
    g_value character varying
);
--
ALTER TABLE geovar_collection_params
    ADD COLUMN pid serial NOT NULL;
ALTER TABLE geovar_collection_params
    ADD PRIMARY KEY (pid);
--
ALTER TABLE geovar_collection_params
    ADD COLUMN post_status character varying DEFAULT 'publish';
--
ALTER TABLE geovar_collection_params
    ADD COLUMN post_date timestamp without time zone DEFAULT now();
ALTER TABLE geovar_collection_params
    ADD COLUMN post_modified timestamp without time zone DEFAULT now();
--
ALTER TABLE geovar_collection_params
    ADD COLUMN item_token character varying;
--
ALTER TABLE geovar_collection_params
    ADD COLUMN g_options json;
--
ALTER TABLE geovar_collection_params
    ADD COLUMN g_sub json;
--
ALTER TABLE geovar_collection_params
    ADD COLUMN g_module json;
--
UPDATE geovar_collection_params
SET 
  item_token = md5((pid::text || '-'::text) || (now())::text);
--
ALTER TABLE geovar_collection_params
    ADD CONSTRAINT geovar_collection_params_unique3 UNIQUE (item_token);
--
COMMENT ON TABLE geovar_collection_params
    IS 'live:220702';
```

## Trigger

```sql
--DROP TRIGGER twd_update1_geovar_collection_params ON public.geovar_collection_params;
--DROP FUNCTION public.fwd_update1_geovar_collection_params();
CREATE OR REPLACE FUNCTION public.fwd_update1_geovar_collection_params()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
    AS $BODY$
BEGIN
    UPDATE geovar_collection_params
    SET 
        item_token = md5((pid::text || '-'::text) || (now())::text)
    WHERE pid = NEW.pid;
        RETURN NEW;
    END;
$BODY$;
--
CREATE TRIGGER twd_update1_geovar_collection_params
    AFTER INSERT
    ON public.geovar_collection_params
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update1_geovar_collection_params();
--
```

```sql
CREATE TRIGGER twd_update3_geovar_collection_params
    BEFORE UPDATE
    ON public.geovar_collection_params
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update_post_modified();
```
