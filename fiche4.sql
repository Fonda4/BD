-- 1. Pour quel(s) éditeur(s) a travaillé l’auteur « Goscinny » ?
SELECT DISTINCT ed.*
FROM bd3.auteurs au, bd3.participations pa, bd3.albums al, bd3.editeurs ed
WHERE au.id_auteur = pa.auteur
  AND pa.isbn = al.isbn
  AND al.editeur = ed.id_editeur
  AND au.nom = 'Goscinny';

-- 2. Quel est/sont le(s) dessinateur(s) de l'album « Astérix chez les Belges » ?
SELECT DISTINCT au.*
FROM bd3.auteurs au, bd3.participations pa, bd3.albums al, bd3.editeurs ed
WHERE au.id_auteur = pa.auteur
  AND pa.isbn = al.isbn
  AND al.editeur = ed.id_editeur
  AND al.titre = 'Astérix chez les Belges'
  AND pa.role = 'd';

-- 3. Quels sont les auteurs qui ont travaillé comme dessinateurs et/ou coloristes chez « Dupuis » ?
SELECT DISTINCT au.*
FROM bd3.auteurs au, bd3.participations pa, bd3.albums al, bd3.editeurs ed
WHERE au.id_auteur = pa.auteur
  AND pa.isbn = al.isbn
  AND al.editeur = ed.id_editeur
  AND (pa.role = 'd' OR pa.role = 'c')
  AND ed.id_editeur = 4;

-- Exercices sur GROUB BY
-- 4. Donnez, pour chaque scénariste, son identifiant, son nom et le nombre d’albums qu’il a écrits.
SELECT au.id_auteur, au.nom, COUNT(*) AS nb_albums
FROM bd3.auteurs au, bd3.participations pa
WHERE au.id_auteur = pa.auteur
  AND pa.role = 's'
GROUP BY au.id_auteur, au.nom;

-- 5. Pour chaque éditeur ayant publié au moins 10 albums, donnez son identifiant, son nom, son pays
-- et la date du plus ancien et du plus récent de ses albums.
SELECT ed.id_editeur,ed.nom,ed.pays, MIN(al.date_edition) AS "plus recent", MAX(al.date_edition) AS "plus ancien"
FROM bd3.editeurs ed,bd3.albums al
WHERE ed.id_editeur = al.editeur
GROUP BY ed.id_editeur, ed.nom,ed.pays
HAVING COUNT(*)>=10;

-- 6. Donnez, pour chaque série, son nom ainsi que le nombre d’albums en faisant partie et le prix total
-- à payer si on veut acheter tous les albums de la série. Classez le résultat par ordre décroissant du
-- nombre d’albums. Vous ne devez pas prendre les séries sans albums.
SELECT se.nom, COUNT(*) AS nombre_albums, SUM(al.prix) AS prix_total
FROM bd3.series se, bd3.albums al
WHERE se.id_serie = al.serie
GROUP BY se.nom
ORDER BY nombre_albums DESC;

-- 7. Donnez, par année, le nombre d’albums édités en Belgique ainsi que le prix moyen de ces albums.
-- Il ne faut garder que les années où il y a eu plusieurs albums édités en Belgique et il faut classer
-- le résultat par ordre décroissant du nombre d’albums édités en Belgique et, en cas d’égalité, par
-- ordre croissant de l’année.
SELECT EXTRACT(YEAR FROM al.date_edition) AS annee, COUNT(*) AS nombre_albums, AVG(al.prix) AS prix_moyen
FROM bd3.albums al, bd3.editeurs ed
WHERE al.editeur = ed.id_editeur
  AND ed.pays = 'be'
GROUP BY EXTRACT(YEAR FROM al.date_edition), al.date_edition
HAVING COUNT(*) > 1
ORDER BY nombre_albums DESC, annee ASC;

-- 8. Combien d'auteurs (différents) a-t-on répertoriés pour l'album « Coke en Stock » dont l’ISBN est
-- 2-203-00109-0 ?
SELECT COUNT(DISTINCT pa.auteur) AS nombre_auteurs
FROM bd3.participations pa
WHERE pa.isbn = '2-203-00109-0';

-- 9. Donnez les isbn, titres et les prix des albums dessinés par « Uderzo » entre 1985 et 1995.
SELECT al.isbn, al.titre, al.prix
FROM bd3.auteurs au, bd3.participations pa, bd3.albums al
WHERE au.id_auteur = pa.auteur
  AND pa.isbn = al.isbn
  AND au.nom = 'Uderzo'
  AND pa.role = 'd'
  AND al.date_edition BETWEEN '1985-01-01' AND '1995-12-31';

-- 10. Donnez la liste des albums édités en Belgique ou en France, appartenant à une série et ayant
-- plusieurs auteurs. Pour chacun de ces albums, affichez son ISBN, son titre, le nom de sa série, son
-- prix et son nombre d’auteurs.
SELECT al.isbn, al.titre, se.nom, al.prix, COUNT(DISTINCT pa.auteur) AS nb_auteurs
FROM bd3.albums al, bd3.editeurs ed, bd3.series se, bd3.participations pa
WHERE al.editeur = ed.id_editeur
  AND al.serie = se.id_serie
  AND al.isbn = pa.isbn
  AND (ed.pays = 'be' OR ed.pays = 'fr')
GROUP BY al.isbn, al.titre, se.nom, al.prix
HAVING COUNT(DISTINCT pa.auteur) > 1;

-- 11. Donnez, pour chaque éditeur, son identifiant, son nom et le nombre de séries pour lesquelles il a
-- publié au moins un album. Classez les résultats par ordre décroissant du nombre de séries, et pour
-- les éditeurs ayant le même nombre de séries, par nom d’éditeur. Vous ne devez pas afficher les
-- éditeurs n’ayant pas publié d’albums appartenant à une série.
SELECT ed.id_editeur, ed.nom, COUNT(DISTINCT se.id_serie) AS nb_series
FROM bd3.editeurs ed, bd3.albums al, bd3.series se
WHERE ed.id_editeur = al.editeur
  AND al.serie = se.id_serie
GROUP BY ed.id_editeur, ed.nom
ORDER BY nb_series DESC, ed.nom ASC;

-- 12. Quels sont les albums édités par « Dupuis » pour lesquels on connaît le coloriste ?
SELECT DISTINCT al.*
FROM bd3.albums al, bd3.editeurs ed, bd3.participations pa
WHERE al.editeur = ed.id_editeur
  AND al.isbn = pa.isbn
  AND ed.nom = 'Dupuis'
  AND pa.role = 'c';

-- 13. Quelle est la date d’édition de l'album le plus récent ayant « Goscinny » parmi ses auteurs ?
SELECT MAX(al.date_edition) AS date_plus_recente
FROM bd3.auteurs au, bd3.participations pa, bd3.albums al
WHERE au.id_auteur = pa.auteur
  AND pa.isbn = al.isbn
  AND au.nom = 'Goscinny';

-- 14. Donnez les identifiants et noms des auteurs qui ont collaboré, d'une façon ou d'une autre, à des
-- albums de la série « Astérix » avant 2010.
SELECT DISTINCT au.id_auteur, au.nom
FROM bd3.auteurs au, bd3.participations pa, bd3.albums al, bd3.series se
WHERE au.id_auteur = pa.auteur
  AND pa.isbn = al.isbn
  AND al.serie = se.id_serie
  AND se.nom = 'Astérix'
  AND al.date_edition < '2010-01-01';

-- 15. Quels rôles « Uderzo » a-t-il tenus dans les albums édités par « Dargaud » ?
SELECT DISTINCT pa.role
FROM bd3.auteurs au, bd3.participations pa, bd3.albums al, bd3.editeurs ed
WHERE au.id_auteur = pa.auteur
  AND pa.isbn = al.isbn
  AND al.editeur = ed.id_editeur
  AND au.nom = 'Uderzo'
  AND ed.nom = 'Dargaud';

-- 16. Quels sont les auteurs qui ont joué plusieurs rôles (dessinateur, coloriste …) dans un même
-- album ?
SELECT au.*
FROM bd3.auteurs au, bd3.participations pa
WHERE au.id_auteur = pa.auteur AND
GROUP BY au.id_auteur, au.nom, pa.isbn
HAVING COUNT(pa.role) > 1;


-- 17. Combien y a-t-il d'albums dessinés par chaque dessinateur ? Pour chaque dessinateur, affichez
-- son identifiant, son nom et le nombre d’albums dessinés en classant le résultat par ordre
-- décroissant du nombre d’albums dessinés
SELECT au.id_auteur, au.nom, COUNT(*) AS nombre_albums_dessines
FROM bd3.auteurs au, bd3.participations pa
WHERE au.id_auteur = pa.auteur
  AND pa.role = 'd'
GROUP BY au.id_auteur, au.nom
ORDER BY nombre_albums_dessines DESC;

-- 18. Affichez le nom des séries n’ayant eu qu’un seul auteur.
SELECT se.nom
FROM bd3.series se, bd3.albums al, bd3.participations pa
WHERE se.id_serie = al.serie
  AND al.isbn = pa.isbn
GROUP BY se.id_serie, se.nom
HAVING COUNT(DISTINCT pa.auteur) = 1;


-- 19. Donnez l’isbn, le titre et la date d’édition de tous les albums, édités en 1980 ou en 1981,
-- n’appartenant pas à une série.
SELECT al.isbn, al.titre, al.date_edition
FROM bd3.albums al
WHERE al.serie IS NULL
  AND (EXTRACT(YEAR FROM al.date_edition) = 1980
    OR EXTRACT(YEAR FROM al.date_edition) = 1981);


-- 20. Pour chaque éditeur qui a édité au moins un album de moins de 10€, affichez son identifiant, son
-- nom, sa nationalité, et le nombre d’albums de moins de 10€ qu'il a publiés. Les éditeurs de même
-- nationalité doivent se suivre et pour une même nationalité, les éditeurs doivent être triés par
-- ordre décroissant du nombre d'albums de moins de 10 euros
SELECT ed.*, COUNT(*) AS albums_pas_chers
FROM bd3.editeurs ed, bd3.albums al
WHERE ed.id_editeur = al.editeur
  AND al.prix < 10
GROUP BY ed.id_editeur, ed.nom, ed.pays
ORDER BY ed.pays ASC, albums_pas_chers DESC;