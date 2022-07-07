# Default for live tables

[> GTA-v3](../../README.md) [> Tutorials](../README.md)
* * *

```sql
ALTER TABLE public.table_foo
    ADD COLUMN pid serial NOT NULL;
ALTER TABLE public.table_foo
    ADD PRIMARY KEY (pid);
--
ALTER TABLE table_foo
    ADD COLUMN post_date timestamp without time zone DEFAULT now();
ALTER TABLE table_foo
    ADD COLUMN post_modified timestamp without time zone DEFAULT now();
ALTER TABLE table_foo
    ADD COLUMN post_status character varying DEFAULT 'publish';
ALTER TABLE table_foo
    ADD COLUMN codgeo character varying;
--
UPDATE table_foo
    SET codgeo = 'GEO'||lpad(pid::text, 10, '0');
ALTER TABLE table_foo
    ADD CONSTRAINT table_foo_unique2 UNIQUE (codgeo);
--
ALTER TABLE table_foo
    ADD COLUMN item_token character varying;
UPDATE table_foo
    SET item_token = md5((pid::text || '-'::text) || (now())::text);
ALTER TABLE table_foo
    ADD CONSTRAINT table_foo_unique3 UNIQUE (item_token);
--
-- FUNCTION: public.fwd_update_table1()
--DROP FUNCTION public.fwd_update_codgeo();
CREATE OR REPLACE FUNCTION public.fwd_update_codgeo()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
	AS $BODY$
    BEGIN
        UPDATE table_foo
	SET 
	    codgeo = 'GEO'||lpad(pid::text, 10, '0')
	WHERE pid = NEW.pid;
        RETURN NEW;
    END;
$BODY$;

--DROP FUNCTION public.fwd_update_item_token();
CREATE OR REPLACE FUNCTION public.fwd_update_item_token()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
	AS $BODY$
    BEGIN
        UPDATE table_foo
	SET 
	    item_token = md5((pid::text || '-'::text) || (now())::text)
	WHERE pid = NEW.pid;
        RETURN NEW;
    END;
$BODY$;

CREATE TRIGGER twd_update1_table_foo
    AFTER INSERT
    ON public.table_foo
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update_codgeo();
	
CREATE TRIGGER twd_update2_table_foo
    AFTER INSERT
    ON public.table_foo
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update_item_token();
--
--DROP FUNCTION IF EXISTS public.fwd_update_post_modified();
CREATE OR REPLACE FUNCTION public.fwd_update_post_modified()
    RETURNS TRIGGER AS $$
    BEGIN
       NEW.post_modified = NOW(); 
       RETURN NEW;
    END;
    $$ language 'plpgsql';

CREATE TRIGGER twd_update3_table_foo
    BEFORE UPDATE
    ON public.table_foo
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update_post_modified();
--
COMMENT ON TABLE table_foo
    IS 'live:220315';
--
```
