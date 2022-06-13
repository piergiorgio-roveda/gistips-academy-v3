# Create code from seq

```sql
UPDATE table1
SET
item_token=md5(pid::text||(now())::text)
code='UU' || LPAD(pid::text,10,'0')
-- note: SERIAL type is 4 bytes (1 to 2,147,483,647)
```

## Trigger

```sql
-- FUNCTION: public.fwd_update_table1()

DROP FUNCTION IF EXISTS public.fwd_update_table1();

CREATE OR REPLACE FUNCTION public.fwd_update_table1()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
    BEGIN
        UPDATE table1
	SET 
	    code = 'UU'||lpad(pid::text, 10, '0'),
	    item_token = md5((pid::text || '-'::text) || (now())::text)
	WHERE pid = NEW.pid;
        RETURN NEW;
    END;
$BODY$;

CREATE TRIGGER twd_update_table1
    AFTER INSERT
    ON table1
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update_table1();
```

## Try this

```sql
ALTER TABLE table1
ALTER COLUMN code 
    SET DEFAULT 'UU' || LPAD(
        (currval('table1_pid_seq'::regclass) + 1)::text,
        10,
        '0'
    );

ALTER TABLE table1
ALTER COLUMN item_token 
    SET DEFAULT md5(
        (currval('table1_pid_seq'::regclass) + 1)::text
            ||'-'||
            (now())::text
    );
```
