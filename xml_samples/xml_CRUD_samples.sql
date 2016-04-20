CREATE TABLE xml_samples (
    id bigserial PRIMARY KEY,
    documents xml,
    comments text
)

INSERT INTO xml_samples (first_column, second_column) VALUES (
XMLPARSE( DOCUMENT $$<?xml version="1.0"?>
<catalog>
...
</catalog>$$)
, 'This is an entire XML document')

--Alternatively, this inserts one node per row.

INSERT INTO xml_samples (documents, comments) VALUES (
$$<book id="bk101">
      <author>Gambardella, Matthew</author>
      <title>XML Developer\'s Guide</title>
      <genre>Computer</genre>
      <price>44.95</price>
      <publish_date>2000-10-01</publish_date>
      <description>An in-depth look at creating applications
      with XML.</description>
   </book>$$
   , 'one book per row, as an XML node')



--Gets all titles in the table

SELECT xpath('//book/title', documents) FROM xml_samples

--Gets all info on a book by title

SELECT * FROM xml_samples WHERE (xpath('//book/title/text()'
   , documents))[1]::text = 'Midnight Rain'::text



UPDATE --cannot do this natively.