# TB_TRANSACTIONS

[> webgis-v5](../README.md) > Struttura tabelle
* * *

## Creazione

- [meta/geovar_tb.json](https://github.com/piergiorgio-roveda/geodata02dev/blob/main/trunk/meta/geovar_tb.json?short_path=8d22e82)

## Creazione

```sql
CREATE TABLE tb_transactions
(
    item_token character varying,
    post_date timestamp without time zone DEFAULT now(),
    post_modified timestamp without time zone DEFAULT now(),
    post_status character varying DEFAULT 'publish',
    --
    t_type character varying,
    user_token character varying,
    input_params json,
    output_response json
);
--
ALTER TABLE tb_transactions
    ADD COLUMN pid serial NOT NULL;
ALTER TABLE tb_transactions
    ADD PRIMARY KEY (pid);
--
ALTER TABLE tb_transactions
    ADD COLUMN api_url character varying;
ALTER TABLE tb_transactions
    ADD COLUMN api_token character varying;
--
UPDATE tb_transactions
SET 
  item_token = md5((pid::text || '-'::text) || (now())::text);
--
ALTER TABLE tb_transactions
    ADD CONSTRAINT tb_transactions_unique3 UNIQUE (item_token);
--
COMMENT ON TABLE tb_transactions
    IS 'live:220705';
```

## Trigger

```sql
-- FUNCTION: public.fwd_update_table1()

--DROP FUNCTION public.fwd_update1_tb_transactions();
CREATE OR REPLACE FUNCTION public.fwd_update1_tb_transactions()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
    AS $BODY$
    BEGIN
        UPDATE tb_transactions
    SET 
        item_token = md5((pid::text || '-'::text) || (now())::text)
    WHERE pid = NEW.pid;
        RETURN NEW;
    END;
$BODY$;
--
CREATE TRIGGER twd_update1_tb_transactions
    AFTER INSERT
    ON public.tb_transactions
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update1_tb_transactions();
--
CREATE TRIGGER twd_update3_tb_transactions
    BEFORE UPDATE
    ON public.tb_transactions
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update_post_modified();
```
