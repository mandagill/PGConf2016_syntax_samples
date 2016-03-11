INSERT INTO xml_sample (first_column, second_column) values (
XMLPARSE( DOCUMENT $$<?xml version="1.0"?>
<catalog>
...
</catalog>$$)
, 'This is an entire XML document')

--alternatively...

INSERT INTO xml_sample (first_column, second_column) values (
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

SELECT xpath('//book/title', first_column) from xml_sample;

--Gets all info on a book by title

SELECT * FROM xml_sample WHERE (xpath('//book/title/text()
   , first_column))[1]::text = 'Midnight Rain'::text



UPDATE --cannot do this natively.



DELETE FROM xml_sample WHERE (xpath('//book/genre/text()'
   , first_column))[1]::text = 'Fantasy'::text