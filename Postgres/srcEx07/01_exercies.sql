/* Preparation: Load W05_graphs from http://wiki.hsr.ch/Datenbanken/files/W05_graphs.zip into postgres */
-- 1.1 - Understand 4_queries.sql
/* CTE sind wichtig für die Prüfung */

/* Info: Alternative http://sqlfiddle.com/#!12/54f31/7 */
-- 2.0 - Select all employees from "Angestellter" and select all "Top Chef" from "Angestellter"
SELECT persnr, name, chef FROM angestellter ORDER BY 1;
SELECT persnr, name, chef FROM angestellter WHERE chef is null order by 1;

-- 2.1 - Write a query that selects all "chef"s (boss).
SELECT cheftab.chef, angtab.name, count(*) AS underlings 
FROM angestellter AS angtab
	INNER JOIN angestellter AS cheftab ON cheftab.chef = angtab.persnr
GROUP BY cheftab.chef, angtab.name ORDER BY 1;

-- 2.2 - Write a query that selects all underlings and ignores all chefs (bosses).
select distinct angtab.persnr, angtab.name, angtab.chef
FROM angestellter AS angtab
	LEFT OUTER JOIN angestellter AS cheftab ON cheftab.chef = angtab.persnr
WHERE cheftab.persnr is null
ORDER BY 1;

-- 2.3 - Write a query that selects all underlings of chef (Steiner 1010)
SELECT persnr, name, chef FROM angestellter WHERE chef=1001 ORDER BY 1;

-- 3.0 - Trees and stuff
/* Load db from: http://wiki.hsr.ch/Datenbanken/files/W05_ltree.zip */

-- 3.1 - Select all children of the node computing
WITH RECURSIVE temptab AS (
	SELECT id, name
	FROM skills
	WHERE id = 2
UNION ALL
	SELECT s.id, s.name
	FROM temptab JOIN skills s ON s.parent_fk = temptab.id
)

SELECT * FROM temptab WHERE id != 2
ORDER BY id;

