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
--likely need jsonb_set()
