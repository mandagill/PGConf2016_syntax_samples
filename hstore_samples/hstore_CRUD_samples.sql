CREATE EXTENSION hstore

CREATE TABLE hstore_samples (
    id bigserial PRIMARY KEY,
    documents hstore,
    comments text
)

INSERT INTO hstore_samples (documents, comments)
VALUES ('"active_resource"=>"true"
  ,"resource_name"=>"swimming-swiftly-1234"
  ,"resource_size_in_mb"=>"30"
  ,"resource_created_at"=>"2016-03-14 17:20:47.216862"'
, 'this is a straight up K/V hash')


--hstores are strings under the hood and require casting

SELECT * from hstore_samples
WHERE (documents -> 'resource_size_in_mb')::int > 30


--can get all of the values for a certain key:

SELECT (documents -> 'resource_name')::text
FROM hstore_samples

--or convert the entire table to an hstore:

SELECT hstore(t) FROM xml_samples AS t



--Pulling multiple values from the document

SELECT (documents -> 'resource_name')::text as resource_name
, (documents -> 'active_resource')::text as is_active
FROM hstore_samples

--Cannot do this in place, hence the || operator

UPDATE hstore_samples
SET documents = documents || '"active_resource"=>"false"'::hstore
WHERE documents @> '"resource_name"=>"swimming-swiftly-1234"'::hstore


--use the string containment operator for strict matching:

DELETE FROM hstore_samples
WHERE documents @> '"resource_name"=>"walking-slowly-1234"'::hstore

