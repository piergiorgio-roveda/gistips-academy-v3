-- FUNCTION: public.cdb_jenksbinsiteration(numeric[], integer, integer[], boolean, numeric, integer)

-- DROP FUNCTION IF EXISTS public.cdb_jenksbinsiteration(numeric[], integer, integer[], boolean, numeric, integer);

CREATE OR REPLACE FUNCTION public.cdb_jenksbinsiteration(
	in_matrix numeric[],
	breaks integer,
	classes integer[],
	invert boolean,
	sdam numeric,
	max_search integer DEFAULT 50)
RETURNS numeric[]
    LANGUAGE 'plpgsql'
    COST 100
    IMMUTABLE 
AS $BODY$
DECLARE
    i INT;
    iterations INT = 0;

    side INT := 2;

    gvf numeric := 0.0;
    new_gvf numeric;
    arr_gvf numeric[];
    arr_avg numeric[];
    class_avg numeric;
    class_dev numeric;

    class_max_i INT = 0;
    class_min_i INT = 0;
    dev_max numeric;
    dev_min numeric;

    best_classes INT[] = classes;
    best_gvf numeric[];
    best_avg numeric[];
    move_elements INT = 1;

    reply numeric[];

BEGIN

    -- We fill the arrays with the initial values
    i = 0;
    LOOP
        IF i = breaks THEN EXIT; END IF;
        i = i + 1;

        -- Get class mean
        SELECT (sum(v * w) / sum(w)) INTO class_avg FROM (
            SELECT unnest(in_matrix[1:1][classes[i][1]:classes[i][2]]) as v,
                    unnest(in_matrix[2:2][classes[i][1]:classes[i][2]]) as w
            ) x;

        -- Get class deviation
        SELECT sum((class_avg - v)^2 * w) INTO class_dev FROM (
            SELECT unnest(in_matrix[1:1][classes[i][1]:classes[i][2]]) as v,
                    unnest(in_matrix[2:2][classes[i][1]:classes[i][2]]) as w
            ) x;

        IF i = 1 THEN
            arr_avg = ARRAY[class_avg];
            arr_gvf = ARRAY[class_dev];
        ELSE
            arr_avg = array_append(arr_avg, class_avg);
            arr_gvf = array_append(arr_gvf, class_dev);
        END IF;
    END LOOP;

    -- We copy the values to avoid recalculation when a failure happens
    best_avg = arr_avg;
    best_gvf = arr_gvf;

    iterations = 0;
    LOOP
        IF iterations = max_search THEN EXIT; END IF;
        iterations = iterations + 1;

        -- calculate our new GVF
        SELECT sdam - sum(e) INTO new_gvf FROM ( SELECT unnest(arr_gvf) as e ) x;

        -- Check if any improvement was made
        IF new_gvf <= gvf THEN
            -- If we were moving too many elements, go back and move less
            IF move_elements <= 2 OR class_max_i = class_min_i THEN
                EXIT;
            END IF;

            move_elements = GREATEST(move_elements / 8, 1);

            -- Rollback from saved statuses
            classes = best_classes;
            new_gvf = gvf;

            i = class_min_i;
            LOOP
                arr_avg[i] = best_avg[i];
                arr_gvf[i] = best_gvf[i];

                IF i = class_max_i THEN EXIT; END IF;
                i = i + 1;
            END LOOP;
        END IF;

        -- We search for the classes with the min and max deviation
        i = 1;
        class_min_i = 1;
        class_max_i = 1;
        dev_max = arr_gvf[1];
        dev_min = arr_gvf[1];
        LOOP
            IF i = breaks THEN EXIT; END IF;
            i = i + 1;

            IF arr_gvf[i] < dev_min THEN
                dev_min = arr_gvf[i];
                class_min_i = i;
            ELSE
                IF arr_gvf[i] > dev_max THEN
                    dev_max = arr_gvf[i];
                    class_max_i = i;
                END IF;
            END IF;
        END LOOP;

        -- Save best values for comparison and output
        gvf = new_gvf;
        best_classes = classes;

        -- Limit the moved elements as to not remove everything from class_max_i
        move_elements = LEAST(move_elements, classes[class_max_i][2] - classes[class_max_i][1]);

        -- Move `move_elements` from class_max_i to class_min_i
        IF class_min_i < class_max_i THEN
            i := class_min_i;
            LOOP
                IF i = class_max_i THEN EXIT; END IF;
                classes[i][2] = classes[i][2] + move_elements;
                i := i + 1;
            END LOOP;

            i := class_max_i;
            LOOP
                IF i = class_min_i THEN EXIT; END IF;
                classes[i][1] = classes[i][1] + move_elements;
                i := i - 1;
            END LOOP;
        ELSE
            i := class_min_i;
            LOOP
                IF i = class_max_i THEN EXIT; END IF;
                classes[i][1] = classes[i][1] - move_elements;
                i := i - 1;
            END LOOP;

            i := class_max_i;
            LOOP
                IF i = class_min_i THEN EXIT; END IF;
                classes[i][2] = classes[i][2] - move_elements;
                i := i + 1;
            END LOOP;
        END IF;

        -- Recalculate avg and deviation ONLY for the affected classes
        i = LEAST(class_min_i, class_max_i);
        class_max_i = GREATEST(class_min_i, class_max_i);
        class_min_i = i;
        LOOP
            SELECT (sum(v * w) / sum(w)) INTO class_avg FROM (
                SELECT unnest(in_matrix[1:1][classes[i][1]:classes[i][2]]) as v,
                        unnest(in_matrix[2:2][classes[i][1]:classes[i][2]]) as w
                ) x;

            SELECT sum((class_avg - v)^2 * w) INTO class_dev FROM (
                SELECT unnest(in_matrix[1:1][classes[i][1]:classes[i][2]]) as v,
                        unnest(in_matrix[2:2][classes[i][1]:classes[i][2]]) as w
                ) x;

            -- Save status (in case it's needed for rollback) and store the new one
            best_avg[i] = arr_avg[i];
            arr_avg[i] = class_avg;

            best_gvf[i] = arr_gvf[i];
            arr_gvf[i] = class_dev;

            IF i = class_max_i THEN EXIT; END IF;
            i = i + 1;
        END LOOP;

        move_elements = move_elements * 2;

    END LOOP;

    i = 1;
    LOOP
        IF invert = TRUE THEN
            side = 1; --default returns bottom side of breaks, invert returns top side
        END IF;
        reply = array_append(reply, unnest(in_matrix[1:1][best_classes[i][side]:best_classes[i][side]]));
        i = i+1;
        IF i > breaks THEN  EXIT; END IF;
    END LOOP;

    reply = array_prepend(gvf, reply);
    RETURN reply;

END;
$BODY$;

ALTER FUNCTION public.cdb_jenksbinsiteration(numeric[], integer, integer[], boolean, numeric, integer)
    OWNER TO ubuntu;
