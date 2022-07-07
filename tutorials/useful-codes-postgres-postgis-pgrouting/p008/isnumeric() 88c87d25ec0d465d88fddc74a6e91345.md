# isnumeric()

Source: https://stackoverflow.com/questions/16195986/isnumeric-with-postgresql

As you may noticed, regex-based method is almost impossible to do correctly. For example, your test says that `1.234e-5` is not valid number, when it really is. Also, you missed negative numbers. What if something looks like a number, but when you try to store it it will cause overflow?

Instead, I would recommend to create function that tries to actually cast to `NUMERIC` (or `FLOAT` if your task requires it) and returns `TRUE` or `FALSE` depending on whether this cast was successful or not.

This code will fully simulate function `ISNUMERIC()`:

```sql
CREATE OR REPLACE FUNCTION isnumeric(text) RETURNS BOOLEAN AS $$
DECLARE x NUMERIC;
BEGIN
    x = $1::NUMERIC;
    RETURN TRUE;
EXCEPTION WHEN others THEN
    RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE;
```

Calling this function on your data gets following results:

```sql
WITH test(x) AS ( VALUES (''), ('.'), ('.0'), ('0.'), ('0'), ('1'), ('123'),
  ('123.456'), ('abc'), ('1..2'), ('1.2.3.4'), ('1x234'), ('1.234e-5'))
SELECT x, isnumeric(x) FROM test;

    x     | isnumeric
----------+-----------
          | f
 .        | f
 .0       | t
 0.       | t
 0        | t
 1        | t
 123      | t
 123.456  | t
 abc      | f
 1..2     | f
 1.2.3.4  | f
 1x234    | f
 1.234e-5 | t
 (13 rows)
```

Not only it is more correct and easier to read, it will also work faster if data was actually a number.