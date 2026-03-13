--requete 21
SELECT min(date_edition)
FROM bd1.albums;

--requete 22
SELECT max(prix)
FROM bd1.albums
WHERE 'Uderzo' != dessinateur;

--requete 23
SELECT count(*)
FROM bd1.albums
WHERE editeur = 'Casterman';

--requete 24
SELECT avg(prix)
FROM bd1.albums
WHERE editeur = 'Blake et Mortimer'
    AND date_edition BETWEEN '1990-01-01' AND '1999-12-31';

--requete 25


--requete 26
SELECT Distinct titre
FROM bd1.albums
WHERE titre LIKE '%mystère%';

--requete 27
SELECT 3*0.75*sum((prix))
FROM bd1.albums
WHERE editeur = 'Blake et Mortimer';

--requete 28

SELECT max(date_part('Year' ,date_edition)) - min(date_part('Year',date_edition))
FROM bd1.albums;

--requete 29
SELECT DISTINCT scenariste
FROM bd1.albums
WHERE (serie = 'Astérix' OR serie = 'Blake et Mortimer' )
  AND date_edition >= '2000-01-01' AND scenariste is not null
ORDER BY scenariste;

--requete 30
SELECT count(DISTINCT serie)
FROM bd1.albums;

--requete 31
SELECT count(serie)
FROM bd1.albums;


--requete 32
SELECT count(*) - count(serie)
FROM bd1.albums;

--requete 33
SELECT *
FROM bd1.albums
WHERE LOWER(isbn) LIKE '2%x';

--requete 34
SELECT count(DISTINCT editeur)
FROM bd1.albums
WHERE serie ='Astérix';

--requete 35
SELECT DISTINCT coloriste
FROM bd1.albums
WHERE UPPER(coloriste) LIKE 'DE%';

--requete 36
SELECT COUNT(*), MIN(date_edition), MAX(date_edition)
FROM   bd1.albums
WHERE  scenariste = 'Uderzo'
   OR  dessinateur = 'Uderzo'
   OR  coloriste = 'Uderzo';

--requete 37
SELECT AVG(prix)
FROM bd1.albums
WHERE editeur = 'Dupuis' AND (date_edition NOT BETWEEN '1990-01-01' AND '1999-12-31');

--requete 38
SELECT *
FROM bd1.albums
WHERE isbn like '%00%';

--requete 39
SELECT DISTINCT editeur
FROM bd1.albums
WHERE (pays_edition ='be' OR pays_edition IS NULL)
  AND (date_edition BETWEEN '2010-01-01' AND '2020-12-31');

--requete 40
SELECT isbn,titre,serie,date_edition
FROM bd1.albums
WHERE (date_edition BETWEEN '1980-01-01' AND '1990-12-31')
ORDER BY serie, date_edition DESC ;

--requete 41
SELECT SUM(prix)
FROM bd1.albums
WHERE scenariste = 'Goscinny'
   OR dessinateur = 'Uderzo';

--requete 42
SELECT SUM(prix)
FROM bd1.albums
WHERE scenariste <> 'Goscinny'
  AND scenariste <> 'Uderzo';

--requete 43
SELECT isbn, titre, scenariste, serie
FROM bd1.albums
WHERE LOWER(titre) LIKE '%' || LOWER(serie) || '%';