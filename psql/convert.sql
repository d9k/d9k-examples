-- Boolean:
SELECT
  NULL::varchar::boolean as _null,
  '1'::jsonb::varchar::boolean as _json_1,
  'true'::jsonb::varchar::boolean as _json_true,
  '0'::jsonb::varchar::boolean as _json_0,
  'false'::jsonb::varchar::boolean as _json_false;