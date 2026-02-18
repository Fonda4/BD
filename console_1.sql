--requete 1
SELECT *
FROM bd1.albums;

--requete 2
SELECT isbn, titre, scenariste, dessinateur, date_edition
FROM bd1.albums;

--requete 3
SELECT *
FROM bd1.albums
WHERE editeur = 'Dupuis';

--requete 4
SELECT DISTINCT titre
FROM bd1.albums
WHERE scenariste = 'Sente';

--requete 5
SELECT DISTINCT titre,editeur
FROM bd1.albums
WHERE ( scenariste = 'Uderzo' OR dessinateur = 'Uderzo' OR  coloriste = 'Uderzo' ) ;

--requete 6
SELECT *
FROM bd1.albums
WHERE coloriste IS NULL;

--requete 7
SELECT DISTINCT editeur
FROM bd1.albums
WHERE date_part('Year',date_edition)= '1977';

--requete 8
SELECT DISTINCT scenariste, dessinateur
FROM bd1.albums
WHERE scenariste != dessinateur AND editeur = 'Dargaud';

--requete 9
SELECT *
FROM bd1.albums
WHERE  dessinateur = scenariste AND  coloriste <> dessinateur;

--requete 10
SELECT *
FROM bd1.albums
WHERE scenariste = dessinateur AND scenariste = coloriste;

--requete 11
SELECT *
FROM bd1.albums
WHERE (scenariste = dessinateur) AND scenariste = coloriste
    OR (scenariste = dessinateur) AND coloriste IS NULL
    OR (scenariste = coloriste) AND dessinateur IS NULL
    OR (coloriste = dessinateur) AND scenariste IS NULL
    OR scenariste IS NOT NULL AND dessinateur IS  NULL AND coloriste IS NULL
    OR  coloriste IS NOT NULL AND scenariste IS  NULL AND dessinateur IS NULL
    OR  dessinateur IS NOT NULL AND scenariste IS  NULL AND coloriste IS NULL;

--requete 12
SELECT DISTINCT scenariste
FROM bd1.albums
WHERE date_edition >= '1980-01-01' AND prix<12 AND scenariste IS NOT NULL ;

--requete 13
SELECT isbn , titre
FROM bd1.albums
WHERE editeur != 'Casterman'
  AND (coloriste = dessinateur OR coloriste IS NULL )
  AND (date_edition NOT BETWEEN '1990-01-01' AND '1999-12-31');

--requete 14
SELECT DISTINCT titre
FROM bd1.albums
WHERE editeur NOT IN ('Casterman','Dupuis') AND scenariste != dessinateur AND scenariste != coloriste AND coloriste != dessinateur;

--requete 15
SELECT *
FROM bd1.albums
WHERE (serie = 'Lucky Luke' AND editeur = 'Dargaud' )
    OR (serie = 'Astérix' AND (editeur = 'Albert René' OR  editeur = 'Le Lombard'))
    OR ( scenariste IS NULL AND dessinateur IS NULL AND coloriste IS NULL );

--requete 16
SELECT Distinct titre,prix
FROM bd1.albums
WHERE pays_edition ='fr' AND (dessinateur IS NULL OR coloriste IS NULL );

--requete 17
SELECT isbn, titre, date_edition
FROM   bd1.albums
WHERE  serie = 'Astérix'
ORDER  BY date_edition ASC;

--requete 18
SELECT DISTINCT titre
FROM   bd1.albums
WHERE  serie = 'Astérix'
ORDER  BY titre;

--requete 19
SELECT isbn, titre, editeur, date_edition
FROM   bd1.albums
ORDER  BY editeur, date_edition;

--requete 20
SELECT isbn,titre, prix
FROM   bd1.albums
WHERE  editeur = 'Dupuis'
ORDER  BY prix DESC;
