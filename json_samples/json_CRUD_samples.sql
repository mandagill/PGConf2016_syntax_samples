CREATE TABLE json_samples (
    id bigserial PRIMARY KEY,
    text_json json,
    binary_json jsonb,
    notes text
)

INSERT INTO json_samples (text_json, notes) VALUES (
'{
  "minStartTimeNs": "1429828653617000000",
  "maxEndTimeNs": "1429839639367000000",
  "dataSourceId": "derived:com.google.heart_rate.bpm:com.google.android.gms:merge_heart_rate_bpm"
}'
, 'This is in the text json field')



--Can check top-level keys before querying:
SELECT jsonb_object_keys(binary_json) FROM json_samples

--Well formed JSON path:
['point'][0]['value'][0]['fpVal']

--And you can extract specific values from the document:
SELECT binary_json->'point'->0->'value'->0->'fpVal' FROM json_samples



--Can check if a given key is present:

SELECT * FROM json_samples WHERE text_json::jsonb ? 'dataSourceId'
SELECT * FROM json_samples WHERE binary_json ? 'dataSourceId'

--And can check if the value of the key matches something:

SELECT * FROM json_samples
WHERE binary_json ->> 'minStartTimeNs' = '1429828653617000000'

SELECT binary_json->'point'->0->'value'->0->'fpVal' as bpm FROM json_samples
WHERE binary_json ->> 'minStartTimeNs' = '1429828653617000000'




INSERT INTO json_samples (binary_json, notes) VALUES (
$${
  "firstName": "Amanda",
  "lastName": "Gilmore",
  "isAlive": true,
  "age": 31,
  "address": {
    "streetAddress": "255 South Airport Blvd",
    "city": "South San Francisco",
    "state": "CA",
    "postalCode": "94080"
  },
  "phoneNumbers": [
    {
      "type": "home",
      "number": "415 555-1234"
    },
    {
      "type": "office",
      "number": "415 555-4567"
    },
    {
      "type": "mobile",
      "number": "123 456-7890"
    }
  ]
}$$, 'Fake profile info for me')

--Can update at top level:

SELECT * FROM json_samples
WHERE binary_json ? 'firstName'

SELECT jsonb_pretty(t.binary_json)
FROM json_samples t
WHERE binary_json ? 'firstName'


UPDATE json_samples
SET binary_json = binary_json || '{"address": {
    "streetAddress": "123 Test Street",
    "city": "Oakland",
    "state": "CA",
    "postalCode": "94123"
  } }'
WHERE binary_json ->> 'lastName' = 'Gilmore'

--or use jsonb_set() to drill down the tree:

SELECT jsonb_set(binary_json::jsonb
  , '{address, streetAddress}'
  , '"456 Lorem Ipsum St"'::jsonb)
FROM json_samples
WHERE binary_json ->> 'lastName' = 'Gilmore'
