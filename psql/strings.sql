CREATE OR REPLACE FUNCTION public.string_limit(s varchar, max_length int) RETURNS varchar
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN CASE WHEN length(s) > max_length
        THEN substring(s, 1, max_length - 3) || '...'
        ELSE s
        END;
END;
$$;

SELECT
    string_limit('babochka', 5) as _1,
    string_limit('swaggers destiny', 15) as _2,
    string_limit('swaggers destiny', 25) as _3;