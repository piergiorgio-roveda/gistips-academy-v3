# UPD post_modified with Trigger

[> GTA-v3](../../README.md) [> Tutorials](../README.md)
* * *

```sql
DROP FUNCTION IF EXISTS public.fwd_update_twitter_user();

CREATE OR REPLACE FUNCTION public.fwd_update_twitter_user()
    RETURNS TRIGGER AS $$
    BEGIN
       NEW.post_modified = NOW(); 
       RETURN NEW;
    END;
    $$ language 'plpgsql';

CREATE TRIGGER tgeo_update_twitter_user
    BEFORE UPDATE
    ON public.twitter_user
    FOR EACH ROW
    EXECUTE PROCEDURE public.fwd_update_twitter_user();
```
