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



--Can select at top level:

SELECT * FROM json_samples WHERE text_json @> '{ "fpVal": 57.0 }'
SELECT * FROM json_samples WHERE binary_json @> '{ "fpVal": 57.0 }'

--Or at a more granular level:

