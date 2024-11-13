--DROP TRIGGER IF EXISTS on_demo_entity_edit ON public.demo_entities;
DROP TRIGGER IF EXISTS on_demo_package_edit ON public.demo_packages;
DROP FUNCTION IF EXISTS "public"."handle_entity_edit"() CASCADE;

CREATE OR REPLACE FUNCTION "public"."handle_entity_edit"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  NEW.updated_at := NOW();
  RETURN NEW;
END;
$$;

-- -- NOT FIRED on demo_packages edit!
-- CREATE TRIGGER on_demo_entity_edit
--   BEFORE UPDATE
--   ON public.demo_entities
--   FOR EACH ROW
--   EXECUTE PROCEDURE public.handle_entity_edit();

CREATE TRIGGER on_demo_package_edit
  BEFORE UPDATE
  ON public.demo_packages
  FOR EACH ROW
  EXECUTE PROCEDURE public.handle_entity_edit();