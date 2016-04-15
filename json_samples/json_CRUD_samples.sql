CREATE TABLE json_samples (
    id bigserial PRIMARY KEY,
    text_json json,
    binary_json jsonb,
    notes text
)

INSERT INTO json_samples (text_json, notes) VALUES (
$${
  "minStartTimeNs": "1429828653617000000",
  "maxEndTimeNs": "1429839639367000000",
  "dataSourceId": "derived:com.google.heart_rate.bpm:com.google.android.gms:merge_heart_rate_bpm",
}$$
, 'This is in the text json field')


--Well formed JSON path:
['point'][0]['value'][0]['fpVal']
SELECT binary_json->'point'->0->'value'->0->'fpVal' FROM json_samples


--Can check top-level keys before querying:
SELECT jsonb_object_keys(binary_json) FROM json_samples


--And you can extract specific values from the document:
SELECT binary_json->'point'->0->'value'->0->'fpVal' FROM json_samples

--Can check if a given key is present:

SELECT * FROM json_samples WHERE text_json::jsonb ? 'dataSourceId'
SELECT * FROM json_samples WHERE binary_json ? 'dataSourceId'

--And can check if the value of the key matches something:

SELECT * FROM json_samples
WHERE binary_json ->> 'minStartTimeNs' = '1429828653617000000'

UPDATE json_samples SET binary_json = binary_json ||

















--Can select at top level. This SHOULD check if the string is a subset of the json.
--TODO figure out why this returns no rows - Cynthia helped with this, update at work

SELECT * FROM json_samples WHERE text_json::jsonb @> '{ "fpVal": 57.0 }'
SELECT * FROM json_samples WHERE binary_json @> '{ "fpVal": 57.0 }'::jsonb






--This is where it gets fun. :)






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


