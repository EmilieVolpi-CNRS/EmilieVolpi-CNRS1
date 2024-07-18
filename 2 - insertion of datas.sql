
-- ! important ! to do : 
-- import csv https://doi.org/10.5281/zenodo.12773349 as a new table "rne_integration"

select * from "BREF".rne_integration
--1374720

select distinct 
code_departement,
code_insee_commune,
case
	when length(code_departement) = 1 then '0'||code_departement||trim(to_char(code_insee_commune, '000'))
	else code_departement||trim(to_char(code_insee_commune, '000'))
	end,
	libelle_commune
from "BREF".rne_integration
order by code_departement, code_insee_commune;
--36953

CREATE OR REPLACE FUNCTION "BREF".remplitRegionActif() RETURNS integer AS $$
DECLARE
	depart record;
	min_region varchar;
	lib_region varchar;
	lib_departement varchar;
BEGIN
    --pour les 65 departements/régions doublons on récupère la région min et on la passe à Actif false
	FOR depart IN
		select code_departement, count(code_region) from
		(select distinct code_departement, code_region, libelle_region from "BREF".rne_integration 
		where code_region is not null and code_departement is not null
		order by code_departement) a
		group by code_departement
		having count(code_region) > 1
	LOOP
		select min(code_region) into min_region from "BREF".rne_integration where code_departement = depart.code_departement;
		select "NomTerritoire" into lib_region from "BREF"."Territoire" where "CodeTerritoire" =  min_region;
		select "NomTerritoire" into lib_departement from "BREF"."Territoire" where "CodeTerritoire" =  depart.code_departement;
		RAISE NOTICE 'departement : % % - region_min : % %',depart.code_departement, lib_departement, min_region, lib_region;
		
		update "BREF"."Territoire" set "Actif" = false where "CodeTerritoire" = min_region;
	end loop;
	return 1;
END;
$$ LANGUAGE plpgsql;

select * from "BREF"."Territoire"

select code_departement, count(id_departement) from
(select distinct id_departement, code_departement 
from "BREF".rne_integration 
where id_departement is not null and code_departement is not null
order by id_departement) a
group by code_departement
having count(id_departement) > 1
-- 75, 78, 04, 22, 64

-- ** départements

select distinct code_departement 
from "BREF".rne_integration 
where code_departement is not null
order by code_departement
--122

select distinct id_departement
from "BREF".rne_integration 
where id_departement is not null
order by id_departement
--124 -> 127

select distinct code_departement, id_departement
from "BREF".rne_integration 
where code_departement is not null
order by code_departement
--124 doublon code_departement 75, 78
-- -> 127 doublon id diff 04, 22, 64, 75, 78

select distinct code_departement, id_departement, libelle_departement
from "BREF".rne_integration 
where code_departement is not null
order by code_departement
--127 doublon code_departement 04, 22, 64

--insertion des départements
update "BREF"."rne_integration" set id_departement = '1970_04' where libelle_departement = 'BASSES ALPES';
update "BREF"."rne_integration" set id_departement = '1990_21' where libelle_departement = 'COTES DU NORD';
update "BREF"."rne_integration" set id_departement = '1969_63' where libelle_departement = 'BASSES PYRENEES';

insert into "BREF"."Territoire" ("CodeTerritoire", "IdTerritoire", "NomTerritoire", "TypeTerritoire", "Actif")
select distinct code_departement, id_departement, libelle_departement, 'Departement', true from "BREF".rne_integration 
where code_departement is not null
order by id_departement
--127

select * from "BREF"."Territoire" where "TypeTerritoire" = 'Departement';
--127

update "BREF"."Territoire" set "Actif" = false where "NomTerritoire" in ('BASSES ALPES', 'COTES DU NORD', 'BASSES PYRENEES')
--3

select * from "BREF"."Territoire" where "TypeTerritoire" = 'Departement' and "Actif" = true
--124


-- ** cantons
insert into "BREF"."Territoire" ("IdTerritoire", "CodeTerritoire", "NomTerritoire", "TypeTerritoire")
select distinct id_canton||'-'||code_canton, code_canton, libelle_canton, 'Canton' from "BREF".rne_integration 
where id_canton is not null
--5873


--inclusion canton dans département
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") 
select distinct id_canton||'-'||code_canton, id_departement from "BREF".rne_integration 
where code_canton is not null
--5873

	
-- ** epci
select distinct numero_siren, libelle_epci
from "BREF".rne_integration 
where libelle_epci is not null
order by libelle_epci
--3166 -> 3183

--insertion epci
insert into "BREF"."Territoire" ("IdTerritoire", "NomTerritoire", "TypeTerritoire")
select distinct numero_siren, libelle_epci, 'EPCI' from "BREF".rne_integration 
where libelle_epci is not null and numero_siren is not null
order by numero_siren
--3166 -> 3183 EPCI différents
		
--insertion departementEPCI
insert into "BREF"."Territoire" ("IdTerritoire", "NomTerritoire", "CodeTerritoire", "TypeTerritoire")
select distinct '0'||id_departement_epci, id_departement_epci, code_departement_epci, 'Département EPCI' from "BREF".rne_integration 
where id_departement_epci is not null 
--102

select distinct numero_siren, libelle_epci, id_departement_epci
from "BREF".rne_integration where id_departement_epci is not null and numero_siren is not null order by libelle_epci
--3183 couplés departementEPCI / EPCI : pas de doublon
 
--inclusion departementEPCI dans EPCI
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") 
select distinct '0'||id_departement_epci, numero_siren
from "BREF".rne_integration 
where id_departement_epci is not null and numero_siren is not null
--3183

-- ** insertions communes
select distinct code_insee_commune, libelle_commune
from "BREF".rne_integration
--36 793 : le champ code_insee_commune n'est pas le code insee mais uniquement le code commune !

select distinct case
	when length(code_departement) = 1 then '0'||code_departement||trim(to_char(code_insee_commune, '000'))
	else code_departement||trim(to_char(code_insee_commune, '000'))
	end,
	libelle_commune, 'Commune' from "BREF".rne_integration 
where code_insee_commune is not null
--36830

--auto incrémentation de "IdTerritoire"
--drop sequence id_territoire_seq cascade;
CREATE SEQUENCE "BREF".id_territoire_seq;
SELECT setval('"BREF".id_territoire_seq', 30000); --parce qu'on a déjà inclu des territoires qui n'avaient pas d'id auto-increment
ALTER TABLE "BREF"."Territoire" ALTER COLUMN "IdTerritoire" SET DEFAULT
nextval('"BREF".id_territoire_seq'::regclass);

--insertion commune
insert into "BREF"."Territoire" ("CodeTerritoire", "NomTerritoire", "TypeTerritoire")
select distinct case
	when length(code_departement) = 1 then '0'||code_departement||trim(to_char(code_insee_commune, '000'))
	else code_departement||trim(to_char(code_insee_commune, '000'))
	end,
	libelle_commune, 'Commune' from "BREF".rne_integration 
where code_insee_commune is not null
--36830

select code_insee, count(code_insee) from
	(select distinct case
	when length(code_departement) = 1 then '0'||code_departement||trim(to_char(code_insee_commune, '000'))
	else code_departement||trim(to_char(code_insee_commune, '000')) 
	end as code_insee,
	libelle_commune, 'Commune' from "BREF".rne_integration 
	where code_insee_commune is not null) a --36 830
group by code_insee
having count(code_insee) > 1
--13 doublons

select code_insee_commune, code_departement, libelle_commune, date_min,
case
	when length(code_departement) = 1 then '0'||code_departement||trim(to_char(code_insee_commune, '000'))
	else code_departement||trim(to_char(code_insee_commune, '000')) 
	end as code_insee
	from
(select distinct code_insee_commune, code_departement, libelle_commune, min(date_debut_mandat) as date_min from "BREF".rne_integration where 
(code_departement = '1' and code_insee_commune=204) or
(code_departement = '18' and code_insee_commune=185) or
(code_departement = '55' and code_insee_commune=073) or
(code_departement = '56' and code_insee_commune=007) or
(code_departement = '62' and code_insee_commune=160) or
(code_departement = '62' and code_insee_commune=268) or
(code_departement = '62' and code_insee_commune=505) or
(code_departement = '62' and code_insee_commune=560) or
(code_departement = '64' and code_insee_commune=148) or
(code_departement = '81' and code_insee_commune=060) or
(code_departement = '94' and code_insee_commune=048) or
(code_departement = '94' and code_insee_commune=071) or
(code_departement = '95' and code_insee_commune=040)
group by code_insee_commune, code_departement, libelle_commune
order by code_departement, code_insee_commune) a
order by code_departement, code_insee_commune

update "BREF"."Territoire" set "DateLiee" = '14/04/2008' where "CodeTerritoire" = '18185' and "NomTerritoire" = 'MERY ES BOIS';
update "BREF"."Territoire" set "DateLiee" = '11/03/2001' where "CodeTerritoire" = '18185' and "NomTerritoire" = 'PRESLY';
update "BREF"."Territoire" set "DateLiee" = '11/03/2001' where "CodeTerritoire" = '55073' and "NomTerritoire" = 'BRAS SUR MEUSE';
update "BREF"."Territoire" set "DateLiee" = '30/03/2014' where "CodeTerritoire" = '55073' and "NomTerritoire" = 'CHAMPNEUVILLE';
update "BREF"."Territoire" set "DateLiee" = '11/03/2001' where "CodeTerritoire" = '56007' and "NomTerritoire" = 'AURAY';
update "BREF"."Territoire" set "DateLiee" = '06/01/2014' where "CodeTerritoire" = '56007' and "NomTerritoire" = 'PLUMERGAT';
update "BREF"."Territoire" set "DateLiee" = '17/04/2008' where "CodeTerritoire" = '62160' and "NomTerritoire" = 'BAINCTHUN';
update "BREF"."Territoire" set "DateLiee" = '18/03/2001' where "CodeTerritoire" = '62160' and "NomTerritoire" = 'BOULOGNE SUR MER';
update "BREF"."Territoire" set "DateLiee" = '17/04/2008' where "CodeTerritoire" = '62160' and "NomTerritoire" = 'CONDETTE';
update "BREF"."Territoire" set "DateLiee" = '17/04/2008' where "CodeTerritoire" = '62160' and "NomTerritoire" = 'CONTEVILLE LES BOULOGNE';
update "BREF"."Territoire" set "DateLiee" = '17/04/2008' where "CodeTerritoire" = '62160' and "NomTerritoire" = 'EQUIHEN PLAGE';
update "BREF"."Territoire" set "DateLiee" = '17/04/2008' where "CodeTerritoire" = '62160' and "NomTerritoire" = 'HESDIGNEUL LES BOULOGNE';
update "BREF"."Territoire" set "DateLiee" = '17/04/2008' where "CodeTerritoire" = '62160' and "NomTerritoire" = 'HESDIN L ABBE';
update "BREF"."Territoire" set "DateLiee" = '17/04/2008' where "CodeTerritoire" = '62160' and "NomTerritoire" = 'ISQUES';
update "BREF"."Territoire" set "DateLiee" = '17/04/2008' where "CodeTerritoire" = '62160' and "NomTerritoire" = 'NEUFCHATEL HARDELOT';
update "BREF"."Territoire" set "DateLiee" = '17/04/2008' where "CodeTerritoire" = '62160' and "NomTerritoire" = 'OUTREAU';
update "BREF"."Territoire" set "DateLiee" = '17/04/2008' where "CodeTerritoire" = '62160' and "NomTerritoire" = 'SAINT ETIENNE AU MONT';
update "BREF"."Territoire" set "DateLiee" = '17/04/2008' where "CodeTerritoire" = '62160' and "NomTerritoire" = 'SAINT MARTIN BOULOGNE';
update "BREF"."Territoire" set "DateLiee" = '17/04/2008' where "CodeTerritoire" = '62160' and "NomTerritoire" = 'WIMEREUX';
update "BREF"."Territoire" set "DateLiee" = '17/04/2008' where "CodeTerritoire" = '62160' and "NomTerritoire" = 'WIMILLE';
update "BREF"."Territoire" set "DateLiee" = '05/01/2009' where "CodeTerritoire" = '62268' and "NomTerritoire" = 'CARLY';
update "BREF"."Territoire" set "DateLiee" = '05/01/2009' where "CodeTerritoire" = '62268' and "NomTerritoire" = 'COURSET';
update "BREF"."Territoire" set "DateLiee" = '11/03/2001' where "CodeTerritoire" = '62268' and "NomTerritoire" = 'DESVRES';
update "BREF"."Territoire" set "DateLiee" = '05/01/2009' where "CodeTerritoire" = '62268' and "NomTerritoire" = 'DOUDEAUVILLE';
update "BREF"."Territoire" set "DateLiee" = '05/01/2009' where "CodeTerritoire" = '62268' and "NomTerritoire" = 'LONGFOSSE';
update "BREF"."Territoire" set "DateLiee" = '05/01/2009' where "CodeTerritoire" = '62268' and "NomTerritoire" = 'MENNEVILLE';
update "BREF"."Territoire" set "DateLiee" = '05/01/2009' where "CodeTerritoire" = '62268' and "NomTerritoire" = 'SAMER';
update "BREF"."Territoire" set "DateLiee" = '05/01/2009' where "CodeTerritoire" = '62268' and "NomTerritoire" = 'SENLECQUES';
update "BREF"."Territoire" set "DateLiee" = '05/01/2009' where "CodeTerritoire" = '62268' and "NomTerritoire" = 'VIEIL MOUTIER';
update "BREF"."Territoire" set "DateLiee" = '05/01/2009' where "CodeTerritoire" = '62268' and "NomTerritoire" = 'WIERRE AU BOIS';
update "BREF"."Territoire" set "DateLiee" = '11/04/2008' where "CodeTerritoire" = '62505' and "NomTerritoire" = 'LEULINGHEM';
update "BREF"."Territoire" set "DateLiee" = '11/03/2001' where "CodeTerritoire" = '62505' and "NomTerritoire" = 'LEULINGHEN BERNES';
update "BREF"."Territoire" set "DateLiee" = '16/04/2008' where "CodeTerritoire" = '62560' and "NomTerritoire" = 'AMBLETEUSE';
update "BREF"."Territoire" set "DateLiee" = '16/04/2008' where "CodeTerritoire" = '62560' and "NomTerritoire" = 'BEUVREQUEN';
update "BREF"."Territoire" set "DateLiee" = '16/04/2008' where "CodeTerritoire" = '62560' and "NomTerritoire" = 'FERQUES';
update "BREF"."Territoire" set "DateLiee" = '16/04/2008' where "CodeTerritoire" = '62560' and "NomTerritoire" = 'MANINGHEN HENNE';
update "BREF"."Territoire" set "DateLiee" = '18/03/2001' where "CodeTerritoire" = '62560' and "NomTerritoire" = 'MARQUISE';
update "BREF"."Territoire" set "DateLiee" = '16/04/2008' where "CodeTerritoire" = '62560' and "NomTerritoire" = 'RETY';
update "BREF"."Territoire" set "DateLiee" = '16/04/2008' where "CodeTerritoire" = '62560' and "NomTerritoire" = 'RINXENT';
update "BREF"."Territoire" set "DateLiee" = '16/04/2008' where "CodeTerritoire" = '62560' and "NomTerritoire" = 'SAINT INGLEVERT';
update "BREF"."Territoire" set "DateLiee" = '16/04/2008' where "CodeTerritoire" = '62560' and "NomTerritoire" = 'WISSANT';
update "BREF"."Territoire" set "DateLiee" = '01/03/1995' where "CodeTerritoire" = '64148' and "NomTerritoire" = 'BRUGES';
update "BREF"."Territoire" set "DateLiee" = '09/03/2008' where "CodeTerritoire" = '64148' and "NomTerritoire" = 'BRUGES CAPBIS MIFAGET';
update "BREF"."Territoire" set "DateLiee" = '11/03/2001' where "CodeTerritoire" = '81060' and "NomTerritoire" = 'CARMAUX';
update "BREF"."Territoire" set "DateLiee" = '01/01/2014' where "CodeTerritoire" = '81060' and "NomTerritoire" = 'TAIX';
update "BREF"."Territoire" set "DateLiee" = '11/03/2001' where "CodeTerritoire" = '94048' and "NomTerritoire" = 'MAROLLES EN BRIE';
update "BREF"."Territoire" set "DateLiee" = '10/04/2014' where "CodeTerritoire" = '94048' and "NomTerritoire" = 'VILLECRESNES';
update "BREF"."Territoire" set "DateLiee" = '30/03/2014' where "CodeTerritoire" = '94071' and "NomTerritoire" = 'NOISEAU';
update "BREF"."Territoire" set "DateLiee" = '18/03/2001' where "CodeTerritoire" = '94071' and "NomTerritoire" = 'SUCY EN BRIE';
update "BREF"."Territoire" set "DateLiee" = '18/03/2001' where "CodeTerritoire" = '95040' and "NomTerritoire" = 'AVERNES';
update "BREF"."Territoire" set "DateLiee" = '30/03/2014' where "CodeTerritoire" = '95040' and "NomTerritoire" = 'GADANCOURT';

select * from  "BREF"."Territoire" where "CodeTerritoire" in 
('01204',
'18185',
'55073',
'56007',
'62160',
'62268',
'62505',
'62560',
'64148',
'81060',
'94048',
'94071',
'95040')
order by "CodeTerritoire"

select "CodeTerritoire", max("DateLiee") from "BREF"."Territoire" where "CodeTerritoire" in 
('01204',
'18185',
'55073',
'56007',
'62160',
'62268',
'62505',
'62560',
'64148',
'81060',
'94048',
'94071',
'95040')
group by "CodeTerritoire"

update "BREF"."Territoire" set "Actif" = true where "CodeTerritoire" = '64148' and "DateLiee" = '09/03/2008';
update "BREF"."Territoire" set "Actif" = true where "CodeTerritoire" = '62268' and "DateLiee" = '05/01/2009';
update "BREF"."Territoire" set "Actif" = true where "CodeTerritoire" = '62160' and "DateLiee" = '17/04/2008';
update "BREF"."Territoire" set "Actif" = true where "CodeTerritoire" = '94071' and "DateLiee" = '30/03/2014';
update "BREF"."Territoire" set "Actif" = true where "CodeTerritoire" = '18185' and "DateLiee" = '14/04/2008';
update "BREF"."Territoire" set "Actif" = true where "CodeTerritoire" = '95040' and "DateLiee" = '30/03/2014';
update "BREF"."Territoire" set "Actif" = true where "CodeTerritoire" = '62505' and "DateLiee" = '11/04/2008';
update "BREF"."Territoire" set "Actif" = true where "CodeTerritoire" = '81060' and "DateLiee" = '01/01/2014';
update "BREF"."Territoire" set "Actif" = true where "CodeTerritoire" = '55073' and "DateLiee" = '30/03/2014';
update "BREF"."Territoire" set "Actif" = true where "CodeTerritoire" = '62560' and "DateLiee" = '16/04/2008';
update "BREF"."Territoire" set "Actif" = true where "CodeTerritoire" = '56007' and "DateLiee" = '06/01/2014';
update "BREF"."Territoire" set "Actif" = true where "CodeTerritoire" = '94048' and "DateLiee" = '10/04/2014';

update "BREF"."Territoire"
set "Actif" = false
where "TypeTerritoire" = 'Commune'
and "CodeTerritoire" in 
('01204',
'18185',
'55073',
'56007',
'62160',
'62268',
'62505',
'62560',
'64148',
'81060',
'94048',
'94071',
'95040')
and "Actif" is null;

update "BREF"."Territoire" set "DateLiee" = '01/01/2016', "Actif" = true where "IdTerritoire" = '30188';
update "BREF"."Territoire" set "DateLiee" = '06/12/1827' where "IdTerritoire" = '30187';

update "BREF"."Territoire" set "DateLiee" = '01/01/2016', "Actif" = true where "IdTerritoire" = '61122';
	
update "BREF"."Territoire"
set "Actif" = true
where "TypeTerritoire" = 'Commune'
and "Actif" is null;

-- inclusion communes dans départements : ATTENTION NA PAS FONCTIONNE
-- SANS DOUTE A CAUSE DE DATE_MIN DANS LE SELECT
-- ACTION REALISE A POSTERIORI DANS DRIVE > NETTOYAGE DONNEES > STAGES ETE 2021 > 03
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire", "DateDebutInclusion") 
select distinct "Territoire"."IdTerritoire", a.code_departement, date_min from
	(select distinct case
		when length(code_departement) = 1 then '0'||code_departement||trim(to_char(code_insee_commune, '000'))
		else code_departement||trim(to_char(code_insee_commune, '000')) 
		end as code_insee, code_departement, min(date_debut_mandat) as date_min
	from "BREF".rne_integration 
	where numero_siren is not null and code_insee_commune is not null
	group by code_insee, code_departement
	order by code_insee) a
join "BREF"."Territoire" on "Territoire"."CodeTerritoire" = a.code_insee
order by "Territoire"."IdTerritoire"


--inclusion communes dans EPCI
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire", "DateDebutInclusion") 
select distinct "Territoire"."IdTerritoire", a.numero_siren, date_min from
	(select distinct case
		when length(code_departement) = 1 then '0'||code_departement||trim(to_char(code_insee_commune, '000'))
		else code_departement||trim(to_char(code_insee_commune, '000')) 
		end as code_insee, code_insee_commune, numero_siren, libelle_epci, min(date_debut_mandat) as date_min
	from "BREF".rne_integration 
	where numero_siren is not null and code_insee_commune is not null
	group by code_insee, code_insee_commune, numero_siren, libelle_epci
	order by numero_siren) a
join "BREF"."Territoire" on "Territoire"."CodeTerritoire" = a.code_insee
	order by "Territoire"."IdTerritoire"
--51562
	
-- ** circonscriptions européennes
insert into "BREF"."Territoire" ("CodeTerritoire", "NomTerritoire", "TypeTerritoire")
select distinct code_circo_euro, libelle_circo_euro, 'Circonscription Européenne' from "BREF".rne_integration 
where code_circo_euro is not null 
order by code_circo_euro
--9

-- ** régions
insert into "BREF"."Territoire" ("CodeTerritoire", "NomTerritoire", "TypeTerritoire")
select distinct code_region, libelle_region, 'Region' from "BREF".rne_integration 
where code_region is not null
order by code_region
--32

select distinct code_departement, code_region from "BREF".rne_integration 
where code_region is not null and code_departement is not null
order by code_departement
--163

--anciennes régions
update "BREF"."Territoire" set "Actif" = true where "TypeTerritoire" = 'Region';
update "BREF"."Territoire" set "Actif" = false where "TypeTerritoire" = 'Region' and "CodeTerritoire" in ('16','18','20','21','23','25','26','31','41','42','43','52','72','73','74','82','83','41' )

select * from "Territoire" where "TypeTerritoire" = 'Region' --and "Actif" = true
--32

--inclure les departements dans les regions
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") 
select distinct t1."IdTerritoire" as departement, t2."IdTerritoire" as region
	from "BREF"."Territoire" t1
	left join (select distinct code_departement, code_region 
		  from "BREF".rne_integration 
		where code_region is not null and code_departement is not null
		order by code_departement) a --163
	on t1."CodeTerritoire" = a.code_departement
	left join "BREF"."Territoire" t2 on t2."CodeTerritoire" = a.code_region::text
where t1."TypeTerritoire" = 'Departement'-- and t1."Actif" = true
and t2."TypeTerritoire" = 'Region'
order by departement
--137 --> 169

select * from "BREF"."Inclusion"
join "BREF"."Territoire" t1 on "Inclusion"."TerritoireInclu_IdTerritoire" = t1."IdTerritoire"
join "BREF"."Territoire" t2 on "Inclusion"."TerritoireIncluant_IdTerritoire" = t2."IdTerritoire"
where t1."TypeTerritoire" = 'Departement' and t1."Actif" = true
and t2."TypeTerritoire" = 'Region' and t2."Actif" = true
--107
	
--insertion code_circo_legislative
insert into "BREF"."Territoire" ("CodeTerritoire", "NomTerritoire", "TypeTerritoire")
select distinct code_circo_legislative, libelle_circo_legislative, 'Circonscription Legislative' from "BREF".rne_integration 
where code_circo_legislative is not null 
order by code_circo_legislative
--25

-- FRANCE
insert into "BREF"."Territoire" ("NomTerritoire", "TypeTerritoire") values ('France', 'Nation');
	
--ATTENTION CODE COMMUNE DIFFERENTS EN DOMTOM
--ZC -> 97
--https://fr.wikipedia.org/wiki/France_d%27outre-mer


select * from "BREF"."Fonction";
select * from "BREF"."Individu";
select * from "BREF"."Mandat";
select * from "BREF"."PopulationCommune";
select * from "BREF"."Profession";
	
--delete from "BREF"."Fonction";
--delete from "BREF"."Individu";
--delete from "BREF"."Mandat";
--delete from "BREF"."PopulationCommune";
--delete from "BREF"."Profession";

--select * from "BREF".remplit()
	
CREATE OR REPLACE FUNCTION "BREF".remplit() RETURNS integer AS $$
DECLARE
    -- declarations
	stack text;
	mandats record;
	record_individu record;
	record_population record;
	code_territoire varchar;
	id_territoire varchar;
	--code_departement varchar;
	--id_individu integer;
	nom_usage varchar;
	id_population_commune integer;
	id_typemandat integer;
	id_typefonction integer;
	id_nuancepolitique integer;
	id_profession integer;
	id_mandat integer;
	id_fonction integer;
BEGIN
	
	GET DIAGNOSTICS stack = PG_CONTEXT;
  	RAISE NOTICE E'--- Pile d''appel ---\n%', stack;
	
    --pour tout les mandats
	FOR mandats IN
		select code_insee_commune, population_commune, --libelle_commune, 
		id_departement, code_departement, --libelle_departement,
		id_canton, code_canton, numero_siren, code_circo_euro, code_circo_legislative,
		id_universel, id_rne, id_assemblee, id_senat, id_europe, 
		nom_elu, prenom_elu, date_naissance, commune_naissance, departement_naissance, pays_naissance,
		date_deces, code_sexe, nationalite_elu,
		libelle_mandat, date_debut_mandat, date_fin_mandat, motif_fin_mandat, 
		libelle_fonction, date_debut_fonction, date_fin_fonction, motif_fin_fonction,
		code_profession, libelle_profession, nuance_politique,
		sources, corrections_date, correction_autres
		from "BREF".rne_integration	
	LOOP
		
		--territoire et population_commune
		case mandats.libelle_mandat
			when 'CONSEILLER DEPARTEMENTAL' then
				id_territoire = mandats.id_canton||'-'||mandats.code_canton;
				RAISE NOTICE 'Id territoire mandat : %', id_territoire;
			when 'CONSEILLER EPCI' then
				id_territoire = mandats.numero_siren;
				RAISE NOTICE 'Id territoire EPCI : %', id_territoire;
			when 'CONSEILLER MUNICIPAL' then
				if length(mandats.code_departement) = 1 then 
					code_territoire = '0'||mandats.code_departement||trim(to_char(mandats.code_insee_commune, '000'));
				else 
					code_territoire = mandats.code_departement||trim(to_char(mandats.code_insee_commune, '000'));
				end if;
				select "IdTerritoire" into id_territoire from "BREF"."Territoire" where "CodeTerritoire" = code_territoire and "Actif" = true and "TypeTerritoire" = 'Commune';
						
				RAISE NOTICE 'code et Id territoire municipal: % %', code_territoire, id_territoire;				
	 
				--si population commune existe pas : ajout
				select * into record_population from "BREF"."PopulationCommune" where "Territoire_IdTerritoire" = id_territoire
				and EXTRACT(YEAR FROM "DateReference") = EXTRACT(YEAR FROM mandats.date_debut_mandat);
				IF NOT FOUND THEN
					insert into "BREF"."PopulationCommune" ("Population", "DateReference", "Territoire_IdTerritoire")
					values (mandats.population_commune, mandats.date_debut_mandat, id_territoire);
					RAISE NOTICE 'PopulationCommune ajouté :% % %',id_territoire, mandats.date_debut_mandat, mandats.population_commune;
				ELSE
					RAISE NOTICE 'PopulationCommune existante :% % %',id_territoire, mandats.date_debut_mandat, mandats.population_commune;
				END IF;
			
			when 'CONSEILLER REGIONAL' then
				id_territoire = mandats.id_departement;
				RAISE NOTICE 'Id territoire departement (région) : %', id_territoire;
			when 'DEPUTE' then
				 select "IdTerritoire" into id_territoire from "BREF"."Territoire" where "CodeTerritoire" = mandats.code_circo_legislative::text and "TypeTerritoire" = 'Circonscription Legislative';
				 RAISE NOTICE 'Id territoire circo legislative : %', id_territoire;
			when 'PRESIDENT DE LA REPUBLIQUE' then
				select "IdTerritoire" into id_territoire from "BREF"."Territoire" where "NomTerritoire" = 'France';
				RAISE NOTICE 'Id territoire France : %', id_territoire;
			when 'REPRESENTANT AU PARLEMENT EUROPEEN' then
				 select "IdTerritoire" into id_territoire from "BREF"."Territoire" where "CodeTerritoire" = mandats.code_circo_euro::text and "TypeTerritoire" = 'Circonscription Européenne';
				 RAISE NOTICE 'Id territoire circo euro : %', id_territoire;
			when 'SENATEUR' then
				id_territoire = mandats.id_departement;
				RAISE NOTICE 'Id territoire departement (senat) : %', id_territoire;
		End case;

		--si individu nexiste pas : ajout
		select * from "BREF"."Individu" into record_individu where "IdIndividu" = mandats.id_universel;
		IF NOT FOUND THEN
			insert into "BREF"."Individu" ("IdIndividu", "IdEluRNEHisto", "IdEluAssemblee", "IdEluSenat", "IdEurope",
			"NomDeNaissance", "Prenom", "DateNaissance", "CommuneNaissance", "DepartementNaissance", "PaysNaissance",
			"DateDeces", "Sexe", "Nationalite") 
			values (mandats.id_universel, mandats.id_rne, mandats.id_assemblee, 
					mandats.id_senat, mandats.id_europe, 
					mandats.nom_elu, mandats.prenom_elu, mandats.date_naissance, 
					mandats.commune_naissance, mandats.departement_naissance, mandats.pays_naissance,
					mandats.date_deces, mandats.code_sexe, mandats.nationalite_elu);
			--commit;
			RAISE NOTICE 'individu ajouté :%',mandats.id_universel;
		ELSE 
			RAISE NOTICE 'individu existant :%',mandats.id_universel;
		END IF;
		
		--nuance politique
		IF mandats.nuance_politique != '' THEN
			 select "IdNuancePolitique" into id_nuancepolitique from "BREF"."NuancePolitique" where "NuancePolitique" = mandats.nuance_politique;
		END IF;
		
		--profession
		IF mandats.libelle_profession != '' THEN
			 select "CodeProfession" into id_profession from "BREF"."Profession" where "LibelleProfession" = mandats.libelle_profession;
		END IF;
		
		--type_mandat
		 select "IdTypeMandat" into id_typemandat from "BREF"."TypeMandat" where "TypeMandat" = mandats.libelle_mandat;
	
		--insertion mandat
		INSERT INTO "BREF"."Mandat" ("TypeDuMandat_IdTypeMandat", "DateDebutMandat", "DateFinMandat", "MotifFinMandat",
			"Elu_IdIndividu", "NomDUsageIndividu","Territoire_IdTerritoire", "IdNuancePolitique", "IdProfession", "Sources", "CorrectionsDate", "CorrectionsAutres")
			values
			(id_typemandat, mandats.date_debut_mandat, mandats.date_fin_mandat, mandats.motif_fin_mandat, 
			mandats.id_universel, mandats.nom_elu, id_territoire, id_nuancepolitique, id_profession, mandats.sources, mandats.corrections_date, mandats.correction_autres);
				
		--commit;
				
		--id_mandat inséré
		id_mandat = currval('"BREF".id_mandat_seq');
		--SELECT last_value into id_mandat FROM "Mandat"_"IdMandat"_"seq";
		
		RAISE NOTICE 'mandat inséré :%',id_mandat;
		
		--fonction
		if mandats.libelle_fonction != '' then
		
			--type_fonction
			select "IdTypeFonction" into id_typefonction from "BREF"."TypeFonction" where "TypeFonction" = mandats.libelle_fonction;
			
			--insertion fonction
			insert into "BREF"."Fonction" ("DateDebutFonction", "DateFinFonction", "IdMandat", "MotifFinFonction", "TypeDeFonction_IdTypeFonction") 
			values (mandats.date_debut_fonction, mandats.date_fin_fonction, id_mandat, mandats.motif_fin_fonction, id_typefonction);
			
			--commit;
			
			--id_fonction inséré
			id_fonction = currval('"BREF".id_fonction_seq');
			RAISE NOTICE 'fonction inséré :%',id_fonction;
		end if;
	end loop;
	return 1;
END;
$$ LANGUAGE plpgsql;

