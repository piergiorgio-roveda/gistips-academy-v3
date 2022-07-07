-- FUNCTION: public.cdb_jenksbins(numeric[], integer, integer, boolean)

-- DROP FUNCTION IF EXISTS public.cdb_jenksbins(numeric[], integer, integer, boolean);

CREATE OR REPLACE FUNCTION public.cdb_jenksbins(
	in_array numeric[],
	breaks integer,
	iterations integer DEFAULT 0,
	invert boolean DEFAULT false)
RETURNS numeric[]
    LANGUAGE 'plpgsql'
    COST 100
    IMMUTABLE 
AS $BODY$
DECLARE
    in_matrix NUMERIC[][];
    in_unique_count BIGINT;

    shuffles INT;
    arr_mean NUMERIC;
    sdam NUMERIC;

    i INT;
    bot INT;
    top INT;

    tops INT[];
    classes INT[][];
    j INT := 1;
    curr_result NUMERIC[];
    best_result NUMERIC[];
    seedtarget TEXT;

BEGIN
    -- We clean the input array (remove NULLs) and create 2 arrays
    -- [1] contains the unique values in in_array
    -- [2] contains the number of appearances of those unique values
    SELECT ARRAY[array_agg(value), array_agg(count)] FROM
    (
        SELECT value, count(1)::numeric as count
        FROM  unnest(in_array) AS value
        WHERE value is NOT NULL
        GROUP BY value
        ORDER BY value
    ) __clean_array_q INTO in_matrix;

    -- Get the number of unique values
    in_unique_count := array_length(in_matrix[1:1], 2);

    IF in_unique_count IS NULL THEN
        RETURN NULL;
    END IF;

    IF in_unique_count <= breaks THEN
        -- There isn't enough distinct values for the requested breaks
        RETURN ARRAY(Select unnest(in_matrix[1:1])) _a;
    END IF;

    -- If not declated explicitly we iterate based on the length of the array
    IF iterations < 1 THEN
        -- This is based on a 'looks fine' heuristic
        iterations := log(in_unique_count)::integer + 1;
    END IF;

    -- We set the number of shuffles per iteration as the number of unique values but
    -- this is just another 'looks fine' heuristic
    shuffles := in_unique_count;

    -- Get the mean value of the whole vector (already ignores NULLs)
    SELECT avg(v) INTO arr_mean FROM ( SELECT unnest(in_array) as v ) x;

    -- Calculate the sum of squared deviations from the array mean (SDAM).
    SELECT sum(((arr_mean - v)^2) * w) INTO sdam FROM (
        SELECT unnest(in_matrix[1:1]) as v, unnest(in_matrix[2:2]) as w
        ) x;

    -- To start, we create ranges with approximately the same amount of different values
    top := 0;
    i := 1;
    LOOP
        bot := top + 1;
        top := ROUND(i * in_unique_count::numeric / breaks::NUMERIC);

        IF i = 1 THEN
            classes = ARRAY[ARRAY[bot,top]];
        ELSE
            classes = ARRAY_CAT(classes, ARRAY[bot,top]);
        END IF;

        i := i + 1;
        IF i > breaks THEN EXIT; END IF;
    END LOOP;

    best_result = public.CDB_JenksBinsIteration(in_matrix, breaks, classes, invert, sdam, shuffles);

    --set the seed so we can ensure the same results
    SELECT setseed(0.4567) INTO seedtarget;
    --loop through random starting positions
    LOOP
        IF j > iterations-1 THEN  EXIT;  END IF;
        i = 1;
        tops = ARRAY[in_unique_count];
        LOOP
            IF i = breaks THEN  EXIT;  END IF;
            SELECT array_agg(distinct e) INTO tops FROM (
                SELECT unnest(array_cat(tops, ARRAY[trunc(random() * in_unique_count::float8)::int + 1])) as e ORDER BY e
                ) x;
            i = array_length(tops, 1);
        END LOOP;
        top := 0;
        i = 1;
        LOOP
            bot := top + 1;
            top = tops[i];
            IF i = 1 THEN
                classes = ARRAY[ARRAY[bot,top]];
            ELSE
                classes = ARRAY_CAT(classes, ARRAY[bot,top]);
            END IF;

            i := i+1;
            IF i > breaks THEN EXIT; END IF;
        END LOOP;

        curr_result = public.CDB_JenksBinsIteration(in_matrix, breaks, classes, invert, sdam, shuffles);

        IF curr_result[1] > best_result[1] THEN
            best_result = curr_result;
        END IF;

        j = j+1;
    END LOOP;

    RETURN (best_result)[2:array_upper(best_result, 1)];
END;
$BODY$;

ALTER FUNCTION public.cdb_jenksbins(numeric[], integer, integer, boolean)
    OWNER TO ubuntu;
