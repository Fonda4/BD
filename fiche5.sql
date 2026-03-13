-- Exercices avec subselect
-- 1. Donnez, pour chaque album dont le prix est supérieur au prix moyen de tous les albums, son isbn,
-- son titre, sa date d’édition, son prix et le nom de son éditeur. Triez le résultat par ordre décroissant
-- de prix et pour un même prix, dans l’ordre chronologique.
SELECT al.isbn, al.titre, al.date_edition, al.prix, ed.nom
FROM bd3.albums al, bd3.editeurs ed
WHERE al.editeur = ed.id_editeur
  AND al.prix > (SELECT AVG(prix)
                 FROM bd3.albums)
ORDER BY al.prix DESC, al.date_edition;


-- 2. Donnez l’identifiant et le nom de tous les auteurs ayant été scénariste mais jamais coloriste ou
-- dessinateur.
SELECT au.id_auteur, au.nom
FROM bd3.auteurs au
WHERE au.id_auteur IN (
    SELECT pa.auteur
    FROM bd3.participations pa
    WHERE pa.role = 's'
)
  AND au.id_auteur NOT IN (
    SELECT pa2.auteur
    FROM bd3.participations pa2
    WHERE pa2.role ='c' OR pa2.role = 'd'  -- (à toi de compléter pour coloriste ou dessinateur !)
    );


-- 3. Donnez les éditeurs qui ont publié au moins un album n’ayant pas d’auteurs connus.
SELECT DISTINCT ed.*
FROM bd3.editeurs ed, bd3.albums al
WHERE ed.id_editeur = al.editeur
    AND al.isbn NOT IN (
    SELECT pa.isbn
    FROM bd3.participations pa
    );



-- 4. Donnez l’identifiant et le nom des auteurs ayant publié tous leurs albums chez "Dupuis". Il ne faut
-- pas prendre les auteurs n’ayant participé à aucun album.
SELECT au.id_auteur, au.nom
FROM bd3.auteurs au
WHERE au.id_auteur IN (
    SELECT pa.auteur
    FROM bd3.participations pa, bd3.albums al, bd3.editeurs ed
    WHERE pa.isbn = al.isbn
      AND al.editeur = ed.id_editeur
      AND ed.nom = 'Dupuis'
)
  AND au.id_auteur NOT IN (
    SELECT pa2.auteur
    FROM bd3.participations pa2, bd3.albums al2, bd3.editeurs ed2
    WHERE pa2.isbn= al2.isbn
    AND al2.editeur = ed2.id_editeur
    AND ed2.nom <> 'Dupuis'
    );

-- Exercices mélangés
-- 5. Donnez les noms des séries dont au moins un album a été édité chez "Dupuis", et, pour chacune
-- d’elles, le nombre d’albums édités chez "Dupuis".
SELECT se.nom, COUNT(al.isbn) AS nombre_albums
FROM bd3.series se, bd3.albums al, bd3.editeurs ed
WHERE se.id_serie = al.serie       -- Ta 1ère jointure (série - album)
  AND al.editeur = ed.id_editeur        -- Ta 2ème jointure (album - éditeur)
  AND ed.nom = 'Dupuis'
GROUP BY se.nom ;                   -- Sur quelle colonne doit-on regrouper ?


-- 6. Donnez les éditeurs qui ont édité des albums en 1978 ?
SELECT DISTINCT ed.*
FROM bd3.albums al, bd3.editeurs ed
WHERE ed.id_editeur = al.editeur
 AND DATE_PART('year',al.date_edition)= 1978;


-- 7. Quels sont les albums pour lesquels le coloriste n'a pas été spécifié ? [cite: 2463]
SELECT al.*
FROM bd3.albums al
WHERE al.isbn NOT IN (
    SELECT p.isbn
    FROM bd3.participations p
    WHERE p.role = 'c'
);

-- 8. Donnez, pour chaque série, son nom ainsi que le nombre d'auteurs y ayant contribué. [cite: 2464]
-- Il ne faut garder que les séries pour lesquelles plusieurs auteurs ont contribué. [cite: 2465]
-- Classez les résultats en ordre décroissant du nombre d'auteurs. [cite: 2466]
SELECT s.nom, COUNT(DISTINCT p.auteur) AS nb_auteurs
FROM bd3.series s, bd3.albums al, bd3.participations p
WHERE s.id_serie = al.serie
  AND al.isbn = p.isbn
GROUP BY s.id_serie, s.nom
HAVING COUNT(DISTINCT p.auteur) > 1
ORDER BY nb_auteurs DESC;

-- 9. Donnez, pour chaque scénariste, son identifiant, son nom et le nombre d'albums qu'il a écrits. [cite: 2467]
SELECT au.id_auteur, au.nom, COUNT(p.isbn) AS nb_albums
FROM bd3.auteurs au, bd3.participations p
WHERE au.id_auteur = p.auteur
  AND p.role = 's'
GROUP BY au.id_auteur, au.nom;

-- 10. Donnez, pour chaque auteur, son identifiant, son nom et le nombre d'albums auxquels il a participé; [cite: 2468]
-- affichez les résultats dans l'ordre décroissant du nombre d'albums. Les auteurs n'ayant participé à aucun album ne doivent pas apparaître. [cite: 2469]
SELECT au.id_auteur, au.nom, COUNT(DISTINCT p.isbn) AS nb_albums
FROM bd3.auteurs au, bd3.participations p
WHERE au.id_auteur = p.auteur
GROUP BY au.id_auteur, au.nom
ORDER BY nb_albums DESC;

-- 11. Quels sont les scénaristes dont on a édité, après 1990, des albums qui coûtent moins de 12 euros ? [cite: 2470]
SELECT DISTINCT au.*
FROM bd3.auteurs au, bd3.participations p, bd3.albums al
WHERE au.id_auteur = p.auteur
  AND p.isbn = al.isbn
  AND p.role = 's'
  AND DATE_PART('year', al.date_edition) > 1990
  AND al.prix < 12;

-- 12. Donnez les isbn et titre du (des) album(s) le(s) moins cher(s) édités en 1976 ? [cite: 2471]
SELECT al.isbn, al.titre
FROM bd3.albums al
WHERE DATE_PART('year', al.date_edition) = 1976
  AND al.prix = (
    SELECT MIN(a2.prix)
    FROM bd3.albums a2
    WHERE DATE_PART('year', a2.date_edition) = 1976
);

-- 13. Quels sont les albums qui n'ont qu'un seul auteur ? [cite: 2472]
SELECT al.*
FROM bd3.albums al, bd3.participations p
WHERE al.isbn = p.isbn
GROUP BY al.isbn, al.titre, al.serie, al.editeur, al.date_edition, al.prix
HAVING COUNT(DISTINCT p.auteur) = 1;

-- 14. Donnez, par année, le nombre d'albums édité cette année-là ainsi que le prix moyen de ces albums. [cite: 2473]
-- Les années où aucun album n'a été édité ne doivent pas apparaître. [cite: 2474]
SELECT DATE_PART('year', al.date_edition) AS annee_edition,
       COUNT(*) AS nb_albums,
       AVG(al.prix) AS prix_moyen
FROM bd3.albums al
WHERE al.date_edition IS NOT NULL
GROUP BY DATE_PART('year', al.date_edition);

-- 15. Donnez les dessinateurs qui ont travaillé sur des albums de plusieurs séries. [cite: 2475]
SELECT au.*
FROM bd3.auteurs au, bd3.participations p, bd3.albums al
WHERE au.id_auteur = p.auteur
  AND p.isbn = al.isbn
  AND p.role = 'd'
GROUP BY au.id_auteur, au.nom, au.e_mail
HAVING COUNT(DISTINCT al.serie) > 1;

-- 16. Donnez la date d'édition la plus ancienne parmi les albums édités chez "Dargaud". [cite: 2476]
SELECT MIN(al.date_edition) AS date_min
FROM bd3.albums al, bd3.editeurs e
WHERE al.editeur = e.id_editeur
  AND e.nom = 'Dargaud';

-- 17. Donnez le(s) albums le(s) plus ancien(s) parmi ceux édités chez "Dargaud". [cite: 2477]
SELECT al.*
FROM bd3.albums al, bd3.editeurs e
WHERE al.editeur = e.id_editeur
  AND e.nom = 'Dargaud'
  AND al.date_edition = (
    SELECT MIN(a2.date_edition)
    FROM bd3.albums a2, bd3.editeurs e2
    WHERE a2.editeur = e2.id_editeur
      AND e2.nom = 'Dargaud'
);

-- 18. Donnez, pour chaque album, édité en Belgique ou en France, ayant au moins un auteur répertorié, son isbn, son titre et le nombre d'auteurs intervenant dans cet album. [cite: 2478]
-- Classez les albums par ordre décroissant du nombre d'auteurs. [cite: 2479]
SELECT al.isbn, al.titre, COUNT(DISTINCT p.auteur) AS nb_auteurs
FROM bd3.albums al, bd3.editeurs e, bd3.participations p
WHERE al.editeur = e.id_editeur
  AND al.isbn = p.isbn
  AND (e.pays = 'be' OR e.pays = 'fr')
GROUP BY al.isbn, al.titre
ORDER BY nb_auteurs DESC;

-- 19. Donnez, pour chaque paire d'albums de même titre, les isbn, date d'édition et le titre. [cite: 2480]
SELECT a1.isbn, a1.date_edition, a1.titre, a2.isbn, a2.date_edition, a2.titre
FROM bd3.albums a1, bd3.albums a2
WHERE a1.titre = a2.titre
  AND a1.isbn < a2.isbn;

-- 20. Donnez, pour chaque auteur dont l'adresse e-mail contient "@yahoo" et ayant participé à plusieurs albums, son identifiant, son nom, son adresse e-mail, son nombre d'albums et le nombre d'éditeurs ayant publié au moins un de ses albums. [cite: 2481]
SELECT au.id_auteur, au.nom, au.e_mail,
       COUNT(DISTINCT p.isbn) AS nb_albums,
       COUNT(DISTINCT al.editeur) AS nb_editeurs
FROM bd3.auteurs au, bd3.participations p, bd3.albums al
WHERE au.id_auteur = p.auteur
  AND p.isbn = al.isbn
  AND au.e_mail LIKE '%@yahoo%'
GROUP BY au.id_auteur, au.nom, au.e_mail
HAVING COUNT(DISTINCT p.isbn) > 1;

-- 21. Pour chaque auteur, donnez son identifiant, son nom et le nombre d'albums pour lesquels il est le seul auteur. [cite: 2482]
-- Il ne faut pas prendre les auteurs n'ayant aucun album pour lequel il est le seul auteur. [cite: 2483]
SELECT au.id_auteur, au.nom, COUNT(DISTINCT p.isbn) AS nb_albums_seul
FROM bd3.auteurs au, bd3.participations p
WHERE au.id_auteur = p.auteur
  AND p.isbn IN (
    SELECT p2.isbn
    FROM bd3.participations p2
    GROUP BY p2.isbn
    HAVING COUNT(DISTINCT p2.auteur) = 1
)
GROUP BY au.id_auteur, au.nom;
