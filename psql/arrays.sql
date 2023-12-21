SELECT COALESCE(NULL, ARRAY[1, 2, 3]);

/**
| whole_array         | first_element | length | banana_in | cocos_in | banana_any | cocos_any |
| ------------------- | ------------- | ------ | --------- | -------- | ---------- | --------- |
| apple,banana,feijoa | apple         | 3      | true      | false    | true       | false     |
*/

select
  ar as whole_array,
  ar[1] as first_element,
  cardinality(ar) as length,
  'banana' in (SELECT unnest(ar)) as banana_in,
  'cocos' in (SELECT unnest(ar)) as cocos_in,
  'banana' = any (ar) as banana_any,
  'cocos' = any (ar) as cocos_any
from
  (
    select array['apple', 'banana', 'feijoa'] as ar
  ) as array_declaration;


WITH temp(val, t) AS ( VALUES
  (1, 'A'),
  (3, 'B'),
  (2, 'C'),
  (4, 'B'),
  (5, 'A')
),
temp2 AS (
  SELECT ARRAY(SELECT (t) from temp) AS ar
)
SELECT *
  -- NOT IN PSQL!
  -- , ar_distinct AS ARRAY_DISTINCT(ar)
FROM temp2;
