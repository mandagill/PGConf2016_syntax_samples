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

--TODO cannot figure out how to query on more deeply nested keys,
--e.g. specififc json path