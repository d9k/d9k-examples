-- Logging example
CREATE OR REPLACE FUNCTION "public"."temporary_fn"() RETURNS "bool"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  RAISE LOG 'This is an informational message';
  RETURN TRUE;
END;
$$;

SELECT temporary_fn();