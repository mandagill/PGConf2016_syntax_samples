CREATE EXTENSION hstore

INSERT INTO hstore_samples (documents, notes)
VALUES ('"active_resource"=>"true"
  ,"resource_name"=>"swimming-swiftly-1234"
  ,"resource_size_in_mb"=>"30"
  ,"resource_created_at"=>"2016-03-14 17:20:47.216862"'
, 'this is a straight up K/V hash')




--hstores are strings under the hood and require casting

SELECT * from hstore_samples where (documents -> 'resource_created_at')::timestamp > '2016-03-13'

--can get all of the values for a certain key:

SELECT (documents -> 'resource_name')::text FROM hstore_samples;

--or convert the entire table to an hstore:

SELECT hstore(t) FROM hstore_samples AS t;




UPDATE hstore_samples SET documents = documents ||  '"active_resource"=>"false"'::hstore
WHERE documents @> '"resource_name"=>"swimming-swiftly-1234"'::hstore




--this is a strict match:

DELETE from hstore_samples where documents @> '"resource_name"=>"walking-swiftly-1234"'::hstore

