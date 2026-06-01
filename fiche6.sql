--6.1
SELECT DISTINCT ed.id_editeur, ed.nom
FROM bd3.editeurs ed, bd3.albums al
WHERE ed.id_editeur = al.editeur 
  AND al.prix <= 10
  AND al.date_edition >= '1986-07-01' 
  AND al.date_edition <= '1991-06-30';

--6.2
SELECT se.nom
FROM bd3.series se
WHERE 5 > (SELECT COUNT(al.isbn) 
           FROM bd3.albums al 
		   WHERE al.serie = se.id_serie);

--6.3
SELECT ed.pays, COUNT(ed.id_editeur)
FROM bd3.editeurs ed
WHERE ed.pays IS NOT NULL
GROUP BY ed.pays
ORDER BY COUNT(ed.id_editeur) DESC;

--6.4
SELECT COUNT(DISTINCT pa.auteur) AS nb_auteurs
FROM bd3.participations pa, bd3.albums al, bd3.series se
WHERE pa.isbn = al.isbn 
  AND al.serie = se.id_serie 
  AND (se.nom = 'Le petit Spirou' OR se.nom = 'Game Over');

--6.5
SELECT COUNT(DISTINCT pa1.auteur) AS nb_auteurs
FROM bd3.participations pa1, bd3.albums al1, bd3.series se1, bd3.participations pa2, bd3.albums al2, bd3.series se2
WHERE pa1.auteur = pa2.auteur 
  AND pa1.isbn = al1.isbn 
  AND al1.serie = se1.id_serie 
  AND se1.nom = 'Le petit Spirou'
  AND pa2.isbn = al2.isbn 
  AND al2.serie = se2.id_serie 
  AND se2.nom = 'Game Over';


--6.6
SELECT au.id_auteur, au.nom, COUNT(pa.isbn) AS nb_albums, COUNT(DISTINCT al.serie) AS nb_series
FROM bd3.auteurs au, bd3.participations pa, bd3.albums al
WHERE au.id_auteur = pa.auteur 
  AND pa.isbn = al.isbn 
  AND pa.role='s'
GROUP BY au.id_auteur, au.nom
HAVING COUNT(pa.isbn) >= 2
ORDER BY  au.nom;

--6.7
SELECT au.id_auteur, au.nom, COUNT(DISTINCT pa.isbn) AS nb_albums, COUNT(DISTINCT al.serie) AS nb_series
FROM bd3.auteurs au, bd3.participations pa, bd3.albums al
WHERE au.id_auteur = pa.auteur 
  AND pa.isbn = al.isbn
GROUP BY au.id_auteur, au.nom
HAVING COUNT(DISTINCT pa.isbn) >= 2
ORDER BY  3 DESC, 4 DESC;

--6.8
SELECT al.isbn,al.titre, al.date_edition, au.id_auteur, au.nom, pa.role
FROM bd3.albums al, bd3.participations pa, bd3.auteurs au
WHERE al.isbn = pa.isbn 
  AND pa.auteur = au.id_auteur
  AND al.serie IS NULL 
  AND date_part('year',al.date_edition) >= 1990 
  AND al.isbn LIKE '2-%'
ORDER BY al.isbn;

--6.9
SELECT COUNT(al.isbn) AS nb_albums, SUM(al.prix) AS prix_total
FROM bd3.albums al
WHERE  date_part('year',al.date_edition) >= 2000;


--6.10
SELECT se1.nom,se2.nom
FROM bd3.series se1, bd3.series se2
WHERE se1.nom <>se2.nom 
  AND se2.nom LIKE '%' || se1.nom || '%';

--6.11
SELECT au.id_auteur, au.nom, MAX(al.date_edition) AS "date_dernier_album"
FROM bd3.auteurs au, bd3.participations pa, bd3.albums al
WHERE au.id_auteur = pa.auteur 
  AND pa.isbn = al.isbn 
  AND au.e_mail IS NULL
GROUP BY au.id_auteur, au.nom;

--6.12
SELECT au.id_auteur,au.nom
FROM bd3.auteurs au
WHERE 3 = (SELECT COUNT(DISTINCT pa.role)
           FROM bd3.participations pa
           WHERE pa.auteur = au.id_auteur);

--6.13
SELECT DISTINCT au.id_auteur, au.nom
FROM bd3.auteurs au, bd3.participations pa
WHERE au.id_auteur = pa.auteur
GROUP BY au.id_auteur,au.nom, pa.isbn
HAVING COUNT(pa.role) = 3;

--6.14
SELECT al1.isbn, al1.titre
FROM bd3.albums al1, bd3.series se
WHERE al1.serie = se.id_serie 
  AND se.nom = 'Tintin'
  AND al1.date_edition = (SELECT MIN(al2.date_edition)
                          FROM bd3.albums al2 
						  WHERE al1.serie = al2.serie);

--6.15
SELECT al.isbn, al.titre, al.prix, COUNT(DISTINCT pa.auteur) AS nb_auteurs
FROM bd3.albums al, bd3.participations pa
WHERE al.isbn = pa.isbn 
  AND al.prix < 12
GROUP BY al.isbn, al.titre, al.prix
HAVING COUNT(DISTINCT pa.auteur) >= 3;

--6.16
SELECT DISTINCT au.*
FROM bd3.auteurs au, bd3.participations pa, bd3.albums al, bd3.editeurs ed
WHERE au.id_auteur = pa.auteur 
  AND pa.isbn = al.isbn 
  AND al.editeur = ed.id_editeur
  AND lower(au.e_mail) LIKE '%.fr' 
  AND (ed.pays != 'fr' OR ed.pays IS NULL);

--6.17
SELECT au.id_auteur, au.nom, COUNT(DISTINCT al.isbn) AS nb_albums, MIN(al.date_edition), MAX(al.date_edition)
FROM bd3.auteurs au,bd3.participations pa, bd3.albums al,bd3.series se
WHERE au.id_auteur = pa.auteur 
  AND pa.isbn = al.isbn
  AND al.serie = se.id_serie 
  AND se.nom = 'Astérix'
GROUP BY au.id_auteur, au.nom;

--6.18
SELECT date_part('year', al1.date_edition), al1.isbn, al1.titre, al1.prix
FROM bd3.albums al1
WHERE al1.prix = (SELECT MAX(al2.prix)
                  FROM bd3.albums al2
                  WHERE date_part('year', al1.date_edition) = date_part('year', al2.date_edition))
ORDER BY date_part('year', al1.date_edition) DESC;

--6.19
SELECT AVG(al.prix) AS prix_moyen, COUNT(al.isbn) AS nb_albums
FROM bd3.albums al, bd3.series se
WHERE al.serie = se.id_serie 
  AND se.nom = 'Game Over';

--6.20
SELECT se.nom
FROM bd3.series se
WHERE 1 = (SELECT COUNT(DISTINCT pa.auteur)
           FROM bd3.albums al, bd3.participations pa
           WHERE se.id_serie = al.serie 
		     AND al.isbn= pa.isbn 
			 AND pa.role='s');

--6.21
SELECT se.nom
FROM bd3.series se
WHERE 1 = (SELECT COUNT(DISTINCT pa.auteur)
		   FROM bd3.albums al, bd3.participations pa
           WHERE se.id_serie = al.serie 
		     AND al.isbn= pa.isbn 
			 AND pa.role='s')
  AND se.id_serie NOT IN (SELECT al2.serie 
                          FROM bd3.albums al2
                          WHERE al2.isbn NOT IN (SELECT pa2.isbn
                                                 FROM bd3.participations pa2
                                                 WHERE pa2.role = 's')
                            AND al2.serie IS NOT NULL);






























