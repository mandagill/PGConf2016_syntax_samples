CREATE EXTENSION hstore

INSERT INTO hstore_samples (documents, notes) VALUES (

, "this is a straight up K/V hash")



--Maybe time permitting? Suspect it requires an ORM gem or some like thing

INSERT INTO hstore_samples (documents, notes) VALUES (

, "this is a deeply nested hash.")