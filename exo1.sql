drop schema exo1
go


create schema exo1
go
create table exo1.client(
	numero_client	int				identity (1,1)	primary key,
	prenom			varchar(20)		not null,
	nom				varchar(30)		not null,
	tel				varchar(20)		not null,
	mail			varchar(35)		not null,
	remarque		varchar(120)	);
go

drop table exo1.prestation_effectuee
go
drop table exo1.rendez_vous
go


create table exo1.rendez_vous(
	id_rdv			int				identity(1,1)	primary key,
	date_heure_debut date		not null,
	duree			int				not null,
	FK_client		int				not null);
go


ALTER TABLE exo1.rendez_vous
ADD CONSTRAINT FK_ContrainteClient
FOREIGN KEY (FK_client)
REFERENCES exo1.client (numero_client);
go

create table exo1.prestation(
	id_prest	int					identity (1,1) primary key,
	prix		int					not null,
	nom			varchar(30)			not null unique)
go

create table exo1.prestation_effectuee(
	FK_id_prest			int				not null,
	FK_id_rdv			int				not null, 
	prix_tot			int				not null,
	quantite			int				not null,
	constraint PK_prest_effectue primary key (FK_id_prest, FK_id_rdv));
go

ALTER TABLE exo1.prestation_effectuee
ADD CONSTRAINT FK_Contrainteprest
FOREIGN KEY (FK_id_prest)
REFERENCES exo1.prestation (id_prest);
go

ALTER TABLE exo1.prestation_effectuee
ADD CONSTRAINT FK_Contrainterdv
FOREIGN KEY (FK_id_rdv)
REFERENCES exo1.rendez_vous (id_rdv);
go


insert into exo1.client(prenom,nom,tel,mail,remarque)
	values('nathan','fondimare','0000000','mail@truc','truc pas important')

insert into exo1.client(prenom,nom,tel,mail)
	values('romain','dondimare','0101010','truc@maail')

Select *
from exo1.client

/*
numero_client	prenom	nom	tel	mail	remarque
1	nathan	fondimare	0000000	mail@truc	truc pas important
2	romain	dondimare	0101010	truc@maail	NULL
*/


insert into exo1.rendez_vous(date_heure_debut,duree,FK_client)
	values('1999-02-21', 60,4)

select *
from exo1.rendez_vous

Select CONVERT (datetime,'1999-02-21')

select GETDATE()

/*id_rdv	date_heure_debut	duree	FK_client
1	1999-02-21	60	3
3	1999-02-21	60	4
*/


insert into exo1.prestation( prix,nom)	
	values(100,'shampoing')

insert into exo1.prestation( prix,nom)	
	values(150,'brushing')

	select *
	from exo1.prestation

	/*
	id_prest	prix	nom
	1	100	shampoing
	2	150	brushing
	*/

insert into exo1.prestation_effectuee(FK_id_prest, FK_id_rdv, prix_tot,quantite)
	values(1,1, 200,1)

insert into exo1.prestation_effectuee(FK_id_prest, FK_id_rdv, prix_tot,quantite)
	values(2,3, 120,2)

select * 
from exo1.prestation_effectuee


select *
from exo1.prestation_effectuee pr, exo1.rendez_vous rdv
where pr.FK_id_rdv = rdv.id_rdv


select DATEPART(month,rdv.date_heure_debut) as mois, SUM(pr.prix_tot) as total
from exo1.prestation_effectuee pr, exo1.rendez_vous rdv
where pr.FK_id_rdv = rdv.id_rdv and DATEPART(yy,rdv.date_heure_debut) = 1999
group by DATEPART(month,rdv.date_heure_debut)
order by total desc

------
select	DATEPART(month,rdv.date_heure_debut) as mois, 
		SUM(pr.prix_tot) as total
from 
		exo1.prestation_effectuee pr, 
		exo1.rendez_vous rdv
where 
		pr.FK_id_rdv = rdv.id_rdv 
and		DATEPART(yy,rdv.date_heure_debut) = 1999
group by 
		DATEPART(month,rdv.date_heure_debut)
order by 
		total desc

		
select	DATEPART(month,rdv.date_heure_debut) as mois, 
		SUM(pr.prix_tot) as total
from 
		exo1.prestation_effectuee pr
join 	exo1.rendez_vous rdv  on pr.FK_id_rdv = rdv.id_rdv 
where 
		DATEPART(yy,rdv.date_heure_debut) = 1999
group by 
		DATEPART(month,rdv.date_heure_debut)
order by 
		total desc
