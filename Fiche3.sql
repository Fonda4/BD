/* 1. Donnez la liste des albums, avec, pour chacun d'eux, l'isbn,
   le titre, le scénariste, le dessinateur et l’identifiant de son éditeur. */
--requete 1
SELECT al.titre, al.scenariste, ed.id_editeur, al.dessinateur
FROM bd2.editeurs ed, bd2.albums al
WHERE al.editeur = id_editeur;

/* 2. Donnez la liste des albums, avec, pour chacun d'eux, l'isbn, le titre, le scénariste,
   le dessinateur et le nom de son éditeur. */
--requete 2
SELECT al.titre, al.scenariste, ed.nom, al.dessinateur
FROM bd2.editeurs ed, bd2.albums al
WHERE al.editeur = id_editeur;
/* 3. Donnez la liste des albums (isbn, titre et nom de l'éditeur) dont l'éditeur est belge. */
--requete 3
SELECT  al.isbn,al.titre,ed.nom
FROM bd2.editeurs ed, bd2.albums al
WHERE al.editeur = id_editeur AND ed.pays = 'be';

/* 4. Donnez la liste des albums dont l'éditeur est belge
   sans la condition de jointure (isbn, titre et nom de l'éditeur). Que constatez-vous ? */
--requete 4
SELECT  al.isbn,al.titre,ed.nom
FROM bd2.editeurs ed, bd2.albums al
WHERE ed.pays = 'be';

/* 5. Quels sont les albums (isbn et titre) de la série « Astérix »
   qui n'ont pas été édités chez « Dargaud » ? */
--requete 5
SELECT  al.isbn,al.titre
FROM bd2.editeurs ed, bd2.albums al
WHERE al.editeur = id_editeur AND al.serie = 'Astérix' AND (ed.nom <> 'Dargaud');
/* 6. Quels sont les éditeurs (id et nom)
   qui ont édité en 1999 des livres coûtant au moins 10 euros ? */
SELECT DISTINCT ed.nom, ed.id_editeur
FROM bd2.editeurs ed, bd2.albums al
WHERE al.editeur = id_editeur AND al.prix >= 10 AND date_part('Year', al.date_edition) = 1999;

/* 7. Chez quel(s) éditeur(s) (id et nom) « Uderzo » a-t-il publié des albums
   (en tant que scénariste, dessinateur ou coloriste) ? */
SELECT DISTINCT ed.nom, ed.id_editeur
FROM bd2.editeurs ed, bd2.albums al
WHERE al.editeur = id_editeur AND ('Uderzo' = al.scenariste  OR 'Uderzo' = al.dessinateur OR 'Uderzo' = al.coloriste);
/* 8. Quels sont les éditeurs (id et nom) localisés ailleurs qu'en Belgique
   ou pour lequel le pays n'est pas précisé ? */

SELECT DISTINCT  id_editeur,nom
FROM bd2.editeurs
WHERE pays != 'be' OR pays IS NULL;
/* 9. Quels sont les albums qui ont été édités en Belgique ou en France,
   et qui ne sont ni des albums de la série « Tintin », ni des albums de la série « Astérix » ? */
--requete 9
    SELECT al.*
    FROM bd2.albums al ,bd2.editeurs ed
    WHERE (al.editeur = ed.id_editeur) AND (ed.pays = 'fr' OR ed.pays ='be') AND ((al.serie <> 'Tintin' AND al.serie <> 'Astérix') OR al.serie IS NULL);
/* 10. Quels sont les dessinateurs qui ont été édités par « Dupuis » ?
   Affichez-les en ordre alphabétique. */
--requete 10
    SELECT DISTINCT al.dessinateur
    FROM bd2.albums al ,bd2.editeurs ed
    WHERE ed.nom = 'Dupuis' AND (al.editeur = ed.id_editeur) AND al.dessinateur IS NOT NULL
    ORDER BY al.dessinateur ASC;

/* 11. Donnez la liste des albums édités par « Dupuis » entre 1990 et 2000 (bornes incluses),
   en affichant pour chacun son isbn, son titre, son dessinateur et sa date d’édition.
   Triez le tout par dessinateur. Pour chaque dessinateur,
   les albums doivent être rangés en ordre chronologique. */
--requete 11
    SELECT al.isbn, al.titre, al.dessinateur,al.date_edition
    FROM bd2.albums al ,bd2.editeurs ed
    WHERE ed.nom = 'Dupuis' AND (al.editeur = ed.id_editeur) AND date_edition BETWEEN ( '1990-01-01' AND '2000-01-01')
    ORDER BY al.dessinateur ASC, date_edition ASC ;

/* 12. Chez quels éditeurs (id et nom) y a-t-il des albums pour lesquels aucun auteur n'est fourni ? */

/* 13. Y a-t-il des albums pour lesquels le nom de l'éditeur est le même que celui de la série ? Donnez, pour ces albums, leur isbn et leur titre. */

/* 14. Donnez le nom des éditeurs qui portent le même nom qu’au moins un auteur. */

/* 15. Quelle est la date d’édition du dernier album édité en octobre 2013 ? */

/* 16. Combien y a-t-il d'albums édités en Belgique dont le dessinateur et le scénariste sont des personnes différentes ? */

/* 17. Quelle est la date d'édition la plus ancienne pour les albums édités chez « Casterman » ? */

/* 18. Quel est le prix moyen des albums édités par des éditeurs français ? */

/* 19. Si je n'ai que 5 euros en poche, quelle est la date d'édition de l'album le plus ancien que je puisse acheter ? */

/* 20. Combien d'albums n'ont ni scénariste, ni dessinateur, ni coloriste mentionné ? */

/* 21. Combien dois-je débourser pour acheter tous les albums dont l’éditeur est belge et coûtant moins de 8 euros ? Et combien d'albums achèterai-je ainsi ? Quel sera leur prix moyen ? */

/* 22. Combien d'années « Franquin » a-t-il écrit ? */

/* 23. Oscar a reçu pour son anniversaire l’album « Le mystère de la grande pyramide » dont l’isbn est 2-87097-008-0. Malheureusement, il l’a déjà. Heureusement il peut l’échanger contre n’importe quel autre album du même prix mais dont le titre est différent. Contre quels albums peut-il l’échanger ? */