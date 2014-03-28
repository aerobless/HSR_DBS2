/*
 * Array Exercises:
 * 1-7 - 28.03.2014
 * Requies import of table aa through https://github.com/aerobless/Database2/blob/master/Postgres/srcEx06/01_preparation.sql
*/

--1. Select all data from table aa
SELECT * FROM aa;

--2. Show the dimension of the inserted dataarray
SELECT a, array_ndims(b), array_dims(b) FROM aa;

--3. How long is the array of the first row in table aa
SELECT a, array_ndims(b) FROM aa WHERE a = 1;

--4. Add a element 5 to the array in table aa
--4.1 in row 1 insert the element at the end
UPDATE aa SET b = array_append(b, 5) WHERE a = 1;

--4.2 in row 2 insert the element in the front
UPDATE aa SET b = array_prepend(5, b) WHERE a = 2;

--5. Return the first row of table aa, so that the elements of the array are isolated by a ";"
SELECT a, array_to_string(b, '; ', '*') FROM aa WHERE a=1;

--6. Return the first array element from the second array-row from row 3 from table aa. *_*
SELECT b[2:2][1:1] from aa where a=3;

--7. Return the content of row 1 from table aa as independant values on rows
SELECT unnest(b) from aa where a=1;



/*
 * Dictionaries/EAV Exercises:
 * 1-5 - 28.03.2014
 * Requies import of http://wiki.hsr.ch/Datenbanken/files/gisw04.zip
*/
--List all tables (NAE - Not An Exercise)
select * from information_schema.tables

--1. List
--1.1 the first 10 alphabetic sorted, unique key in column "tags"
SELECT distinct akeys(tags) as keys FROM planet_osm_point order by keys limit 10;

--1.2 all keys in column "tags"
SELECT distinct akeys(tags) as keys FROM planet_osm_point order by keys;

--2. List
--2.1 the first 10 alphabetic sorted, unique key-value pairs in column "tags"
SELECT distinct hstore_to_matrix(tags) FROM planet_osm_point limit 10;

--2.2 all sorted, unique key-value pairs in column "tags"
SELECT distinct hstore_to_matrix(tags) FROM planet_osm_point;

--3. Return the value of key name from cell osm_id=11210062 or osm_id=50075375
SELECT tags->'name' FROM planet_osm_point where osm_id in (11210062,50075375);

--4. Return all rows containg thekey parking
SELECT tags->'name' FROM planet_osm_point WHERE tags ? 'parking';

--5. Convert the field tags in tuple osm_id=50075375
--5.1 into an array (option 1)
--Note2Self: Alternativ --> hstore_to_array(hstore)
SELECT %%tags FROM planet_osm_point where osm_id = 50075375;

--5.2 into an array (option 2)
--Note2Self: Alternativ --> hstore_to_matrix(hstore)
SELECT %#tags FROM planet_osm_point where osm_id = 50075375;
