SELECT *
FROM pg_trigger
-- WHERE tgname LIKE 'on_%'
ORDER BY tgname;

drop trigger if exists "on_country_edit" on "public"."country";

CREATE OR REPLACE FUNCTION public.record_fill_updated_at(r record)
  RETURNS record
  LANGUAGE plpgsql
AS $function$
DECLARE
	t record;
BEGIN
  t := r;
  t.updated_at := NOW();
	RETURN t;
END;
$function$
;

CREATE OR REPLACE FUNCTION "public"."handle_content_item_edit"() RETURNS "trigger"
  LANGUAGE "plpgsql" SECURITY DEFINER
  AS $$
BEGIN
  RETURN record_fill_updated_at(NEW);
END;
$$;

CREATE OR REPLACE TRIGGER "on_country_edit" BEFORE UPDATE ON "public"."country" FOR EACH ROW EXECUTE FUNCTION "public"."handle_content_item_edit"();