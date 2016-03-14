CREATE EXTENSION hstore

INSERT INTO hstore_samples (documents, notes)
VALUES ('"active_resource"=>"true"
  ,"resource_name"=>"swimming-swiftly-1234"
  ,"resource_size_in_mb"=>"30"
  ,"resource_created_at"=>"2016-03-14 17:20:47.216862"'
, 'this is a straight up K/V hash')



--time permitting? Suspect it requires a plugin of some kind, not worth covering if that's true

INSERT INTO hstore_samples (documents, notes) VALUES (
"<TODO put a nested hash here>"
, "this is a deeply nested hash.")





--hstores are strings under the hood and require casting

SELECT * from hstore_samples hs where hs.documents -> 'resource_created_at'::timestamp > '2016-03-13'

--Need to unnest if you only want one portion of the hstore








--nifty function, note for later
--SELECT hstore(t) FROM test AS t;