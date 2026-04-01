CREATE SCHEMA exo2_1
go

CREATE TABLE exo2_1.proprietaires(
	id_proprietaire	int			identity (1,1)	primary key,
	prenom			varchar(20)		not null,
	nom				varchar(30)		not null,
	tel				varchar(20)		not null,
	mail			varchar(35)		not null,
	adresse			varchar(60)		not null);
go

create table exo2_1.kots(
	id_kot			int				identity (1,1)	primary key,
	superficie		int				not null,
	loyer			int				not null,
	duree_contrat	int				not null,
	caution			int				not null,
	proprietaire_FK	int				not null);
go

ALTER TABLE exo2_1.kots ADD adresse varchar(30) not null
go


ALTER TABLE exo2_1.kots
ADD CONSTRAINT FK_Contrainteproprio
FOREIGN KEY (proprietaire_FK)
REFERENCES exo2_1.proprietaires (id_proprietaire);
go

create table exo2_1.etudiants(
	numero_inscription		int				primary key,
	tel						varchar(20)		not null,
	mail					varchar(35)		not null,
	adresse					varchar(60)		not null);
go

create table exo2_1.visites(
	id_visite		int				identity (1,1)	primary key,
	date_visite		date			not null,
	kot_FK			int				not null,
	etudiant_FK		int				not null);
go

ALTER TABLE exo2_1.visites 
ADD CONSTRAINT FK_Contraintekots
FOREIGN KEY (kot_FK)
REFERENCES exo2_1.kots (id_kot);
go

ALTER TABLE exo2_1.visites 
ADD CONSTRAINT FK_Contrainteetudiant
FOREIGN KEY (etudiant_FK)
REFERENCES exo2_1.etudiants (numero_inscription);
go

create table exo2_1.baux(
	id_bail					int				identity (1,1)	primary key,
	date_signature			date			not null,
	date_debut_bail			date			not null,
	date_etat_lieu_entree 	date			not null,
	date_etat_lieu_sortie	date			,
	numero_compte			varchar(20)		,
	visite_FK				int				not null);
go

ALTER TABLE exo2_1.baux 
ADD CONSTRAINT FK_Contraintevisites
FOREIGN KEY (visite_FK)
REFERENCES exo2_1.visites (id_visite);
go

INSERT INTO exo2_1.proprietaires (nom,prenom,adresse,tel,mail)
	VALUES('fondimare','nathan', 'ici', '000444222','adress@mail.com')

INSERT INTO exo2_1.proprietaires (nom,prenom,adresse,tel,mail)
	VALUES('nom2','romain', 'avenue de labas', '999966663333','mail@mclavier.fr')

INSERT INTO exo2_1.proprietaires (nom,prenom,adresse,tel,mail)
	VALUES('riche','paul', 'rue de la paix', '9999999','riche@mclavier.fr')
go


INSERT INTO exo2_1.proprietaires (nom,prenom,adresse,tel,mail)
	VALUES('pauvre','paul', 'rue de la paix', '9999999','pauvre@mclavier.fr')
go

SELECT *
FROM exo2_1.proprietaires
go


/*
id_proprietaire	prenom	nom	tel	mail	adresse
1	nathan	fondimare	000444222	adress@mail.com	ici
2	romain	nom2	999966663333	mail@mclavier.fr	avenue de labas
*/

INSERT INTO exo2_1.kots (superficie,loyer,duree_contrat,caution,adresse,proprietaire_FK)
	VALUES(52,700, 12, 2000,'rue de la bas',1)

INSERT INTO exo2_1.kots (superficie,loyer,duree_contrat,caution,adresse,proprietaire_FK)
	VALUES(100,2000, 10, 6000,'chemin de la paix',2)

INSERT INTO exo2_1.kots (superficie,loyer,duree_contrat,caution,adresse,proprietaire_FK)
	VALUES(52,1500, 12, 2000,'rue de la bas',3)

INSERT INTO exo2_1.kots (superficie,loyer,duree_contrat,caution,adresse,proprietaire_FK)
	VALUES(100,3000, 10, 6000,'chemin de la paix',3)

INSERT INTO exo2_1.kots (superficie,loyer,duree_contrat,caution,adresse,proprietaire_FK)
	VALUES(52,600, 12, 2000,'rue de la bas',4)

INSERT INTO exo2_1.kots (superficie,loyer,duree_contrat,caution,adresse,proprietaire_FK)
	VALUES(100,1900, 10, 6000,'chemin de la paix',4)

SELECT *
FROM exo2_1.kots

/*
id_kot	superficie	loyer	duree_contrat	caution	proprietaire_FK	adresse
1	52	700	12	2000	1	rue de la bas
2	100	2000	10	6000	2	chemin de la paix
*/

INSERT INTO exo2_1.etudiants(numero_inscription,adresse,mail,tel)
	VALUES( 202601, 'terrasse d''ici', 'student@mail.etude','888111122')

INSERT INTO exo2_1.etudiants(numero_inscription,adresse,mail,tel)
	VALUES( 202622, 'balcon d''en haut', 'etude@mail.etude','12121212121')

SELECT *
FROM exo2_1.etudiants

/*
numero_inscription	tel	mail	adresse
202601	888111122	student@mail.etude	terrasse d'ici
202622	12121212121	etude@mail.etude	balcon d'en hau
*/

INSERT INTO exo2_1.visites (date_visite, kot_FK, etudiant_FK)
	VALUES('1999-02-21', 1, 202601)

INSERT INTO exo2_1.visites (date_visite, kot_FK, etudiant_FK)
	VALUES('2025-04-11', 2, 202622)

SELECT *
FROM exo2_1.visites

/*
id_visite	date_visite	kot_FK	etudiant_FK
1	1999-02-21	1	202601
2	2025-04-11	2	202622
*/


INSERT INTO exo2_1.baux(date_signature,date_debut_bail,date_etat_lieu_entree,date_etat_lieu_sortie,numero_compte,visite_FK)
	VALUES('2025-05-09', '2025-09-01','2025-08-09',null,null,1)

INSERT INTO exo2_1.baux(date_signature,date_debut_bail,date_etat_lieu_entree,date_etat_lieu_sortie,numero_compte,visite_FK)
	VALUES('2025-06-02', '2025-10-30','2025-07-15','2025-07-16','BEnumero',2)

SELECT *
FROM exo2_1.baux

/*
id_bail	date_signature	date_debut_bail	date_etat_lieu_entree	date_etat_lieu_sortie	numero_compte	visite_FK
1	2025-05-09	2025-09-01	2025-08-09	NULL	NULL	1
2	2025-06-02	2025-10-30	2025-07-15	2025-07-16	BEnumero	2
*/

SELECT ko.id_kot, ko.adresse, ko.loyer, ko.superficie
FROM 
	exo2_1.proprietaires pr, 
	exo2_1.kots ko,
	(
		select superficie, avg(loyer) as loyer_moyen
		from 
			exo2_1.kots
		group by superficie
	) moyen 

WHERE pr.id_proprietaire = ko.proprietaire_FK
and moyen.superficie = ko.superficie and  ko.loyer < loyer_moyen 

---------


---------
with  moyen as (
		select superficie, avg(loyer) as loyer_moyen
		from 
			exo2_1.kots
		group by superficie
)
SELECT ko.id_kot, ko.adresse, ko.loyer, ko.superficie
FROM 
	exo2_1.proprietaires pr, 
	exo2_1.kots ko,
	moyen  m

WHERE pr.id_proprietaire = ko.proprietaire_FK
and m.superficie = ko.superficie and  ko.loyer < m.loyer_moyen 


select superficie, avg(loyer)
from 
	exo2_1.kots
group by superficie

----- =====

SELECT ko.id_kot, ko.adresse, ko.loyer, ko.superficie
FROM 
		exo2_1.proprietaires pr
join	exo2_1.kots ko on  pr.id_proprietaire = ko.proprietaire_FK
join	(
		select superficie, avg(loyer) as loyer_moyen
		from 
			exo2_1.kots
		group by superficie
		) moyen on moyen.superficie = ko.superficie and  ko.loyer < loyer_moyen 

---
select superficie, avg(loyer) as loyer_moyen
from 
	exo2_1.kots
group by superficie

===

SELECT ko.id_kot, ko.adresse, ko.loyer, ko.superficie, pr.nom, pr.prenom
FROM exo2_1.kots ko, exo2_1.proprietaires pr
WHERE ko.proprietaire_FK = pr.id_proprietaire
  AND ko.loyer < (
      SELECT AVG(k2.loyer)
      FROM exo2_1.kots k2
      WHERE k2.superficie = ko.superficie
  );

