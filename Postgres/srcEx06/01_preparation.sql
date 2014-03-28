/* Perparation for exercises week 6*/
CREATE TABLE aa (a int primary key, b int[]);
INSERT INTO aa VALUES (1, '{1,2,3,4}');
INSERT INTO aa VALUES (2, ARRAY[1,2,3,4]);
INSERT INTO aa VALUES (3, '{{1,2},{3,4}}');
INSERT INTO aa VALUES (4, ARRAY[ARRAY[1,2],ARRAY[3,4]]);

CREATE TABLE cc (a int, b char(2));
INSERT INTO cc values (1, 'Aa'), (2, 'Bb'), (3, 'Cc'), (4, 'Dd'), (6, 'Ff');