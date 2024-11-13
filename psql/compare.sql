CREATE OR REPLACE FUNCTION public.equal_or_both_null(a anycompatible, b anycompatible)
  RETURNS BOOLEAN
  LANGUAGE plpgsql
AS $function$
DECLARE
  result BOOLEAN;
BEGIN
  result := (a = b) OR (a IS NULL AND b IS NULL);
  IF result IS NULL THEN
    RETURN FALSE;
  END IF;
  RETURN result;
END;
$function$
;

SELECT equal_or_both_null(1, 1) AS _1_1,   equal_or_both_null(1, 0) AS _1_0, equal_or_both_null(NULL, NULL) AS _null_null,  equal_or_both_null(1, NULL) AS _1_null;