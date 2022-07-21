# PT_ARTWORK_TYPE

[> webgis-v5](../README.md) > Struttura tabelle
* * *

## Create

```sql
CREATE TABLE pt_artwork_type
(
    geom geometry(Point,4326),
    osm_id character varying COLLATE pg_catalog."default",
    my_name character varying COLLATE pg_catalog."default",
    man_made character varying COLLATE pg_catalog."default",
    other_tags character varying COLLATE pg_catalog."default",
    osm_key character varying COLLATE pg_catalog."default",
    osm_value character varying COLLATE pg_catalog."default"
);
--
ALTER TABLE pt_artwork_type
    ADD COLUMN pid serial NOT NULL;
ALTER TABLE pt_artwork_type
    ADD PRIMARY KEY (pid);
--
ALTER TABLE pt_artwork_type ADD COLUMN item_token character varying;
ALTER TABLE pt_artwork_type ADD COLUMN post_date timestamp without time zone DEFAULT now();
ALTER TABLE pt_artwork_type ADD COLUMN post_modified timestamp without time zone DEFAULT now();
ALTER TABLE pt_artwork_type ADD COLUMN post_status character varying DEFAULT 'publish';
--
UPDATE pt_artwork_type
SET 
  item_token = md5((pid::text || '-'::text) || (now())::text);
--
ALTER TABLE pt_artwork_type
    ADD CONSTRAINT pt_artwork_type_unique3 UNIQUE (item_token);
--
ALTER TABLE pt_artwork_type ADD COLUMN my_source character varying;
ALTER TABLE pt_artwork_type ADD COLUMN my_source_id character varying;
```

## Trigger

```sql
--DROP TRIGGER twd_update1_pt_artwork_type ON public.pt_artwork_type;
--DROP FUNCTION public.fwd_update1_pt_artwork_type();
CREATE OR REPLACE FUNCTION public.fwd_update1_pt_artwork_type()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
    AS $BODY$
BEGIN
    UPDATE pt_artwork_type
    SET 
        item_token = md5((pid::text || '-'::text) || (now())::text)
    WHERE pid = NEW.pid;
        RETURN NEW;
    END;
$BODY$;
--
CREATE TRIGGER twd_update1_pt_artwork_type
    AFTER INSERT
    ON public.pt_artwork_type
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update1_pt_artwork_type();
--
```

```sql
CREATE TRIGGER twd_update3_pt_artwork_type
    BEFORE UPDATE
    ON public.pt_artwork_type
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update_post_modified();
--
COMMENT ON TABLE pt_artwork_type
    IS 'update:220718';
CREATE INDEX sidx_pt_artwork_type
    ON public.pt_artwork_type USING gist
    (geom)
    TABLESPACE pg_default;
```

## Update 220721

```sql
ALTER TABLE pt_artwork_type ADD COLUMN image_url character varying;
INSERT INTO geovar_tb(g_master,g_slug,g_type,g_preview,g_meta) 
    VALUES ('PT_ARTWORK_TYPE','image_url','character varying',true,true);
```
