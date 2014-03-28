/*
 * Array Exercises:
 * 1-7 - 28.03.2014
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