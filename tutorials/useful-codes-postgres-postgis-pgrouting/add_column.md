# add_column

[> GTA-v3](../../README.md) [> Tutorials](../README.md)
* * *

```sql
ALTER TABLE public.tb_iso_19115 ADD COLUMN id serial NOT NULL;
ALTER TABLE public.tb_iso_19115 ADD COLUMN livello smallint DEFAULT 0;
ALTER TABLE public.tb_iso_19115 ADD COLUMN eliminato smallint DEFAULT 0;
```

```php
$colX = ('livello');
$colY = ('eliminato');
$colW = ('data_crea');
$colWa = ('data_aggiorna');
$colZm =('idmast');
```
