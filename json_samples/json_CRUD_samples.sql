INSERT INTO json_samples (text_json, notes) VALUES (
$${
  "minStartTimeNs": "1429828653617000000",
  "maxEndTimeNs": "1429839639367000000",
  "dataSourceId": "derived:com.google.heart_rate.bpm:com.google.android.gms:merge_heart_rate_bpm",
}$$
, 'This is in the text json field')


--This will throw an error as it's not valid JSON:

INSERT INTO json_samples (text_json, notes) VALUES (
$$
  "minStartTimeNs", "1429828653617000000",
  "maxEndTimeNs", "1429839639367000000",
  "dataSourceId", "derived:com.google.heart_rate.bpm:com.google.android.gms:merge_heart_rate_bpm",
$$
, 'This will error out.')



--Can select at top level. This SHOULD check if the string is a subset of the json.
--TODO figure out why this returns no rows

SELECT * FROM json_samples WHERE text_json::jsonb @> '{ "fpVal": 57.0 }'
SELECT * FROM json_samples WHERE binary_json @> '{ "fpVal": 57.0 }'::jsonb

--Or if a given key is present:

SELECT * FROM json_samples WHERE text_json::jsonb ? 'dataSourceId'
SELECT * FROM json_samples WHERE binary_json ? 'dataSourceId'

--You can check if the value of the key is something:

SELECT * FROM json_samples
WHERE binary_json ->> 'minStartTimeNs' = '1429828653617000000'


--This is where it gets fun. :)
--Full json path:
['point'][0]['value'][0]['fpVal']

SELECT jsonb_object_keys(binary_json) FROM json_samples;

SELECT binary_json->'point'->0->'value' FROM json_samples;

--   hm this is weird:
-- amg-pgconf-sandbox::DATABASE=> select binary_json->'point'->0->'value' from json_samples;
--      ?column?
-- -------------------

--  [{"fpVal": 77.0}]
-- (2 rows)

SELECT json_extract_path('['point'][0]['value']', binary_json) FROM json_samples WHERE binary_json @> '{ "fpVal": 57.0 }'::jsonb

SELECT binary_json::json->'point' from json_samples





--for updating a specific value in the document
jsonb_set()


