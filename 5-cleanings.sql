
-- *********** Cantons ************


----------- un territoire ayant pour nom 'C' -----------
select * from "BREF"."Territoire" where "NomTerritoire" = 'C'

--deux mandats sont liés à ce territoire
select * from "BREF"."Mandat" where "Territoire_IdTerritoire" = '248900490'
--IdMandat,"TypeDuMandat_IdTypeMandat","DateDebutMandat","DateFinMandat","MotifFinMandat","Elu_IdIndividu","NomDUsageIndividu","Territoire_IdTerritoire","IdNuancePolitique","IdProfession","Sources","CorrectionsDate","CorrectionsAutres"
--8676185,3,"2008-03-16","2014-03-22","FM","RNE_0042376","LEGRAND","248900490",20,91,"RNE",True,True
--8685135,3,"2001-03-18","2008-03-15","FM","RNE_0042376","LEGRAND","248900490",20,91,"RNE",True,True

--recherche dans csv sortie nettoyage/traitement RNE Histo
--identique

--cette commune est dans la CC DE PUISAYE-FORTERRE, déjà présente dans les territoires
-- on modifier le territoire de ces deux mandats et on supprime le territoire 'C'
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '200067130'
where "IdMandat" in (8676185, 8685135);
delete from "BREF"."Inclusion" where "TerritoireIncluant_IdTerritoire" = '248900490';
delete from "BREF"."Territoire" where "IdTerritoire" = '248900490';


------------- doublons cantons -------------

SELECT "NomTerritoire", count("NomTerritoire")
FROM "BREF"."Territoire" 
where "TypeTerritoire" = 'Canton'
and "Actif" is null
GROUP BY ("NomTerritoire")
Having COUNT("NomTerritoire")>1;
--882 Canton ( le meme nomTerritoire/TypeTerritoire mais codeTerritoire different)

-- il y a eu un redécoupage des cantons en 2014, du coup tous ces cantons en doublon ont à chaque fois : 
-- - un vieux canton d'avant 2014 - qu'il faut garder pour lier les mandats d'avant 2014 - mais qu'il faut passer en Actif = 'non' avec DateLiee = '01/03/2014' (date à laquelle a eu lieu le redécoupage)
-- - un nouvean canton qu'il faut passer en Actif = 'oui'

-- requete pour voir les cantons à passer à Actif = 'oui'
SELECT "IdTerritoire", min("DateDebutMandat")
FROM "BREF"."Territoire" 
join "BREF"."Mandat" on "BREF"."Mandat"."Territoire_IdTerritoire" = "BREF"."Territoire"."IdTerritoire"
where "TypeTerritoire" = 'Canton'
and "DateDebutMandat" > '01/03/2014'
and "NomTerritoire" in 
	(
		SELECT "NomTerritoire" from
		(
		SELECT "NomTerritoire", count("NomTerritoire")
		FROM "BREF"."Territoire" 
		where "TypeTerritoire" = 'Canton'
		and "Actif" is null
		GROUP BY ("NomTerritoire")
		Having COUNT("NomTerritoire")>1
		)A
	)
group by "IdTerritoire"
--905

-- -> il y a 23 cas particuliers à traiter à la main : des nouveaux mandats qui ont été mis sur l'ancien canton
select left("IdTerritoire", position('-' in "IdTerritoire")-1) as "txt", count(*) from 
	(
	SELECT "IdTerritoire", min("DateDebutMandat") as "DateMinDebutMandat"
	FROM "BREF"."Territoire" 
	join "BREF"."Mandat" on "BREF"."Mandat"."Territoire_IdTerritoire" = "BREF"."Territoire"."IdTerritoire"
	where "TypeTerritoire" = 'Canton'
	and "DateDebutMandat" > '01/03/2014'
	and "NomTerritoire" in 
		(
			SELECT "NomTerritoire" from
			(
			SELECT "NomTerritoire", count("NomTerritoire")
			FROM "BREF"."Territoire" 
			where "TypeTerritoire" = 'Canton'
			and "Actif" is null
			GROUP BY ("NomTerritoire")
			Having COUNT("NomTerritoire")>1
			)A
		)
	group by "IdTerritoire"
	)B
group by "txt"
having count(*) > 1
--31

--on traite les cas un par un
select * from "BREF"."Territoire"
 join "BREF"."Mandat" on "BREF"."Mandat"."Territoire_IdTerritoire" = "BREF"."Territoire"."IdTerritoire"
 where "IdTerritoire" like (
 '06_17%')
'07_9%'
'10_14%',
'14_20%',
'14_40%',
'19_19%',
'19_51%',
'2B_13%',
'2B_2%',
'49_18%',
'49_19%',
'49_27%',
'49_29%',
'51_32%',
'55_14%',
'56_31%',
'56_38%',
'61_8%',
'62_43%',
'62_47%',
'62_50%',
'62_52%',
'63_12%',
'83_13%',
'85_17%',
'86_10%',
'86_11%',
'90_15%',
'91_12%',
'ZD_34%',
'ZD_6%')

-- corrections cas particuliers
update "BREF"."Mandat"
set "Territoire_IdTerritoire" = '06_17-10'
where "IdMandat" = 8688926;

update "BREF"."Mandat"
set "Territoire_IdTerritoire" = '07_9-5'
where "IdMandat" = 8689013;

update "BREF"."Mandat"
set "Territoire_IdTerritoire" = '2B_13-7'
where "IdMandat" = 8691184;

update "BREF"."Mandat"
set "Territoire_IdTerritoire" = '49_18-8'
where "IdMandat" = 8693223;

update "BREF"."Mandat"
set "Territoire_IdTerritoire" = '49_19-9'
where "IdMandat" = 8693214;

update "BREF"."Mandat"
set "Territoire_IdTerritoire" = '49_27-13'
where "IdMandat" = 8693179;

update "BREF"."Mandat"
set "Territoire_IdTerritoire" = '49_29-14'
where "IdMandat" = 8693180;

update "BREF"."Mandat"
set "Territoire_IdTerritoire" = '55_14-9'
where "IdMandat" = 8693811;

update "BREF"."Mandat"
set "Territoire_IdTerritoire" = '61_8-6'
where "IdMandat" = 8694538;

update "BREF"."Mandat"
set "Territoire_IdTerritoire" = '62_43-21'
where "IdMandat" = 8694664;

update "BREF"."Mandat"
set "Territoire_IdTerritoire" = '62_47-22'
where "IdMandat" = 8694692;

update "BREF"."Mandat"
set "Territoire_IdTerritoire" = '62_50-24'
where "IdMandat" = 8694667;

update "BREF"."Mandat"
set "Territoire_IdTerritoire" = '62_52-25'
where "IdMandat" = 8694663;

update "BREF"."Mandat"
set "Territoire_IdTerritoire" = '86_10-5'
where "IdMandat" = 8697009;

update "BREF"."Mandat"
set "Territoire_IdTerritoire" = '86_11-6'
where "IdMandat" = 8697012;

update "BREF"."Mandat"
set "Territoire_IdTerritoire" = '90_15-7'
where "IdMandat" = 8697365;

update "BREF"."Territoire" 
set "Actif" = false, "DateLiee" = '01/03/2014'
where "IdTerritoire" in ('06_17-7', '07_9-4', '10_14-19', '14_20-12', '14_40-24', '19_19-10', '19_51-28', '2B_13-12', '2B_2-3', '49_18-5', '49_19-6', '49_27-12', '49_29-13', '51_32-39', '55_14-8', '56_31-42', '56_38-29', '61_8-4',
'62_43-19', '62_47-21', '62_50-22', '62_52-24', '63_12-57', '83_13-13', '85_17-8', '86_10-4', '86_11-5', '90_15-4', '91_12-38', 'ZD_34-20', 'ZD_6-8');


--on refait la requete des cas particuliers
select left("IdTerritoire", position('-' in "IdTerritoire")-1) as "txt", count(*) from 
	(
	SELECT "IdTerritoire", min("DateDebutMandat") as "DateMinDebutMandat"
	FROM "BREF"."Territoire" 
	join "BREF"."Mandat" on "BREF"."Mandat"."Territoire_IdTerritoire" = "BREF"."Territoire"."IdTerritoire"
	where "TypeTerritoire" = 'Canton'
	and "DateDebutMandat" > '01/03/2014'
	and "NomTerritoire" in 
		(
			SELECT "NomTerritoire" from
			(
			SELECT "NomTerritoire", count("NomTerritoire")
			FROM "BREF"."Territoire" 
			where "TypeTerritoire" = 'Canton'
			and "Actif" is null
			GROUP BY ("NomTerritoire")
			Having COUNT("NomTerritoire")>1
			)A
		)
	group by "IdTerritoire"
	)B
group by "txt"
having count(*) > 1;
--0

--passage à actif des cantons créé en 2014 (ayant eu au moins un mandat associé après le '01/03/2014')
update "BREF"."Territoire" 
set "Actif" = true, "DateLiee" = '01/03/2014'
where "IdTerritoire" in
(SELECT "IdTerritoire" from 
	(SELECT "IdTerritoire", min("DateDebutMandat")
	FROM "BREF"."Territoire" 
	join "BREF"."Mandat" on "BREF"."Mandat"."Territoire_IdTerritoire" = "BREF"."Territoire"."IdTerritoire"
	where "TypeTerritoire" = 'Canton'
	and "DateDebutMandat" > '01/03/2014'
	and "NomTerritoire" in 
		(
			SELECT "NomTerritoire" from
			(
			SELECT "NomTerritoire", count("NomTerritoire")
			FROM "BREF"."Territoire" 
			where "TypeTerritoire" = 'Canton'
			and "Actif" is null
			GROUP BY ("NomTerritoire")
			Having COUNT("NomTerritoire")>1
			)A
		)
	group by "IdTerritoire")A);
--843

-- on refait le requete pour voir les cantons à passer à Actif = 'oui'
SELECT "IdTerritoire", min("DateDebutMandat")
FROM "BREF"."Territoire" 
join "BREF"."Mandat" on "BREF"."Mandat"."Territoire_IdTerritoire" = "BREF"."Territoire"."IdTerritoire"
where "TypeTerritoire" = 'Canton'
and "DateDebutMandat" > '01/03/2014'
and "Actif" is null
and "NomTerritoire" in 
	(
		SELECT "NomTerritoire" from
		(
		SELECT "NomTerritoire", count("NomTerritoire")
		FROM "BREF"."Territoire" 
		where "TypeTerritoire" = 'Canton'
		and "Actif" is null
		GROUP BY ("NomTerritoire")
		Having COUNT("NomTerritoire")>1
		)A
	)
group by "IdTerritoire";
--0

--on refait la requete des doublons de cantons 
SELECT "NomTerritoire", count("NomTerritoire")
FROM "BREF"."Territoire" 
where "TypeTerritoire" = 'Canton'
and "Actif" is null
GROUP BY ("NomTerritoire")
Having COUNT("NomTerritoire")>1;
--16

--homonymes de noms de cantons dans départements différents : requete prenant en compte le num de département
SELECT "NomTerritoire", left("IdTerritoire", 2), count("NomTerritoire")
FROM "BREF"."Territoire" 
where "TypeTerritoire" = 'Canton'
and "Actif" is null
GROUP BY "NomTerritoire", left("IdTerritoire", 2)
Having COUNT("NomTerritoire")>1;
--1

--denier canton en double
select * from "BREF"."Territoire" where "NomTerritoire" = 'NOTRE DAME LIMITE';

--après recherche sur internet, ce canton n'existe plus actuellement
update "BREF"."Territoire" 
set "Actif" = false, "DateLiee" = '01/03/2014'
where "IdTerritoire" in ('13_57-57', '13_57-20');

--plus de doublons cantons
SELECT "NomTerritoire", left("IdTerritoire", 2), count("NomTerritoire")
FROM "BREF"."Territoire" 
where "TypeTerritoire" = 'Canton'
and "Actif" is null
GROUP BY "NomTerritoire", left("IdTerritoire", 2)
Having COUNT("NomTerritoire")>1;
--0


------------- cantons moule guadeloupe -------------

--moule1 16 a disparu en mars 2015
update "BREF"."Territoire" 
set "Actif" = false, "DateLiee" = '01/03/2015'
where "IdTerritoire" = 'ZA_32-16';

--moule2 17 a disparu en mars 2015
update "BREF"."Territoire" 
set "Actif" = false, "DateLiee" = '01/03/2015'
where "IdTerritoire" = 'ZA_33-17';



------------- cantons actif : lors du redécoupage de 2014 le nombre de canton passe de 4035 à 2054 -------------

--passage à actif de tous les cantons ayant eu une élection le "2015-03-29"
update "BREF"."Territoire" 
set "Actif" = true
where  "IdTerritoire" in
	(SELECT distinct "IdTerritoire"
	FROM "BREF"."Territoire" 
	join "BREF"."Mandat" on "BREF"."Mandat"."Territoire_IdTerritoire" = "BREF"."Territoire"."IdTerritoire"
	where "TypeTerritoire" = 'Canton'
	and "DateDebutMandat" = '29/03/2015'
	and "Actif" is null);

--on a bien 2054 cantons actifs
SELECT distinct "IdTerritoire"
FROM "BREF"."Territoire" 
where "TypeTerritoire" = 'Canton' and "Actif"=true;

--passage à actif=false et "DateLiee" = '01/03/2014' de tous les cantons ayant actif = null
update "BREF"."Territoire" 
set "Actif" = false, "DateLiee" = '01/03/2014'
where  "IdTerritoire" in
	(SELECT distinct "IdTerritoire"
	FROM "BREF"."Territoire" 
	where "TypeTerritoire" = 'Canton' and "Actif" is null);
--3786



-- *********** Municipalities and departments ************


-- harmonisation des types de territoire : renommage de 'Departement' en 'Département' puisqu'il y a 'Départemetn EPCI' et également 'region' en 'Région'
--ATTENTION A PRENDRE CA EN COMPTE DANS VOS SCRIPTS
update "BREF"."Territoire"
set "TypeTerritoire" = 'Département'
where "TypeTerritoire" = 'Departement';
update "BREF"."Territoire"
set "TypeTerritoire" = 'Région'
where "TypeTerritoire" = 'Region';

-- les deux premieres lettres du CodeTerritoire d'une commune est son numéro de département

-- un cas particulier vide d'une commune sans Codeterritoire : "56184"
delete from "BREF"."Territoire" where "IdTerritoire" = '56184';

--mise à jour des département Seine et SEINE ET OISE à actif=false, supprimé le 01/01/1968
update "BREF"."Territoire"
set "Actif" = false, "DateLiee" = '01/01/1968'
where "IdTerritoire" = '1795_71';
update "BREF"."Territoire"
set "Actif" = false, "DateLiee" = '01/01/1968'
where "IdTerritoire" = '1790_73';

---------------- inclusion de toutes les communes dans leurs départements -------------

--suppressions des mauvaises inclusions faites qui ont été faites pour le territoire incluant sur CodeTerritoire et non IdTerritoire
delete
from "BREF"."Inclusion"
where "TerritoireIncluant_IdTerritoire" not in
(select "IdTerritoire" from "BREF"."Territoire");

-- nombre total de communes, à inclure donc chacune : 36829
SELECT distinct "IdTerritoire" from "BREF"."Territoire"
where "TypeTerritoire" = 'Commune';
--36 829

-- auto-incrémentation de "Inclusion"
--drop sequence id_inclusion_seq cascade;
CREATE SEQUENCE "BREF".id_inclusion_seq;
SELECT setval('"BREF".id_inclusion_seq', 96513);
ALTER TABLE "BREF"."Inclusion" ALTER COLUMN "IdInclusion" SET DEFAULT
nextval('"BREF".id_inclusion_seq'::regclass);

--insertion des communes dans leurs départements correspondant aux 2 premières lettres de leur CodeTerritoire, sauf pour le Codeterritoire 97 qui représente pusieurs départements d'Outre-Mer
insert into "BREF"."Inclusion"("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire")
SELECT distinct T1."IdTerritoire", T2."IdTerritoire"
from "BREF"."Territoire" T1
join "BREF"."Territoire" T2 on T2."CodeTerritoire" = left(T1."CodeTerritoire", 2)
where T1."TypeTerritoire" = 'Commune'
and T2."TypeTerritoire" = 'Département'
and T2."Actif" = true
and T2."CodeTerritoire" != '97';
--36 698 inclusions rajoutés

--cas des départements d'Outre-Mer
update "BREF"."Territoire"
set "CodeTerritoire" = '971'
where "TypeTerritoire" = 'Département'
and "NomTerritoire" = 'GUADELOUPE';
update "BREF"."Territoire"
set "CodeTerritoire" = '972'
where "TypeTerritoire" = 'Département'
and "NomTerritoire" = 'MARTINIQUE';
update "BREF"."Territoire"
set "CodeTerritoire" = '973'
where "TypeTerritoire" = 'Département'
and "NomTerritoire" = 'GUYANE';
update "BREF"."Territoire"
set "CodeTerritoire" = '974'
where "TypeTerritoire" = 'Département'
and "NomTerritoire" = 'LA REUNION';
update "BREF"."Territoire"
set "CodeTerritoire" = '975'
where "TypeTerritoire" = 'Département'
and "NomTerritoire" = 'SAINT PIERRE ET MIQUELON';
update "BREF"."Territoire"
set "CodeTerritoire" = '976'
where "TypeTerritoire" = 'Département'
and "NomTerritoire" = 'MAYOTTE';

insert into "BREF"."Inclusion"("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire")
select distinct T1."IdTerritoire", T2."IdTerritoire"
from "BREF"."Territoire" T1
join "BREF"."Territoire" T2 on T2."CodeTerritoire" = left(T1."CodeTerritoire", 3)
where T1."TypeTerritoire" = 'Commune'
and left(T1."CodeTerritoire", 2) = '97'
and T2."TypeTerritoire" = 'Département'
and T2."Actif" = true;
--131 inclusions rajoutés

-> 131 + 36 698 = 36 829 !

-- vérification dans la table inclusion des communes incluses dans des départements
SELECT *
FROM "BREF"."Territoire" T1
join "BREF"."Inclusion" on "BREF"."Inclusion"."TerritoireInclu_IdTerritoire" = T1."IdTerritoire"
join "BREF"."Territoire" T2 on "BREF"."Inclusion"."TerritoireIncluant_IdTerritoire" = T2."IdTerritoire"
where T1."TypeTerritoire" = 'Commune'
and T2."TypeTerritoire" = 'Département';
--36 829

-- cas particuliers : territoire d'outre-mer et anciennes colonies
select * from "BREF"."Territoire"
where "TypeTerritoire" = 'Département'
and "CodeTerritoire" in (
'9A',
'9C',
'9D',
'9F',
'9G',
'9H',
'9J',
'9L',
'ZP',
'ZT',
'ZW',
'ZX',
'ZY',
'ZZ',
'ZZC',
'ZZS')

--fin des départements d'algérie en 1962
update "BREF"."Territoire"
set "Actif" = false, "DateLiee" = '01/01/1962'
where "CodeTerritoire" in ('9A', '9C', '9D', '9F', '9G', '9H', '9J', '9L');

--renommage codeterritoire NC et PF
update "BREF"."Territoire"
set "CodeTerritoire" = '988'
where "IdTerritoire" = '2003_988';
update "BREF"."Territoire"
set "CodeTerritoire" = '987'
where "IdTerritoire" = '1958_987';

--modification de l'inclusion des communes de PF, qui étaient mal incluse dans NC au lieu de PF

SELECT "BREF"."Inclusion".*
FROM "BREF"."Territoire" T1
join "BREF"."Inclusion" on "BREF"."Inclusion"."TerritoireInclu_IdTerritoire" = T1."IdTerritoire"
where T1."TypeTerritoire" = 'Commune'
and "CodeTerritoire" like '987%';

update "BREF"."Inclusion"
set "TerritoireIncluant_IdTerritoire" = '1958_987'
where "TerritoireInclu_IdTerritoire" in
('30536',
'31627',
'32457',
'32627',
'33361',
'33543',
'33656',
'37796',
'39502',
'39949',
'39994',
'42557',
'42684',
'46679',
'47021',
'47313',
'47440',
'47461',
'48381',
'48390',
'49328',
'50423',
'51737',
'51753',
'52264',
'52452',
'52955',
'52996',
'54110',
'54155',
'54935',
'55158',
'55188',
'55430',
'55573',
'56331',
'56716',
'57137',
'60619',
'60931',
'61578',
'61584',
'62930',
'63523',
'64850',
'65744',
'66410',
'66427');

--modification des codeterritoires des communes de Mayotte qui sont faux

select * from "BREF"."Territoire"
where "CodeTerritoire" like '975%'
order by "CodeTerritoire";

update "BREF"."Territoire"
set "CodeTerritoire" = '97601'
where "NomTerritoire" = 'ACOUA' and "TypeTerritoire" = 'Commune';
update "BREF"."Territoire"
set "CodeTerritoire" = '97602'
where "NomTerritoire" = 'BANDRABOUA' and "TypeTerritoire" = 'Commune';
update "BREF"."Territoire"
set "CodeTerritoire" = '97603'
where "CodeTerritoire" = '97503';
update "BREF"."Territoire"
set "CodeTerritoire" = '97604'
where "CodeTerritoire" = '97504';
update "BREF"."Territoire"
set "CodeTerritoire" = '97605'
where "CodeTerritoire" = '97505';
update "BREF"."Territoire"
set "CodeTerritoire" = '97606'
where "CodeTerritoire" = '97506';
update "BREF"."Territoire"
set "CodeTerritoire" = '97607'
where "CodeTerritoire" = '97507';
update "BREF"."Territoire"
set "CodeTerritoire" = '97608'
where "CodeTerritoire" = '97508';
update "BREF"."Territoire"
set "CodeTerritoire" = '97609'
where "CodeTerritoire" = '97509';
update "BREF"."Territoire"
set "CodeTerritoire" = '97610'
where "CodeTerritoire" = '97510';
update "BREF"."Territoire"
set "CodeTerritoire" = '97611'
where "CodeTerritoire" = '97511';
update "BREF"."Territoire"
set "CodeTerritoire" = '97612'
where "CodeTerritoire" = '97512';
update "BREF"."Territoire"
set "CodeTerritoire" = '97613'
where "CodeTerritoire" = '97513';
update "BREF"."Territoire"
set "CodeTerritoire" = '97614'
where "CodeTerritoire" = '97514';
update "BREF"."Territoire"
set "CodeTerritoire" = '97615'
where "CodeTerritoire" = '97515';
update "BREF"."Territoire"
set "CodeTerritoire" = '97616'
where "CodeTerritoire" = '97516';
update "BREF"."Territoire"
set "CodeTerritoire" = '97617'
where "CodeTerritoire" = '97517';


--modification de l'inclusion des communes de Mayotte qui étaient inclu à St Pierre et Miquelon

select * from "BREF"."Territoire"
where "CodeTerritoire" like '976%'
and "TypeTerritoire" = 'Commune';
--17


select * from "BREF"."Inclusion"
join "BREF"."Territoire" on "Territoire"."IdTerritoire" = "Inclusion"."TerritoireInclu_IdTerritoire"
where "CodeTerritoire" like '976%'
and "TypeTerritoire" = 'Commune';
--33
 
update "BREF"."Inclusion"
set "TerritoireIncluant_IdTerritoire" = '2011_976'
where "IdInclusion" in
('170706',	'170707',	'170709',	'170713',	'170716',	'170725',	'170739',	'170755',	'170762',	'170767',	'170768',	'170770',	'170777',	'170778',	'170784',	'170809',	'170815');
--17



--suppression mauvaises incluses communes dans département avec codeterritoires au lieu d'idterritoire
delete
from "BREF"."Inclusion"
where "TerritoireIncluant_IdTerritoire" not in
(select "IdTerritoire" from "BREF"."Territoire");





insert into "BREF"."Territoire" ("IdTerritoire", "NomTerritoire", "TypeTerritoire", "CodeTerritoire", "DateLiee", "Actif")
    values ('971_29', 'SAINT MARTIN 1', 'Canton', '29', '01/01/2007', true);
    insert into "BREF"."Territoire" ("IdTerritoire", "NomTerritoire", "TypeTerritoire", "CodeTerritoire", "DateLiee", "Actif")
    values ('971_44', 'SAINT MARTIN 2', 'Canton', '44', '01/01/2007', true);





-- **** Circonscriptiosn législatives ***

--toutes les circonscriptions legislatives sont fausses
select * from "BREF"."Territoire" where "TypeTerritoire" = 'Circonscription Legislative';
select * from "BREF"."Territoire" where "IdTerritoire" in
('66872',	'66873',	'66874',	'66875',	'66876',	'66877',	'66878',	'66879',	'66880',	'66881',	'66882',	'66883',	'66884',	'66885',	'66886',	'66887',	'66888',	'66889',	'66890',	'66891',	'66892',	'66893',	'66894',	'66895',	'66896');


--auto incrémentation de "IdTerritoire"
drop sequence "BREF".id_territoire_seq cascade;
CREATE SEQUENCE "BREF".id_territoire_seq;
SELECT setval('"BREF".id_territoire_seq', 66898);
ALTER TABLE "BREF"."Territoire" ALTER COLUMN "IdTerritoire" SET DEFAULT
nextval('"BREF".id_territoire_seq'::regclass);

--insertion des circonscriptions legislatives
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_01', '1ERE CIRCONSCRIPTION AIN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_01', '2EME CIRCONSCRIPTION AIN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_01', '3EME CIRCONSCRIPTION AIN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_01', '4EME CIRCONSCRIPTION AIN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_01', '5EME CIRCONSCRIPTION AIN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_02', '1ERE CIRCONSCRIPTION AISNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_02', '2EME CIRCONSCRIPTION AISNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_02', '3EME CIRCONSCRIPTION AISNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_02', '4EME CIRCONSCRIPTION AISNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_02', '5EME CIRCONSCRIPTION AISNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_03', '1ERE CIRCONSCRIPTION ALLIER', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_03', '2EME CIRCONSCRIPTION ALLIER', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_03', '3EME CIRCONSCRIPTION ALLIER', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_03', '4EME CIRCONSCRIPTION ALLIER', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_04', '1ERE CIRCONSCRIPTION ALPES DE HAUTE PROVENCE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_04', '2EME CIRCONSCRIPTION ALPES DE HAUTE PROVENCE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_05', '1ERE CIRCONSCRIPTION HAUTES ALPES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_05', '2EME CIRCONSCRIPTION HAUTES ALPES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_06', '1ERE CIRCONSCRIPTION ALPES MARITIMES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_06', '2EME CIRCONSCRIPTION ALPES MARITIMES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_06', '3EME CIRCONSCRIPTION ALPES MARITIMES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_06', '4EME CIRCONSCRIPTION ALPES MARITIMES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_06', '5EME CIRCONSCRIPTION ALPES MARITIMES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_06', '6EME CIRCONSCRIPTION ALPES MARITIMES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_06', '7EME CIRCONSCRIPTION ALPES MARITIMES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('8_06', '8EME CIRCONSCRIPTION ALPES MARITIMES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('9_06', '9EME CIRCONSCRIPTION ALPES MARITIMES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_07', '1ERE CIRCONSCRIPTION ARDECHE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_07', '2EME CIRCONSCRIPTION ARDECHE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_07', '3EME CIRCONSCRIPTION ARDECHE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_08', '1ERE CIRCONSCRIPTION ARDENNES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_08', '2EME CIRCONSCRIPTION ARDENNES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_08', '3EME CIRCONSCRIPTION ARDENNES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_09', '1ERE CIRCONSCRIPTION ARIEGE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_09', '2EME CIRCONSCRIPTION ARIEGE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_10', '1ERE CIRCONSCRIPTION AUBE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_10', '2EME CIRCONSCRIPTION AUBE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_10', '3EME CIRCONSCRIPTION AUBE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_11', '1ERE CIRCONSCRIPTION AUDE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_11', '2EME CIRCONSCRIPTION AUDE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_11', '3EME CIRCONSCRIPTION AUDE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_12', '1ERE CIRCONSCRIPTION AVEYRON', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_12', '2EME CIRCONSCRIPTION AVEYRON', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_12', '3EME CIRCONSCRIPTION AVEYRON', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_13', '1ERE CIRCONSCRIPTION BOUCHES DU RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_13', '2EME CIRCONSCRIPTION BOUCHES DU RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_13', '3EME CIRCONSCRIPTION BOUCHES DU RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_13', '4EME CIRCONSCRIPTION BOUCHES DU RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_13', '5EME CIRCONSCRIPTION BOUCHES DU RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_13', '6EME CIRCONSCRIPTION BOUCHES DU RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_13', '7EME CIRCONSCRIPTION BOUCHES DU RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('8_13', '8EME CIRCONSCRIPTION BOUCHES DU RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('9_13', '9EME CIRCONSCRIPTION BOUCHES DU RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('10_13', '10EME CIRCONSCRIPTION BOUCHES DU RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('11_13', '11EME CIRCONSCRIPTION BOUCHES DU RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('12_13', '12EME CIRCONSCRIPTION BOUCHES DU RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('13_13', '13EME CIRCONSCRIPTION BOUCHES DU RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('14_13', '14EME CIRCONSCRIPTION BOUCHES DU RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('15_13', '15EME CIRCONSCRIPTION BOUCHES DU RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('16_13', '16EME CIRCONSCRIPTION BOUCHES DU RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_14', '1ERE CIRCONSCRIPTION CALVADOS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_14', '2EME CIRCONSCRIPTION CALVADOS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_14', '3EME CIRCONSCRIPTION CALVADOS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_14', '4EME CIRCONSCRIPTION CALVADOS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_14', '5EME CIRCONSCRIPTION CALVADOS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_14', '6EME CIRCONSCRIPTION CALVADOS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_15', '1ERE CIRCONSCRIPTION CANTAL', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_15', '2EME CIRCONSCRIPTION CANTAL', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_16', '1ERE CIRCONSCRIPTION CHARENTE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_16', '2EME CIRCONSCRIPTION CHARENTE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_16', '3EME CIRCONSCRIPTION CHARENTE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_16', '4EME CIRCONSCRIPTION CHARENTE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_17', '1ERE CIRCONSCRIPTION CHARENTE MARITIME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_17', '2EME CIRCONSCRIPTION CHARENTE MARITIME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_17', '3EME CIRCONSCRIPTION CHARENTE MARITIME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_17', '4EME CIRCONSCRIPTION CHARENTE MARITIME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_17', '5EME CIRCONSCRIPTION CHARENTE MARITIME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_18', '1ERE CIRCONSCRIPTION CHER', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_18', '2EME CIRCONSCRIPTION CHER', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_18', '3EME CIRCONSCRIPTION CHER', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_19', '1ERE CIRCONSCRIPTION CORREZE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_19', '2EME CIRCONSCRIPTION CORREZE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_19', '3EME CIRCONSCRIPTION CORREZE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_21', '1ERE CIRCONSCRIPTION COTE D OR', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_21', '2EME CIRCONSCRIPTION COTE D OR', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_21', '3EME CIRCONSCRIPTION COTE D OR', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_21', '4EME CIRCONSCRIPTION COTE D OR', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_21', '5EME CIRCONSCRIPTION COTE D OR', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_22', '1ERE CIRCONSCRIPTION COTES D ARMOR', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_22', '2EME CIRCONSCRIPTION COTES D ARMOR', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_22', '3EME CIRCONSCRIPTION COTES D ARMOR', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_22', '4EME CIRCONSCRIPTION COTES D ARMOR', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_22', '5EME CIRCONSCRIPTION COTES D ARMOR', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_23', '1ERE CIRCONSCRIPTION CREUSE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_23', '2EME CIRCONSCRIPTION CREUSE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_24', '1ERE CIRCONSCRIPTION DORDOGNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_24', '2EME CIRCONSCRIPTION DORDOGNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_24', '3EME CIRCONSCRIPTION DORDOGNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_24', '4EME CIRCONSCRIPTION DORDOGNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_25', '1ERE CIRCONSCRIPTION DOUBS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_25', '2EME CIRCONSCRIPTION DOUBS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_25', '3EME CIRCONSCRIPTION DOUBS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_25', '4EME CIRCONSCRIPTION DOUBS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_25', '5EME CIRCONSCRIPTION DOUBS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_26', '1ERE CIRCONSCRIPTION DROME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_26', '2EME CIRCONSCRIPTION DROME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_26', '3EME CIRCONSCRIPTION DROME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_26', '4EME CIRCONSCRIPTION DROME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_27', '1ERE CIRCONSCRIPTION EURE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_27', '2EME CIRCONSCRIPTION EURE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_27', '3EME CIRCONSCRIPTION EURE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_27', '4EME CIRCONSCRIPTION EURE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_27', '5EME CIRCONSCRIPTION EURE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_28', '1ERE CIRCONSCRIPTION EURE ET LOIR', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_28', '2EME CIRCONSCRIPTION EURE ET LOIR', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_28', '3EME CIRCONSCRIPTION EURE ET LOIR', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_28', '4EME CIRCONSCRIPTION EURE ET LOIR', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_29', '1ERE CIRCONSCRIPTION FINISTERE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_29', '2EME CIRCONSCRIPTION FINISTERE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_29', '3EME CIRCONSCRIPTION FINISTERE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_29', '4EME CIRCONSCRIPTION FINISTERE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_29', '5EME CIRCONSCRIPTION FINISTERE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_29', '6EME CIRCONSCRIPTION FINISTERE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_29', '7EME CIRCONSCRIPTION FINISTERE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('8_29', '8EME CIRCONSCRIPTION FINISTERE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_2A', '1ERE CIRCONSCRIPTION CORSE SUD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_2A', '2EME CIRCONSCRIPTION CORSE SUD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_2B', '1ERE CIRCONSCRIPTION HAUTE CORSE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_2B', '2EME CIRCONSCRIPTION HAUTE CORSE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_30', '1ERE CIRCONSCRIPTION GARD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_30', '2EME CIRCONSCRIPTION GARD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_30', '3EME CIRCONSCRIPTION GARD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_30', '4EME CIRCONSCRIPTION GARD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_30', '5EME CIRCONSCRIPTION GARD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_30', '6EME CIRCONSCRIPTION GARD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_31', '1ERE CIRCONSCRIPTION HAUTE GARONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_31', '2EME CIRCONSCRIPTION HAUTE GARONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_31', '3EME CIRCONSCRIPTION HAUTE GARONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_31', '4EME CIRCONSCRIPTION HAUTE GARONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_31', '5EME CIRCONSCRIPTION HAUTE GARONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_31', '6EME CIRCONSCRIPTION HAUTE GARONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_31', '7EME CIRCONSCRIPTION HAUTE GARONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('8_31', '8EME CIRCONSCRIPTION HAUTE GARONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('9_31', '9EME CIRCONSCRIPTION HAUTE GARONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('10_31', '10EME CIRCONSCRIPTION HAUTE GARONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_32', '1ERE CIRCONSCRIPTION GERS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_32', '2EME CIRCONSCRIPTION GERS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_33', '1ERE CIRCONSCRIPTION GIRONDE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_33', '2EME CIRCONSCRIPTION GIRONDE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_33', '3EME CIRCONSCRIPTION GIRONDE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_33', '4EME CIRCONSCRIPTION GIRONDE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_33', '5EME CIRCONSCRIPTION GIRONDE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_33', '6EME CIRCONSCRIPTION GIRONDE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_33', '7EME CIRCONSCRIPTION GIRONDE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('8_33', '8EME CIRCONSCRIPTION GIRONDE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('9_33', '9EME CIRCONSCRIPTION GIRONDE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('10_33', '10EME CIRCONSCRIPTION GIRONDE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('11_33', '11EME CIRCONSCRIPTION GIRONDE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('12_33', '12EME CIRCONSCRIPTION GIRONDE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_34', '1ERE CIRCONSCRIPTION HERAULT', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_34', '2EME CIRCONSCRIPTION HERAULT', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_34', '3EME CIRCONSCRIPTION HERAULT', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_34', '4EME CIRCONSCRIPTION HERAULT', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_34', '5EME CIRCONSCRIPTION HERAULT', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_34', '6EME CIRCONSCRIPTION HERAULT', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_34', '7EME CIRCONSCRIPTION HERAULT', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('8_34', '8EME CIRCONSCRIPTION HERAULT', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('9_34', '9EME CIRCONSCRIPTION HERAULT', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_35', '1ERE CIRCONSCRIPTION ILLE ET VILAINE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_35', '2EME CIRCONSCRIPTION ILLE ET VILAINE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_35', '3EME CIRCONSCRIPTION ILLE ET VILAINE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_35', '4EME CIRCONSCRIPTION ILLE ET VILAINE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_35', '5EME CIRCONSCRIPTION ILLE ET VILAINE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_35', '6EME CIRCONSCRIPTION ILLE ET VILAINE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_35', '7EME CIRCONSCRIPTION ILLE ET VILAINE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('8_35', '8EME CIRCONSCRIPTION ILLE ET VILAINE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_36', '1ERE CIRCONSCRIPTION INDRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_36', '2EME CIRCONSCRIPTION INDRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_36', '3EME CIRCONSCRIPTION INDRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_37', '1ERE CIRCONSCRIPTION INDRE ET LOIRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_37', '2EME CIRCONSCRIPTION INDRE ET LOIRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_37', '3EME CIRCONSCRIPTION INDRE ET LOIRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_37', '4EME CIRCONSCRIPTION INDRE ET LOIRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_37', '5EME CIRCONSCRIPTION INDRE ET LOIRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_38', '1ERE CIRCONSCRIPTION ISERE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_38', '2EME CIRCONSCRIPTION ISERE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_38', '3EME CIRCONSCRIPTION ISERE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_38', '4EME CIRCONSCRIPTION ISERE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_38', '5EME CIRCONSCRIPTION ISERE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_38', '6EME CIRCONSCRIPTION ISERE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_38', '7EME CIRCONSCRIPTION ISERE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('8_38', '8EME CIRCONSCRIPTION ISERE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('9_38', '9EME CIRCONSCRIPTION ISERE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('10_38', '10EME CIRCONSCRIPTION ISERE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_39', '1ERE CIRCONSCRIPTION JURA', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_39', '2EME CIRCONSCRIPTION JURA', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_39', '3EME CIRCONSCRIPTION JURA', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_40', '1ERE CIRCONSCRIPTION LANDES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_40', '2EME CIRCONSCRIPTION LANDES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_40', '3EME CIRCONSCRIPTION LANDES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_41', '1ERE CIRCONSCRIPTION LOIR ET CHER', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_41', '2EME CIRCONSCRIPTION LOIR ET CHER', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_41', '3EME CIRCONSCRIPTION LOIR ET CHER', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_42', '1ERE CIRCONSCRIPTION LOIRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_42', '2EME CIRCONSCRIPTION LOIRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_42', '3EME CIRCONSCRIPTION LOIRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_42', '4EME CIRCONSCRIPTION LOIRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_42', '5EME CIRCONSCRIPTION LOIRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_42', '6EME CIRCONSCRIPTION LOIRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_42', '7EME CIRCONSCRIPTION LOIRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_43', '1ERE CIRCONSCRIPTION HAUTE LOIRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_43', '2EME CIRCONSCRIPTION HAUTE LOIRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_44', '1ERE CIRCONSCRIPTION LOIRE ATLANTIQUE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_44', '2EME CIRCONSCRIPTION LOIRE ATLANTIQUE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_44', '3EME CIRCONSCRIPTION LOIRE ATLANTIQUE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_44', '4EME CIRCONSCRIPTION LOIRE ATLANTIQUE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_44', '5EME CIRCONSCRIPTION LOIRE ATLANTIQUE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_44', '6EME CIRCONSCRIPTION LOIRE ATLANTIQUE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_44', '7EME CIRCONSCRIPTION LOIRE ATLANTIQUE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('8_44', '8EME CIRCONSCRIPTION LOIRE ATLANTIQUE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('9_44', '9EME CIRCONSCRIPTION LOIRE ATLANTIQUE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('10_44', '10EME CIRCONSCRIPTION LOIRE ATLANTIQUE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_45', '1ERE CIRCONSCRIPTION LOIRET', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_45', '2EME CIRCONSCRIPTION LOIRET', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_45', '3EME CIRCONSCRIPTION LOIRET', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_45', '4EME CIRCONSCRIPTION LOIRET', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_45', '5EME CIRCONSCRIPTION LOIRET', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_45', '6EME CIRCONSCRIPTION LOIRET', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_46', '1ERE CIRCONSCRIPTION LOT', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_46', '2EME CIRCONSCRIPTION LOT', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_47', '1ERE CIRCONSCRIPTION LOT ET GARONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_47', '2EME CIRCONSCRIPTION LOT ET GARONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_47', '3EME CIRCONSCRIPTION LOT ET GARONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_48', '1ERE CIRCONSCRIPTION LOZERE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_48', '2EME CIRCONSCRIPTION LOZERE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_49', '1ERE CIRCONSCRIPTION MAINE ET LOIRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_49', '2EME CIRCONSCRIPTION MAINE ET LOIRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_49', '3EME CIRCONSCRIPTION MAINE ET LOIRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_49', '4EME CIRCONSCRIPTION MAINE ET LOIRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_49', '5EME CIRCONSCRIPTION MAINE ET LOIRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_49', '6EME CIRCONSCRIPTION MAINE ET LOIRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_49', '7EME CIRCONSCRIPTION MAINE ET LOIRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_50', '1ERE CIRCONSCRIPTION MANCHE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_50', '2EME CIRCONSCRIPTION MANCHE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_50', '3EME CIRCONSCRIPTION MANCHE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_50', '4EME CIRCONSCRIPTION MANCHE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_50', '5EME CIRCONSCRIPTION MANCHE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_51', '1ERE CIRCONSCRIPTION MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_51', '2EME CIRCONSCRIPTION MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_51', '3EME CIRCONSCRIPTION MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_51', '4EME CIRCONSCRIPTION MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_51', '5EME CIRCONSCRIPTION MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_51', '6EME CIRCONSCRIPTION MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_52', '1ERE CIRCONSCRIPTION HAUTE MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_52', '2EME CIRCONSCRIPTION HAUTE MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_53', '1ERE CIRCONSCRIPTION MAYENNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_53', '2EME CIRCONSCRIPTION MAYENNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_53', '3EME CIRCONSCRIPTION MAYENNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_54', '1ERE CIRCONSCRIPTION MEURTHE ET MOSELLE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_54', '2EME CIRCONSCRIPTION MEURTHE ET MOSELLE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_54', '3EME CIRCONSCRIPTION MEURTHE ET MOSELLE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_54', '4EME CIRCONSCRIPTION MEURTHE ET MOSELLE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_54', '5EME CIRCONSCRIPTION MEURTHE ET MOSELLE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_54', '6EME CIRCONSCRIPTION MEURTHE ET MOSELLE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_54', '7EME CIRCONSCRIPTION MEURTHE ET MOSELLE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_55', '1ERE CIRCONSCRIPTION MEUSE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_55', '2EME CIRCONSCRIPTION MEUSE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_56', '1ERE CIRCONSCRIPTION MORBIHAN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_56', '2EME CIRCONSCRIPTION MORBIHAN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_56', '3EME CIRCONSCRIPTION MORBIHAN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_56', '4EME CIRCONSCRIPTION MORBIHAN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_56', '5EME CIRCONSCRIPTION MORBIHAN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_56', '6EME CIRCONSCRIPTION MORBIHAN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_57', '1ERE CIRCONSCRIPTION MOSELLE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_57', '2EME CIRCONSCRIPTION MOSELLE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_57', '3EME CIRCONSCRIPTION MOSELLE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_57', '4EME CIRCONSCRIPTION MOSELLE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_57', '5EME CIRCONSCRIPTION MOSELLE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_57', '6EME CIRCONSCRIPTION MOSELLE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_57', '7EME CIRCONSCRIPTION MOSELLE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('8_57', '8EME CIRCONSCRIPTION MOSELLE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('9_57', '9EME CIRCONSCRIPTION MOSELLE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('10_57', '10EME CIRCONSCRIPTION MOSELLE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_58', '1ERE CIRCONSCRIPTION NIEVRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_58', '2EME CIRCONSCRIPTION NIEVRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_58', '3EME CIRCONSCRIPTION NIEVRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_59', '1ERE CIRCONSCRIPTION NORD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_59', '2EME CIRCONSCRIPTION NORD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_59', '3EME CIRCONSCRIPTION NORD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_59', '4EME CIRCONSCRIPTION NORD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_59', '5EME CIRCONSCRIPTION NORD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_59', '6EME CIRCONSCRIPTION NORD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_59', '7EME CIRCONSCRIPTION NORD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('8_59', '8EME CIRCONSCRIPTION NORD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('9_59', '9EME CIRCONSCRIPTION NORD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('10_59', '10EME CIRCONSCRIPTION NORD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('11_59', '11EME CIRCONSCRIPTION NORD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('12_59', '12EME CIRCONSCRIPTION NORD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('13_59', '13EME CIRCONSCRIPTION NORD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('14_59', '14EME CIRCONSCRIPTION NORD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('15_59', '15EME CIRCONSCRIPTION NORD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('16_59', '16EME CIRCONSCRIPTION NORD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('17_59', '17EME CIRCONSCRIPTION NORD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('18_59', '18EME CIRCONSCRIPTION NORD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('19_59', '19EME CIRCONSCRIPTION NORD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('20_59', '20EME CIRCONSCRIPTION NORD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('21_59', '21EME CIRCONSCRIPTION NORD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('22_59', '22EME CIRCONSCRIPTION NORD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('23_59', '23EME CIRCONSCRIPTION NORD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('24_59', '24EME CIRCONSCRIPTION NORD', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_60', '1ERE CIRCONSCRIPTION OISE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_60', '2EME CIRCONSCRIPTION OISE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_60', '3EME CIRCONSCRIPTION OISE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_60', '4EME CIRCONSCRIPTION OISE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_60', '5EME CIRCONSCRIPTION OISE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_60', '6EME CIRCONSCRIPTION OISE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_60', '7EME CIRCONSCRIPTION OISE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_61', '1ERE CIRCONSCRIPTION ORNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_61', '2EME CIRCONSCRIPTION ORNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_61', '3EME CIRCONSCRIPTION ORNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_62', '1ERE CIRCONSCRIPTION PAS DE CALAIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_62', '2EME CIRCONSCRIPTION PAS DE CALAIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_62', '3EME CIRCONSCRIPTION PAS DE CALAIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_62', '4EME CIRCONSCRIPTION PAS DE CALAIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_62', '5EME CIRCONSCRIPTION PAS DE CALAIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_62', '6EME CIRCONSCRIPTION PAS DE CALAIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_62', '7EME CIRCONSCRIPTION PAS DE CALAIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('8_62', '8EME CIRCONSCRIPTION PAS DE CALAIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('9_62', '9EME CIRCONSCRIPTION PAS DE CALAIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('10_62', '10EME CIRCONSCRIPTION PAS DE CALAIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('11_62', '11EME CIRCONSCRIPTION PAS DE CALAIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('12_62', '12EME CIRCONSCRIPTION PAS DE CALAIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('13_62', '13EME CIRCONSCRIPTION PAS DE CALAIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('14_62', '14EME CIRCONSCRIPTION PAS DE CALAIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_63', '1ERE CIRCONSCRIPTION PUY DE DOME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_63', '2EME CIRCONSCRIPTION PUY DE DOME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_63', '3EME CIRCONSCRIPTION PUY DE DOME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_63', '4EME CIRCONSCRIPTION PUY DE DOME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_63', '5EME CIRCONSCRIPTION PUY DE DOME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_63', '6EME CIRCONSCRIPTION PUY DE DOME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_64', '1ERE CIRCONSCRIPTION PYRENEES ATLANTIQUES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_64', '2EME CIRCONSCRIPTION PYRENEES ATLANTIQUES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_64', '3EME CIRCONSCRIPTION PYRENEES ATLANTIQUES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_64', '4EME CIRCONSCRIPTION PYRENEES ATLANTIQUES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_64', '5EME CIRCONSCRIPTION PYRENEES ATLANTIQUES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_64', '6EME CIRCONSCRIPTION PYRENEES ATLANTIQUES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_65', '1ERE CIRCONSCRIPTION HAUTES PYRENEES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_65', '2EME CIRCONSCRIPTION HAUTES PYRENEES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_65', '3EME CIRCONSCRIPTION HAUTES PYRENEES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_66', '1ERE CIRCONSCRIPTION PYRENEES ORIENTALES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_66', '2EME CIRCONSCRIPTION PYRENEES ORIENTALES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_66', '3EME CIRCONSCRIPTION PYRENEES ORIENTALES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_66', '4EME CIRCONSCRIPTION PYRENEES ORIENTALES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_67', '1ERE CIRCONSCRIPTION BAS RHIN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_67', '2EME CIRCONSCRIPTION BAS RHIN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_67', '3EME CIRCONSCRIPTION BAS RHIN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_67', '4EME CIRCONSCRIPTION BAS RHIN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_67', '5EME CIRCONSCRIPTION BAS RHIN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_67', '6EME CIRCONSCRIPTION BAS RHIN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_67', '7EME CIRCONSCRIPTION BAS RHIN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('8_67', '8EME CIRCONSCRIPTION BAS RHIN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('9_67', '9EME CIRCONSCRIPTION BAS RHIN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_68', '1ERE CIRCONSCRIPTION HAUT RHIN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_68', '2EME CIRCONSCRIPTION HAUT RHIN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_68', '3EME CIRCONSCRIPTION HAUT RHIN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_68', '4EME CIRCONSCRIPTION HAUT RHIN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_68', '5EME CIRCONSCRIPTION HAUT RHIN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_68', '6EME CIRCONSCRIPTION HAUT RHIN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_68', '7EME CIRCONSCRIPTION HAUT RHIN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_69', '1ERE CIRCONSCRIPTION RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_69', '2EME CIRCONSCRIPTION RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_69', '3EME CIRCONSCRIPTION RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_69', '4EME CIRCONSCRIPTION RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_69', '5EME CIRCONSCRIPTION RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_69', '6EME CIRCONSCRIPTION RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_69', '7EME CIRCONSCRIPTION RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('8_69', '8EME CIRCONSCRIPTION RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('9_69', '9EME CIRCONSCRIPTION RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('10_69', '10EME CIRCONSCRIPTION RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('11_69', '11EME CIRCONSCRIPTION RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('12_69', '12EME CIRCONSCRIPTION RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('13_69', '13EME CIRCONSCRIPTION RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('14_69', '14EME CIRCONSCRIPTION RHONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_70', '1ERE CIRCONSCRIPTION HAUTE SAONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_70', '2EME CIRCONSCRIPTION HAUTE SAONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_70', '3EME CIRCONSCRIPTION HAUTE SAONE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_71', '1ERE CIRCONSCRIPTION SAONE ET LOIRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_71', '2EME CIRCONSCRIPTION SAONE ET LOIRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_71', '3EME CIRCONSCRIPTION SAONE ET LOIRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_71', '4EME CIRCONSCRIPTION SAONE ET LOIRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_71', '5EME CIRCONSCRIPTION SAONE ET LOIRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_71', '6EME CIRCONSCRIPTION SAONE ET LOIRE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_72', '1ERE CIRCONSCRIPTION SARTHE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_72', '2EME CIRCONSCRIPTION SARTHE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_72', '3EME CIRCONSCRIPTION SARTHE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_72', '4EME CIRCONSCRIPTION SARTHE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_72', '5EME CIRCONSCRIPTION SARTHE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_73', '1ERE CIRCONSCRIPTION SAVOIE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_73', '2EME CIRCONSCRIPTION SAVOIE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_73', '3EME CIRCONSCRIPTION SAVOIE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_73', '4EME CIRCONSCRIPTION SAVOIE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_74', '1ERE CIRCONSCRIPTION HAUTE SAVOIE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_74', '2EME CIRCONSCRIPTION HAUTE SAVOIE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_74', '3EME CIRCONSCRIPTION HAUTE SAVOIE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_74', '4EME CIRCONSCRIPTION HAUTE SAVOIE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_74', '5EME CIRCONSCRIPTION HAUTE SAVOIE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_74', '6EME CIRCONSCRIPTION HAUTE SAVOIE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_75', '1ERE CIRCONSCRIPTION PARIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_75', '2EME CIRCONSCRIPTION PARIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_75', '3EME CIRCONSCRIPTION PARIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_75', '4EME CIRCONSCRIPTION PARIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_75', '5EME CIRCONSCRIPTION PARIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_75', '6EME CIRCONSCRIPTION PARIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_75', '7EME CIRCONSCRIPTION PARIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('8_75', '8EME CIRCONSCRIPTION PARIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('9_75', '9EME CIRCONSCRIPTION PARIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('10_75', '10EME CIRCONSCRIPTION PARIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('11_75', '11EME CIRCONSCRIPTION PARIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('12_75', '12EME CIRCONSCRIPTION PARIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('13_75', '13EME CIRCONSCRIPTION PARIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('14_75', '14EME CIRCONSCRIPTION PARIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('15_75', '15EME CIRCONSCRIPTION PARIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('16_75', '16EME CIRCONSCRIPTION PARIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('17_75', '17EME CIRCONSCRIPTION PARIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('18_75', '18EME CIRCONSCRIPTION PARIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('19_75', '19EME CIRCONSCRIPTION PARIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('20_75', '20EME CIRCONSCRIPTION PARIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('21_75', '21EME CIRCONSCRIPTION PARIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_76', '1ERE CIRCONSCRIPTION SEINE MARITIME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_76', '2EME CIRCONSCRIPTION SEINE MARITIME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_76', '3EME CIRCONSCRIPTION SEINE MARITIME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_76', '4EME CIRCONSCRIPTION SEINE MARITIME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_76', '5EME CIRCONSCRIPTION SEINE MARITIME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_76', '6EME CIRCONSCRIPTION SEINE MARITIME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_76', '7EME CIRCONSCRIPTION SEINE MARITIME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('8_76', '8EME CIRCONSCRIPTION SEINE MARITIME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('9_76', '9EME CIRCONSCRIPTION SEINE MARITIME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('10_76', '10EME CIRCONSCRIPTION SEINE MARITIME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('11_76', '11EME CIRCONSCRIPTION SEINE MARITIME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('12_76', '12EME CIRCONSCRIPTION SEINE MARITIME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_77', '1ERE CIRCONSCRIPTION SEINE ET MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_77', '2EME CIRCONSCRIPTION SEINE ET MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_77', '3EME CIRCONSCRIPTION SEINE ET MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_77', '4EME CIRCONSCRIPTION SEINE ET MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_77', '5EME CIRCONSCRIPTION SEINE ET MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_77', '6EME CIRCONSCRIPTION SEINE ET MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_77', '7EME CIRCONSCRIPTION SEINE ET MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('8_77', '8EME CIRCONSCRIPTION SEINE ET MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('9_77', '9EME CIRCONSCRIPTION SEINE ET MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('10_77', '10EME CIRCONSCRIPTION SEINE ET MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('11_77', '11EME CIRCONSCRIPTION SEINE ET MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_78', '1ERE CIRCONSCRIPTION YVELINES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_78', '2EME CIRCONSCRIPTION YVELINES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_78', '3EME CIRCONSCRIPTION YVELINES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_78', '4EME CIRCONSCRIPTION YVELINES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_78', '5EME CIRCONSCRIPTION YVELINES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_78', '6EME CIRCONSCRIPTION YVELINES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_78', '7EME CIRCONSCRIPTION YVELINES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('8_78', '8EME CIRCONSCRIPTION YVELINES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('9_78', '9EME CIRCONSCRIPTION YVELINES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('10_78', '10EME CIRCONSCRIPTION YVELINES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('11_78', '11EME CIRCONSCRIPTION YVELINES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('12_78', '12EME CIRCONSCRIPTION YVELINES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_79', '1ERE CIRCONSCRIPTION DEUX SEVRES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_79', '2EME CIRCONSCRIPTION DEUX SEVRES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_79', '3EME CIRCONSCRIPTION DEUX SEVRES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_79', '4EME CIRCONSCRIPTION DEUX SEVRES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_80', '1ERE CIRCONSCRIPTION SOMME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_80', '2EME CIRCONSCRIPTION SOMME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_80', '3EME CIRCONSCRIPTION SOMME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_80', '4EME CIRCONSCRIPTION SOMME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_80', '5EME CIRCONSCRIPTION SOMME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_80', '6EME CIRCONSCRIPTION SOMME', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_81', '1ERE CIRCONSCRIPTION TARN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_81', '2EME CIRCONSCRIPTION TARN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_81', '3EME CIRCONSCRIPTION TARN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_81', '4EME CIRCONSCRIPTION TARN', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_82', '1ERE CIRCONSCRIPTION TARN ET GARONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_82', '2EME CIRCONSCRIPTION TARN ET GARONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_83', '1ERE CIRCONSCRIPTION VAR', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_83', '2EME CIRCONSCRIPTION VAR', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_83', '3EME CIRCONSCRIPTION VAR', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_83', '4EME CIRCONSCRIPTION VAR', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_83', '5EME CIRCONSCRIPTION VAR', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_83', '6EME CIRCONSCRIPTION VAR', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_83', '7EME CIRCONSCRIPTION VAR', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('8_83', '8EME CIRCONSCRIPTION VAR', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_84', '1ERE CIRCONSCRIPTION VAUCLUSE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_84', '2EME CIRCONSCRIPTION VAUCLUSE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_84', '3EME CIRCONSCRIPTION VAUCLUSE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_84', '4EME CIRCONSCRIPTION VAUCLUSE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_84', '5EME CIRCONSCRIPTION VAUCLUSE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_85', '1ERE CIRCONSCRIPTION VENDEE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_85', '2EME CIRCONSCRIPTION VENDEE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_85', '3EME CIRCONSCRIPTION VENDEE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_85', '4EME CIRCONSCRIPTION VENDEE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_85', '5EME CIRCONSCRIPTION VENDEE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_86', '1ERE CIRCONSCRIPTION VIENNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_86', '2EME CIRCONSCRIPTION VIENNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_86', '3EME CIRCONSCRIPTION VIENNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_86', '4EME CIRCONSCRIPTION VIENNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_87', '1ERE CIRCONSCRIPTION HAUTE VIENNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_87', '2EME CIRCONSCRIPTION HAUTE VIENNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_87', '3EME CIRCONSCRIPTION HAUTE VIENNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_87', '4EME CIRCONSCRIPTION HAUTE VIENNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_88', '1ERE CIRCONSCRIPTION VOSGES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_88', '2EME CIRCONSCRIPTION VOSGES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_88', '3EME CIRCONSCRIPTION VOSGES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_88', '4EME CIRCONSCRIPTION VOSGES', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_89', '1ERE CIRCONSCRIPTION YONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_89', '2EME CIRCONSCRIPTION YONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_89', '3EME CIRCONSCRIPTION YONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_90', '1ERE CIRCONSCRIPTION TERRITOIRE DE BELFORT', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_90', '2EME CIRCONSCRIPTION TERRITOIRE DE BELFORT', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_91', '1ERE CIRCONSCRIPTION ESSONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_91', '2EME CIRCONSCRIPTION ESSONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_91', '3EME CIRCONSCRIPTION ESSONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_91', '4EME CIRCONSCRIPTION ESSONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_91', '5EME CIRCONSCRIPTION ESSONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_91', '6EME CIRCONSCRIPTION ESSONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_91', '7EME CIRCONSCRIPTION ESSONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('8_91', '8EME CIRCONSCRIPTION ESSONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('9_91', '9EME CIRCONSCRIPTION ESSONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('10_91', '10EME CIRCONSCRIPTION ESSONNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_92', '1ERE CIRCONSCRIPTION HAUTS DE SEINE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_92', '2EME CIRCONSCRIPTION HAUTS DE SEINE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_92', '3EME CIRCONSCRIPTION HAUTS DE SEINE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_92', '4EME CIRCONSCRIPTION HAUTS DE SEINE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_92', '5EME CIRCONSCRIPTION HAUTS DE SEINE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_92', '6EME CIRCONSCRIPTION HAUTS DE SEINE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_92', '7EME CIRCONSCRIPTION HAUTS DE SEINE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('8_92', '8EME CIRCONSCRIPTION HAUTS DE SEINE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('9_92', '9EME CIRCONSCRIPTION HAUTS DE SEINE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('10_92', '10EME CIRCONSCRIPTION HAUTS DE SEINE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('11_92', '11EME CIRCONSCRIPTION HAUTS DE SEINE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('12_92', '12EME CIRCONSCRIPTION HAUTS DE SEINE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('13_92', '13EME CIRCONSCRIPTION HAUTS DE SEINE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_93', '1ERE CIRCONSCRIPTION SEINE SAINT DENIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_93', '2EME CIRCONSCRIPTION SEINE SAINT DENIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_93', '3EME CIRCONSCRIPTION SEINE SAINT DENIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_93', '4EME CIRCONSCRIPTION SEINE SAINT DENIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_93', '5EME CIRCONSCRIPTION SEINE SAINT DENIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_93', '6EME CIRCONSCRIPTION SEINE SAINT DENIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_93', '7EME CIRCONSCRIPTION SEINE SAINT DENIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('8_93', '8EME CIRCONSCRIPTION SEINE SAINT DENIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('9_93', '9EME CIRCONSCRIPTION SEINE SAINT DENIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('10_93', '10EME CIRCONSCRIPTION SEINE SAINT DENIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('11_93', '11EME CIRCONSCRIPTION SEINE SAINT DENIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('12_93', '12EME CIRCONSCRIPTION SEINE SAINT DENIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('13_93', '13EME CIRCONSCRIPTION SEINE SAINT DENIS', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_94', '1ERE CIRCONSCRIPTION VAL DE MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_94', '2EME CIRCONSCRIPTION VAL DE MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_94', '3EME CIRCONSCRIPTION VAL DE MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_94', '4EME CIRCONSCRIPTION VAL DE MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_94', '5EME CIRCONSCRIPTION VAL DE MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_94', '6EME CIRCONSCRIPTION VAL DE MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_94', '7EME CIRCONSCRIPTION VAL DE MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('8_94', '8EME CIRCONSCRIPTION VAL DE MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('9_94', '9EME CIRCONSCRIPTION VAL DE MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('10_94', '10EME CIRCONSCRIPTION VAL DE MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('11_94', '11EME CIRCONSCRIPTION VAL DE MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('12_94', '12EME CIRCONSCRIPTION VAL DE MARNE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_95', '1ERE CIRCONSCRIPTION VAL D OISE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_95', '2EME CIRCONSCRIPTION VAL D OISE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_95', '3EME CIRCONSCRIPTION VAL D OISE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_95', '4EME CIRCONSCRIPTION VAL D OISE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_95', '5EME CIRCONSCRIPTION VAL D OISE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_95', '6EME CIRCONSCRIPTION VAL D OISE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_95', '7EME CIRCONSCRIPTION VAL D OISE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('8_95', '8EME CIRCONSCRIPTION VAL D OISE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('9_95', '9EME CIRCONSCRIPTION VAL D OISE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('10_95', '10EME CIRCONSCRIPTION VAL D OISE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_ZA', '1ERE CIRCONSCRIPTION GUADELOUPE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_ZA', '2EME CIRCONSCRIPTION GUADELOUPE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_ZA', '3EME CIRCONSCRIPTION GUADELOUPE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_ZA', '4EME CIRCONSCRIPTION GUADELOUPE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_ZB', '1ERE CIRCONSCRIPTION MARTINIQUE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_ZB', '2EME CIRCONSCRIPTION MARTINIQUE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_ZB', '3EME CIRCONSCRIPTION MARTINIQUE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_ZB', '4EME CIRCONSCRIPTION MARTINIQUE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_ZC', '1ERE CIRCONSCRIPTION GUYANE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_ZC', '2EME CIRCONSCRIPTION GUYANE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_ZD', '1ERE CIRCONSCRIPTION LA REUNION', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_ZD', '2EME CIRCONSCRIPTION LA REUNION', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_ZD', '3EME CIRCONSCRIPTION LA REUNION', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_ZD', '4EME CIRCONSCRIPTION LA REUNION', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_ZD', '5EME CIRCONSCRIPTION LA REUNION', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_ZD', '6EME CIRCONSCRIPTION LA REUNION', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_ZD', '7EME CIRCONSCRIPTION LA REUNION', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_ZM', '1ERE CIRCONSCRIPTION MAYOTTE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_ZM', '2EME CIRCONSCRIPTION MAYOTTE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_ZN', '1ERE CIRCONSCRIPTION NOUVELLE CALEDONIE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_ZN', '2EME CIRCONSCRIPTION NOUVELLE CALEDONIE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_ZP', '1ERE CIRCONSCRIPTION POLYNESIE FRANCAISE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_ZP', '2EME CIRCONSCRIPTION POLYNESIE FRANCAISE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_ZP', '3EME CIRCONSCRIPTION POLYNESIE FRANCAISE', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_ZS', 'SAINT PIERRE ET MIQUELON SAINT PIERRE ET MIQUELON', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_ZW', '1ERE CIRCONSCRIPTION WALLIS ET FUTUNA', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_ZX', '1ERE CIRCONSCRIPTION SAINT MARTIN SAINT BARTHELEMY', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('1_ZZ', '1ERE CIRCONSCRIPTION FRANCAIS DE L ETRANGER', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('2_ZZ', '2EME CIRCONSCRIPTION FRANCAIS DE L ETRANGER', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('3_ZZ', '3EME CIRCONSCRIPTION FRANCAIS DE L ETRANGER', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('4_ZZ', '4EME CIRCONSCRIPTION FRANCAIS DE L ETRANGER', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('5_ZZ', '5EME CIRCONSCRIPTION FRANCAIS DE L ETRANGER', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('6_ZZ', '6EME CIRCONSCRIPTION FRANCAIS DE L ETRANGER', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('7_ZZ', '7EME CIRCONSCRIPTION FRANCAIS DE L ETRANGER', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('8_ZZ', '8EME CIRCONSCRIPTION FRANCAIS DE L ETRANGER', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('9_ZZ', '9EME CIRCONSCRIPTION FRANCAIS DE L ETRANGER', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('10_ZZ', '10EME CIRCONSCRIPTION FRANCAIS DE L ETRANGER', 'Circonscription Legislative');
insert into "BREF"."Territoire"("CodeTerritoire", "NomTerritoire", "TypeTerritoire") values ('11_ZZ', '11EME CIRCONSCRIPTION FRANCAIS DE L ETRANGER', 'Circonscription Legislative');

update "BREF"."Territoire"
set "NomTerritoire" = '1ERE CIRCONSCRIPTION SAINT PIERRE ET MIQUELON'
where "NomTerritoire"= 'SAINT PIERRE ET MIQUELON SAINT PIERRE ET MIQUELON';

select max("IdInclusion") from "BREF"."Inclusion";
drop sequence "BREF".id_inclusion_seq cascade;
CREATE SEQUENCE "BREF".id_inclusion_seq;
SELECT setval('"BREF".id_inclusion_seq', 170827);
ALTER TABLE "BREF"."Inclusion" ALTER COLUMN "IdInclusion" SET DEFAULT
nextval('"BREF".id_inclusion_seq'::regclass);

insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66898', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '01' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66899', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '01' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66900', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '01' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66901', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '01' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66902', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '01' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66903', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '02' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66904', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '02' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66905', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '02' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66906', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '02' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66907', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '02' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66908', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '03' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66909', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '03' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66910', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '03' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66911', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '03' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66912', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '04' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66913', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '04' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66914', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '05' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66915', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '05' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66916', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '06' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66917', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '06' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66918', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '06' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66919', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '06' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66920', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '06' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66921', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '06' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66922', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '06' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66923', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '06' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66924', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '06' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66925', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '07' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66926', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '07' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66927', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '07' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66928', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '08' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66929', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '08' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66930', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '08' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66931', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '09' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66932', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '09' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66933', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '10' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66934', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '10' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66935', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '10' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66936', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '11' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66937', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '11' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66938', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '11' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66939', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '12' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66940', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '12' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66941', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '12' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66942', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '13' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66943', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '13' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66944', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '13' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66945', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '13' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66946', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '13' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66947', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '13' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66948', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '13' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66949', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '13' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66950', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '13' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66951', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '13' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66952', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '13' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66953', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '13' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66954', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '13' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66955', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '13' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66956', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '13' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66957', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '13' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66958', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '14' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66959', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '14' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66960', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '14' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66961', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '14' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66962', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '14' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66963', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '14' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66964', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '15' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66965', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '15' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66966', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '16' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66967', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '16' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66968', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '16' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66969', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '16' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66970', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '17' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66971', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '17' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66972', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '17' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66973', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '17' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66974', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '17' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66975', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '18' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66976', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '18' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66977', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '18' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66978', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '19' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66979', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '19' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66980', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '19' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66981', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '21' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66982', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '21' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66983', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '21' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66984', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '21' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66985', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '21' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66986', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '22' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66987', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '22' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66988', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '22' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66989', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '22' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66990', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '22' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66991', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '23' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66992', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '23' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66993', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '24' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66994', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '24' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66995', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '24' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66996', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '24' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66997', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '25' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66998', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '25' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '66999', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '25' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67000', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '25' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67001', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '25' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67002', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '26' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67003', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '26' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67004', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '26' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67005', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '26' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67006', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '27' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67007', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '27' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67008', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '27' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67009', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '27' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67010', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '27' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67011', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '28' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67012', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '28' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67013', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '28' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67014', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '28' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67015', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '29' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67016', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '29' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67017', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '29' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67018', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '29' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67019', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '29' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67020', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '29' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67021', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '29' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67022', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '29' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67023', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '2A' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67024', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '2A' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67025', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '2B' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67026', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '2B' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67027', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '30' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67028', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '30' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67029', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '30' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67030', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '30' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67031', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '30' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67032', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '30' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67033', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '31' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67034', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '31' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67035', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '31' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67036', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '31' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67037', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '31' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67038', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '31' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67039', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '31' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67040', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '31' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67041', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '31' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67042', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '31' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67043', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '32' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67044', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '32' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67045', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '33' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67046', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '33' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67047', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '33' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67048', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '33' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67049', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '33' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67050', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '33' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67051', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '33' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67052', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '33' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67053', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '33' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67054', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '33' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67055', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '33' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67056', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '33' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67057', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '34' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67058', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '34' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67059', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '34' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67060', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '34' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67061', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '34' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67062', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '34' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67063', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '34' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67064', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '34' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67065', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '34' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67066', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '35' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67067', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '35' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67068', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '35' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67069', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '35' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67070', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '35' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67071', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '35' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67072', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '35' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67073', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '35' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67074', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '36' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67075', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '36' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67076', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '36' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67077', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '37' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67078', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '37' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67079', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '37' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67080', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '37' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67081', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '37' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67082', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '38' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67083', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '38' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67084', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '38' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67085', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '38' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67086', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '38' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67087', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '38' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67088', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '38' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67089', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '38' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67090', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '38' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67091', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '38' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67092', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '39' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67093', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '39' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67094', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '39' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67095', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '40' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67096', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '40' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67097', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '40' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67098', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '41' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67099', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '41' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67100', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '41' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67101', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '42' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67102', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '42' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67103', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '42' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67104', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '42' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67105', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '42' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67106', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '42' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67107', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '42' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67108', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '43' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67109', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '43' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67110', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '44' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67111', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '44' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67112', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '44' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67113', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '44' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67114', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '44' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67115', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '44' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67116', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '44' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67117', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '44' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67118', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '44' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67119', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '44' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67120', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '45' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67121', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '45' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67122', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '45' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67123', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '45' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67124', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '45' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67125', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '45' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67126', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '46' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67127', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '46' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67128', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '47' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67129', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '47' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67130', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '47' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67131', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '48' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67132', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '48' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67133', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '49' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67134', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '49' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67135', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '49' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67136', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '49' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67137', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '49' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67138', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '49' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67139', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '49' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67140', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '50' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67141', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '50' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67142', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '50' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67143', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '50' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67144', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '50' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67145', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '51' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67146', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '51' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67147', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '51' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67148', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '51' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67149', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '51' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67150', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '51' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67151', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '52' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67152', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '52' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67153', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '53' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67154', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '53' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67155', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '53' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67156', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '54' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67157', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '54' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67158', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '54' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67159', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '54' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67160', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '54' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67161', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '54' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67162', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '54' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67163', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '55' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67164', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '55' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67165', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '56' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67166', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '56' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67167', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '56' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67168', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '56' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67169', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '56' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67170', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '56' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67171', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '57' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67172', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '57' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67173', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '57' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67174', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '57' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67175', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '57' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67176', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '57' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67177', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '57' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67178', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '57' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67179', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '57' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67180', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '57' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67181', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '58' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67182', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '58' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67183', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '58' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67184', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '59' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67185', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '59' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67186', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '59' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67187', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '59' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67188', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '59' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67189', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '59' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67190', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '59' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67191', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '59' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67192', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '59' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67193', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '59' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67194', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '59' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67195', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '59' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67196', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '59' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67197', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '59' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67198', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '59' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67199', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '59' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67200', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '59' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67201', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '59' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67202', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '59' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67203', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '59' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67204', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '59' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67205', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '59' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67206', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '59' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67207', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '59' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67208', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '60' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67209', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '60' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67210', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '60' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67211', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '60' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67212', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '60' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67213', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '60' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67214', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '60' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67215', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '61' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67216', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '61' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67217', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '61' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67218', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '62' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67219', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '62' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67220', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '62' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67221', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '62' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67222', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '62' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67223', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '62' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67224', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '62' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67225', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '62' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67226', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '62' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67227', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '62' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67228', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '62' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67229', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '62' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67230', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '62' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67231', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '62' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67232', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '63' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67233', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '63' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67234', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '63' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67235', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '63' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67236', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '63' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67237', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '63' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67238', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '64' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67239', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '64' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67240', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '64' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67241', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '64' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67242', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '64' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67243', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '64' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67244', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '65' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67245', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '65' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67246', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '65' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67247', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '66' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67248', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '66' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67249', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '66' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67250', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '66' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67251', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '67' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67252', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '67' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67253', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '67' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67254', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '67' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67255', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '67' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67256', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '67' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67257', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '67' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67258', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '67' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67259', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '67' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67260', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '68' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67261', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '68' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67262', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '68' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67263', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '68' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67264', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '68' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67265', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '68' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67266', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '68' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67267', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '69' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67268', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '69' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67269', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '69' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67270', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '69' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67271', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '69' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67272', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '69' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67273', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '69' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67274', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '69' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67275', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '69' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67276', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '69' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67277', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '69' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67278', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '69' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67279', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '69' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67280', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '69' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67281', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '70' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67282', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '70' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67283', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '70' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67284', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '71' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67285', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '71' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67286', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '71' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67287', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '71' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67288', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '71' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67289', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '71' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67290', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '72' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67291', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '72' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67292', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '72' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67293', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '72' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67294', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '72' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67295', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '73' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67296', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '73' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67297', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '73' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67298', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '73' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67299', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '74' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67300', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '74' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67301', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '74' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67302', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '74' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67303', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '74' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67304', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '74' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67305', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '75' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67306', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '75' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67307', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '75' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67308', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '75' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67309', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '75' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67310', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '75' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67311', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '75' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67312', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '75' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67313', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '75' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67314', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '75' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67315', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '75' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67316', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '75' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67317', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '75' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67318', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '75' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67319', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '75' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67320', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '75' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67321', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '75' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67322', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '75' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67323', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '75' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67324', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '75' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67325', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '75' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67326', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '76' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67327', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '76' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67328', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '76' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67329', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '76' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67330', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '76' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67331', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '76' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67332', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '76' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67333', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '76' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67334', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '76' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67335', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '76' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67336', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '76' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67337', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '76' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67338', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '77' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67339', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '77' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67340', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '77' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67341', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '77' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67342', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '77' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67343', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '77' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67344', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '77' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67345', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '77' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67346', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '77' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67347', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '77' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67348', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '77' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67349', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '78' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67350', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '78' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67351', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '78' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67352', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '78' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67353', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '78' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67354', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '78' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67355', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '78' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67356', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '78' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67357', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '78' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67358', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '78' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67359', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '78' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67360', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '78' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67361', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '79' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67362', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '79' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67363', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '79' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67364', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '79' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67365', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '80' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67366', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '80' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67367', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '80' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67368', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '80' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67369', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '80' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67370', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '80' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67371', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '81' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67372', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '81' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67373', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '81' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67374', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '81' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67375', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '82' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67376', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '82' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67377', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '83' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67378', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '83' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67379', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '83' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67380', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '83' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67381', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '83' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67382', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '83' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67383', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '83' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67384', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '83' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67385', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '84' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67386', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '84' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67387', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '84' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67388', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '84' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67389', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '84' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67390', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '85' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67391', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '85' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67392', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '85' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67393', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '85' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67394', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '85' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67395', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '86' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67396', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '86' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67397', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '86' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67398', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '86' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67399', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '87' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67400', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '87' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67401', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '87' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67402', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '87' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67403', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '88' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67404', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '88' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67405', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '88' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67406', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '88' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67407', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '89' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67408', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '89' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67409', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '89' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67410', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '90' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67411', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '90' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67412', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '91' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67413', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '91' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67414', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '91' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67415', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '91' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67416', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '91' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67417', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '91' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67418', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '91' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67419', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '91' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67420', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '91' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67421', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '91' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67422', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '92' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67423', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '92' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67424', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '92' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67425', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '92' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67426', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '92' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67427', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '92' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67428', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '92' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67429', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '92' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67430', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '92' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67431', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '92' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67432', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '92' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67433', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '92' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67434', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '92' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67435', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '93' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67436', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '93' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67437', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '93' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67438', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '93' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67439', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '93' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67440', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '93' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67441', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '93' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67442', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '93' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67443', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '93' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67444', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '93' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67445', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '93' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67446', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '93' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67447', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '93' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67448', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '94' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67449', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '94' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67450', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '94' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67451', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '94' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67452', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '94' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67453', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '94' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67454', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '94' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67455', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '94' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67456', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '94' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67457', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '94' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67458', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '94' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67459', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '94' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67460', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '95' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67461', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '95' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67462', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '95' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67463', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '95' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67464', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '95' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67465', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '95' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67466', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '95' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67467', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '95' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67468', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '95' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67469', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '95' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67470', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '971' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67471', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '971' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67472', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '971' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67473', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '971' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67474', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '972' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67475', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '972' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67476', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '972' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67477', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '972' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67478', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '973' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67479', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '973' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67480', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '974' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67481', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '974' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67482', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '974' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67483', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '974' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67484', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '974' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67485', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '974' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67486', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '974' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67487', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '976' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67488', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '976' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67489', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '988' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67490', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '988' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67491', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '987' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67492', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '987' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67493', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '987' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67494', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = '975' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67495', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = 'ZW' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67496', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = 'ZX' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67497', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = 'ZZ' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67498', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = 'ZZ' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67499', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = 'ZZ' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67500', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = 'ZZ' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67501', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = 'ZZ' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67502', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = 'ZZ' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67503', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = 'ZZ' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67504', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = 'ZZ' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67505', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = 'ZZ' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67506', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = 'ZZ' and "Actif" = true and "TypeTerritoire" = 'Département';
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire") select '67507', "IdTerritoire" from "BREF"."Territoire" where "Territoire"."CodeTerritoire" = 'ZZ' and "Actif" = true and "TypeTerritoire" = 'Département';


--modification des territoires dans la table mandats : remplacement des mauvaises circonscriptions législatives par les bonnes

select * from "BREF"."Mandat" where "Territoire_IdTerritoire" in
('66872',	'66873',	'66874',	'66875',	'66876',	'66877',	'66878',	'66879',	'66880',	'66881',	'66882',	'66883',	'66884',	'66885',	'66886',	'66887',	'66888',	'66889',	'66890',	'66891',	'66892',	'66893',	'66894',	'66895',	'66896');
--2542

update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_01' where "IdMandat" = 8556422;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_01' where "IdMandat" = 8556423;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_01' where "IdMandat" = 8556424;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_01' where "IdMandat" = 8556425;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_01' where "IdMandat" = 8556426;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_01' where "IdMandat" = 8556427;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_01' where "IdMandat" = 8556428;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_01' where "IdMandat" = 8556429;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_01' where "IdMandat" = 8556430;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_01' where "IdMandat" = 8556431;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_01' where "IdMandat" = 8556432;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_01' where "IdMandat" = 8556433;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_01' where "IdMandat" = 8556434;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_01' where "IdMandat" = 8556435;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_02' where "IdMandat" = 8556436;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_02' where "IdMandat" = 8556438;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_02' where "IdMandat" = 8556439;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_02' where "IdMandat" = 8556440;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_02' where "IdMandat" = 8556441;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_02' where "IdMandat" = 8556442;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_02' where "IdMandat" = 8556443;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_02' where "IdMandat" = 8556444;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_02' where "IdMandat" = 8556445;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_02' where "IdMandat" = 8556446;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_02' where "IdMandat" = 8556447;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_02' where "IdMandat" = 8556448;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_02' where "IdMandat" = 8556449;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_02' where "IdMandat" = 8556450;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_02' where "IdMandat" = 8556451;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_02' where "IdMandat" = 8556452;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_02' where "IdMandat" = 8556453;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_02' where "IdMandat" = 8556454;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_02' where "IdMandat" = 8556455;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_02' where "IdMandat" = 8556456;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_02' where "IdMandat" = 8556457;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_02' where "IdMandat" = 8556458;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_02' where "IdMandat" = 8556459;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_03' where "IdMandat" = 8556460;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_03' where "IdMandat" = 8556461;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_03' where "IdMandat" = 8556462;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_03' where "IdMandat" = 8556463;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_03' where "IdMandat" = 8556464;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_03' where "IdMandat" = 8556465;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_03' where "IdMandat" = 8556466;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_03' where "IdMandat" = 8556467;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_03' where "IdMandat" = 8556468;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_03' where "IdMandat" = 8556469;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_03' where "IdMandat" = 8556470;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_04' where "IdMandat" = 8556471;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_04' where "IdMandat" = 8556472;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_04' where "IdMandat" = 8556473;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_04' where "IdMandat" = 8556474;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_04' where "IdMandat" = 8556475;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_04' where "IdMandat" = 8556476;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_04' where "IdMandat" = 8556477;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_04' where "IdMandat" = 8556478;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_04' where "IdMandat" = 8556479;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_05' where "IdMandat" = 8556480;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_05' where "IdMandat" = 8556481;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_05' where "IdMandat" = 8556482;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_05' where "IdMandat" = 8556483;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_05' where "IdMandat" = 8556484;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_05' where "IdMandat" = 8556485;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_05' where "IdMandat" = 8556486;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_06' where "IdMandat" = 8556487;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_06' where "IdMandat" = 8556488;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_06' where "IdMandat" = 8556489;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_06' where "IdMandat" = 8556490;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_06' where "IdMandat" = 8556491;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_06' where "IdMandat" = 8556492;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_06' where "IdMandat" = 8556493;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_06' where "IdMandat" = 8556494;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_06' where "IdMandat" = 8556495;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_06' where "IdMandat" = 8556496;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_06' where "IdMandat" = 8556497;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_06' where "IdMandat" = 8556498;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_06' where "IdMandat" = 8556499;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_06' where "IdMandat" = 8556500;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_06' where "IdMandat" = 8556501;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_06' where "IdMandat" = 8556502;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_06' where "IdMandat" = 8556503;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_06' where "IdMandat" = 8556504;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_06' where "IdMandat" = 8556505;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_06' where "IdMandat" = 8556506;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_06' where "IdMandat" = 8556507;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_06' where "IdMandat" = 8556508;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_06' where "IdMandat" = 8556509;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_06' where "IdMandat" = 8556510;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_06' where "IdMandat" = 8556511;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_06' where "IdMandat" = 8556512;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_06' where "IdMandat" = 8556513;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_06' where "IdMandat" = 8556514;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_06' where "IdMandat" = 8556515;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_06' where "IdMandat" = 8556516;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_07' where "IdMandat" = 8556517;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_07' where "IdMandat" = 8556518;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_07' where "IdMandat" = 8556520;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_07' where "IdMandat" = 8556521;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_07' where "IdMandat" = 8556522;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_07' where "IdMandat" = 8556523;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_07' where "IdMandat" = 8556524;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_07' where "IdMandat" = 8556525;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_07' where "IdMandat" = 8556526;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_07' where "IdMandat" = 8556527;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_07' where "IdMandat" = 8556528;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_07' where "IdMandat" = 8556529;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_08' where "IdMandat" = 8556530;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_08' where "IdMandat" = 8556531;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_08' where "IdMandat" = 8556532;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_08' where "IdMandat" = 8556533;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_08' where "IdMandat" = 8556534;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_08' where "IdMandat" = 8556535;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_08' where "IdMandat" = 8556536;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_08' where "IdMandat" = 8556537;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_08' where "IdMandat" = 8556538;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_08' where "IdMandat" = 8556539;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_09' where "IdMandat" = 8556540;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_09' where "IdMandat" = 8556541;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_09' where "IdMandat" = 8556542;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_09' where "IdMandat" = 8556543;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_09' where "IdMandat" = 8556544;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_09' where "IdMandat" = 8556545;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_09' where "IdMandat" = 8556546;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_10' where "IdMandat" = 8556547;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_10' where "IdMandat" = 8556548;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_10' where "IdMandat" = 8556549;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_10' where "IdMandat" = 8556550;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_10' where "IdMandat" = 8556552;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_10' where "IdMandat" = 8556553;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_10' where "IdMandat" = 8556554;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_10' where "IdMandat" = 8556555;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_10' where "IdMandat" = 8556556;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_10' where "IdMandat" = 8556557;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_10' where "IdMandat" = 8556558;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_10' where "IdMandat" = 8556559;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_11' where "IdMandat" = 8556560;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_11' where "IdMandat" = 8556561;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_11' where "IdMandat" = 8556562;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_11' where "IdMandat" = 8556563;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_11' where "IdMandat" = 8556564;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_11' where "IdMandat" = 8556565;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_11' where "IdMandat" = 8556566;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_11' where "IdMandat" = 8556567;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_11' where "IdMandat" = 8556568;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_11' where "IdMandat" = 8556569;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_12' where "IdMandat" = 8556570;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_12' where "IdMandat" = 8556571;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_12' where "IdMandat" = 8556572;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_12' where "IdMandat" = 8556573;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_12' where "IdMandat" = 8556574;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_12' where "IdMandat" = 8556575;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_12' where "IdMandat" = 8556576;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_12' where "IdMandat" = 8556577;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_12' where "IdMandat" = 8556578;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_12' where "IdMandat" = 8556579;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_13' where "IdMandat" = 8556580;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_13' where "IdMandat" = 8556581;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_13' where "IdMandat" = 8556582;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_13' where "IdMandat" = 8556583;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_13' where "IdMandat" = 8556584;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_13' where "IdMandat" = 8556585;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_13' where "IdMandat" = 8556586;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_13' where "IdMandat" = 8556587;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_13' where "IdMandat" = 8556588;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_13' where "IdMandat" = 8556589;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_13' where "IdMandat" = 8556590;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_13' where "IdMandat" = 8556591;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_13' where "IdMandat" = 8556592;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '13_13' where "IdMandat" = 8556593;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '16_13' where "IdMandat" = 8556594;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '14_13' where "IdMandat" = 8556595;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_13' where "IdMandat" = 8556596;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_13' where "IdMandat" = 8556597;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '13_13' where "IdMandat" = 8556598;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_13' where "IdMandat" = 8556599;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_13' where "IdMandat" = 8556600;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_13' where "IdMandat" = 8556601;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_13' where "IdMandat" = 8556602;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_13' where "IdMandat" = 8556603;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_13' where "IdMandat" = 8556604;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_13' where "IdMandat" = 8556605;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '14_13' where "IdMandat" = 8556606;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '14_13' where "IdMandat" = 8556607;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_13' where "IdMandat" = 8556608;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_13' where "IdMandat" = 8556609;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_13' where "IdMandat" = 8556610;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_13' where "IdMandat" = 8556611;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_13' where "IdMandat" = 8556612;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_13' where "IdMandat" = 8556613;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_13' where "IdMandat" = 8556614;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_13' where "IdMandat" = 8556615;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_75' where "IdMandat" = 8556616;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_13' where "IdMandat" = 8556617;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_13' where "IdMandat" = 8556618;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_13' where "IdMandat" = 8556619;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_13' where "IdMandat" = 8556620;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '16_13' where "IdMandat" = 8556621;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_13' where "IdMandat" = 8556622;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '14_13' where "IdMandat" = 8556623;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_13' where "IdMandat" = 8556624;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_13' where "IdMandat" = 8556625;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '15_13' where "IdMandat" = 8556626;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '15_13' where "IdMandat" = 8556627;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_13' where "IdMandat" = 8556628;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_13' where "IdMandat" = 8556629;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_13' where "IdMandat" = 8556630;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_13' where "IdMandat" = 8556631;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_13' where "IdMandat" = 8556632;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '15_13' where "IdMandat" = 8556633;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '16_13' where "IdMandat" = 8556634;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '13_13' where "IdMandat" = 8556635;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '13_13' where "IdMandat" = 8556636;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_13' where "IdMandat" = 8556637;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_14' where "IdMandat" = 8556638;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_14' where "IdMandat" = 8556639;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_14' where "IdMandat" = 8556640;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_14' where "IdMandat" = 8556641;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_14' where "IdMandat" = 8556642;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_14' where "IdMandat" = 8556643;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_14' where "IdMandat" = 8556644;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_14' where "IdMandat" = 8556645;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_14' where "IdMandat" = 8556646;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_14' where "IdMandat" = 8556647;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_16' where "IdMandat" = 8556648;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_14' where "IdMandat" = 8556649;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_14' where "IdMandat" = 8556650;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_14' where "IdMandat" = 8556651;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_14' where "IdMandat" = 8556652;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_14' where "IdMandat" = 8556653;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_14' where "IdMandat" = 8556654;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_14' where "IdMandat" = 8556655;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_14' where "IdMandat" = 8556656;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_14' where "IdMandat" = 8556657;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_14' where "IdMandat" = 8556658;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_14' where "IdMandat" = 8556659;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_14' where "IdMandat" = 8556660;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_14' where "IdMandat" = 8556661;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_15' where "IdMandat" = 8556662;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_15' where "IdMandat" = 8556663;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_15' where "IdMandat" = 8556664;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_15' where "IdMandat" = 8556665;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_15' where "IdMandat" = 8556666;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_15' where "IdMandat" = 8556667;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_15' where "IdMandat" = 8556668;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_15' where "IdMandat" = 8556669;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_16' where "IdMandat" = 8556670;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_16' where "IdMandat" = 8556671;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_16' where "IdMandat" = 8556672;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_16' where "IdMandat" = 8556673;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_16' where "IdMandat" = 8556674;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_16' where "IdMandat" = 8556675;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_16' where "IdMandat" = 8556676;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_16' where "IdMandat" = 8556677;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_16' where "IdMandat" = 8556678;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_16' where "IdMandat" = 8556679;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_16' where "IdMandat" = 8556680;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_16' where "IdMandat" = 8556681;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_17' where "IdMandat" = 8556682;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_17' where "IdMandat" = 8556683;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_17' where "IdMandat" = 8556684;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_17' where "IdMandat" = 8556685;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_17' where "IdMandat" = 8556686;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_17' where "IdMandat" = 8556687;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_17' where "IdMandat" = 8556688;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_17' where "IdMandat" = 8556689;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_17' where "IdMandat" = 8556690;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_17' where "IdMandat" = 8556691;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_17' where "IdMandat" = 8556692;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_17' where "IdMandat" = 8556693;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_17' where "IdMandat" = 8556694;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_17' where "IdMandat" = 8556695;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_17' where "IdMandat" = 8556696;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_17' where "IdMandat" = 8556697;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_17' where "IdMandat" = 8556698;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_17' where "IdMandat" = 8556699;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_18' where "IdMandat" = 8556700;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_18' where "IdMandat" = 8556701;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_18' where "IdMandat" = 8556702;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_18' where "IdMandat" = 8556703;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_18' where "IdMandat" = 8556704;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_18' where "IdMandat" = 8556705;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_18' where "IdMandat" = 8556706;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_18' where "IdMandat" = 8556707;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_18' where "IdMandat" = 8556708;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_18' where "IdMandat" = 8556709;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_18' where "IdMandat" = 8556710;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_19' where "IdMandat" = 8556711;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_19' where "IdMandat" = 8556712;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_19' where "IdMandat" = 8556713;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_19' where "IdMandat" = 8556714;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_19' where "IdMandat" = 8556715;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_19' where "IdMandat" = 8556716;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_19' where "IdMandat" = 8556717;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_19' where "IdMandat" = 8556718;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_19' where "IdMandat" = 8556719;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_19' where "IdMandat" = 8556720;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_21' where "IdMandat" = 8556721;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_21' where "IdMandat" = 8556722;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_21' where "IdMandat" = 8556723;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_21' where "IdMandat" = 8556724;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_21' where "IdMandat" = 8556725;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_21' where "IdMandat" = 8556726;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_21' where "IdMandat" = 8556727;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_21' where "IdMandat" = 8556728;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_21' where "IdMandat" = 8556729;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_21' where "IdMandat" = 8556730;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_21' where "IdMandat" = 8556731;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_21' where "IdMandat" = 8556732;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_21' where "IdMandat" = 8556733;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_21' where "IdMandat" = 8556734;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_21' where "IdMandat" = 8556735;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_21' where "IdMandat" = 8556736;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_22' where "IdMandat" = 8556737;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_22' where "IdMandat" = 8556738;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_22' where "IdMandat" = 8556739;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_22' where "IdMandat" = 8556741;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_22' where "IdMandat" = 8556742;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_22' where "IdMandat" = 8556743;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_22' where "IdMandat" = 8556745;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_22' where "IdMandat" = 8556746;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_22' where "IdMandat" = 8556747;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_22' where "IdMandat" = 8556748;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_22' where "IdMandat" = 8556749;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_22' where "IdMandat" = 8556750;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_22' where "IdMandat" = 8556751;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_22' where "IdMandat" = 8556752;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_22' where "IdMandat" = 8556753;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_22' where "IdMandat" = 8556754;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_22' where "IdMandat" = 8556755;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_22' where "IdMandat" = 8556756;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_22' where "IdMandat" = 8556757;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_23' where "IdMandat" = 8556758;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_23' where "IdMandat" = 8556759;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_23' where "IdMandat" = 8556760;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_23' where "IdMandat" = 8556761;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_23' where "IdMandat" = 8556762;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_24' where "IdMandat" = 8556763;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_24' where "IdMandat" = 8556764;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_24' where "IdMandat" = 8556765;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_24' where "IdMandat" = 8556766;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_24' where "IdMandat" = 8556767;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_24' where "IdMandat" = 8556768;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_24' where "IdMandat" = 8556769;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_24' where "IdMandat" = 8556770;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_24' where "IdMandat" = 8556771;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_24' where "IdMandat" = 8556772;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_24' where "IdMandat" = 8556773;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_24' where "IdMandat" = 8556774;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_24' where "IdMandat" = 8556775;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_24' where "IdMandat" = 8556776;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_25' where "IdMandat" = 8556777;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_25' where "IdMandat" = 8556778;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_25' where "IdMandat" = 8556779;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_25' where "IdMandat" = 8556780;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_25' where "IdMandat" = 8556781;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_25' where "IdMandat" = 8556782;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_25' where "IdMandat" = 8556783;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_25' where "IdMandat" = 8556784;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_25' where "IdMandat" = 8556785;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_25' where "IdMandat" = 8556786;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_25' where "IdMandat" = 8556787;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_25' where "IdMandat" = 8556788;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_25' where "IdMandat" = 8556789;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_25' where "IdMandat" = 8556790;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_25' where "IdMandat" = 8556791;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_25' where "IdMandat" = 8556792;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_25' where "IdMandat" = 8556793;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_25' where "IdMandat" = 8556794;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_25' where "IdMandat" = 8556795;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_26' where "IdMandat" = 8556796;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_26' where "IdMandat" = 8556797;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_26' where "IdMandat" = 8556798;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_26' where "IdMandat" = 8556799;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_26' where "IdMandat" = 8556800;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_26' where "IdMandat" = 8556801;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_26' where "IdMandat" = 8556802;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_26' where "IdMandat" = 8556803;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_26' where "IdMandat" = 8556804;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_26' where "IdMandat" = 8556805;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_26' where "IdMandat" = 8556806;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_26' where "IdMandat" = 8556807;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_26' where "IdMandat" = 8556808;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_26' where "IdMandat" = 8556809;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_27' where "IdMandat" = 8556810;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_27' where "IdMandat" = 8556811;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_27' where "IdMandat" = 8556812;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_27' where "IdMandat" = 8556813;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_27' where "IdMandat" = 8556814;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_27' where "IdMandat" = 8556815;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_27' where "IdMandat" = 8556816;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_27' where "IdMandat" = 8556817;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_27' where "IdMandat" = 8556818;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_27' where "IdMandat" = 8556819;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_27' where "IdMandat" = 8556820;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_27' where "IdMandat" = 8556821;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_27' where "IdMandat" = 8556822;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_27' where "IdMandat" = 8556823;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_27' where "IdMandat" = 8556824;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_27' where "IdMandat" = 8556825;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_27' where "IdMandat" = 8556826;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_27' where "IdMandat" = 8556827;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_27' where "IdMandat" = 8556828;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_27' where "IdMandat" = 8556829;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_28' where "IdMandat" = 8556830;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_28' where "IdMandat" = 8556831;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_28' where "IdMandat" = 8556832;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_28' where "IdMandat" = 8556833;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_28' where "IdMandat" = 8556834;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_28' where "IdMandat" = 8556835;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_28' where "IdMandat" = 8556836;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_28' where "IdMandat" = 8556837;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_28' where "IdMandat" = 8556838;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_28' where "IdMandat" = 8556839;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_28' where "IdMandat" = 8556840;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_28' where "IdMandat" = 8556841;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_28' where "IdMandat" = 8556842;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_28' where "IdMandat" = 8556843;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_28' where "IdMandat" = 8556844;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_29' where "IdMandat" = 8556845;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_29' where "IdMandat" = 8556846;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_29' where "IdMandat" = 8556847;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_29' where "IdMandat" = 8556848;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_29' where "IdMandat" = 8556849;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_29' where "IdMandat" = 8556850;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_29' where "IdMandat" = 8556851;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_29' where "IdMandat" = 8556852;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_29' where "IdMandat" = 8556853;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_29' where "IdMandat" = 8556854;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_29' where "IdMandat" = 8556855;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_29' where "IdMandat" = 8556856;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_29' where "IdMandat" = 8556857;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_29' where "IdMandat" = 8556858;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_29' where "IdMandat" = 8556859;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_29' where "IdMandat" = 8556860;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_29' where "IdMandat" = 8556861;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_29' where "IdMandat" = 8556862;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_29' where "IdMandat" = 8556863;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_29' where "IdMandat" = 8556864;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_29' where "IdMandat" = 8556865;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_29' where "IdMandat" = 8556866;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_29' where "IdMandat" = 8556867;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_29' where "IdMandat" = 8556868;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_29' where "IdMandat" = 8556869;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_29' where "IdMandat" = 8556870;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_29' where "IdMandat" = 8556871;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_29' where "IdMandat" = 8556873;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_29' where "IdMandat" = 8556874;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_29' where "IdMandat" = 8556875;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_29' where "IdMandat" = 8556876;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_2A' where "IdMandat" = 8556877;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_2A' where "IdMandat" = 8556878;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_2A' where "IdMandat" = 8556879;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_2A' where "IdMandat" = 8556880;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_2A' where "IdMandat" = 8556881;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_2A' where "IdMandat" = 8556882;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_2B' where "IdMandat" = 8556883;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_2B' where "IdMandat" = 8556884;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_2B' where "IdMandat" = 8556885;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_2B' where "IdMandat" = 8556886;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_2B' where "IdMandat" = 8556887;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_2B' where "IdMandat" = 8556888;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_2B' where "IdMandat" = 8556889;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_30' where "IdMandat" = 8556890;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_30' where "IdMandat" = 8556891;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_30' where "IdMandat" = 8556892;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_30' where "IdMandat" = 8556893;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_30' where "IdMandat" = 8556894;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_30' where "IdMandat" = 8556895;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_30' where "IdMandat" = 8556896;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_30' where "IdMandat" = 8556897;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_30' where "IdMandat" = 8556898;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_30' where "IdMandat" = 8556899;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_30' where "IdMandat" = 8556900;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_30' where "IdMandat" = 8556901;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_30' where "IdMandat" = 8556902;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_30' where "IdMandat" = 8556903;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_30' where "IdMandat" = 8556904;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_30' where "IdMandat" = 8556906;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_30' where "IdMandat" = 8556907;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_30' where "IdMandat" = 8556908;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_30' where "IdMandat" = 8556909;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_30' where "IdMandat" = 8556910;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_30' where "IdMandat" = 8556911;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_31' where "IdMandat" = 8556912;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_31' where "IdMandat" = 8556913;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_31' where "IdMandat" = 8556914;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_31' where "IdMandat" = 8556915;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_31' where "IdMandat" = 8556916;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_31' where "IdMandat" = 8556917;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_31' where "IdMandat" = 8556918;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_31' where "IdMandat" = 8556919;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_31' where "IdMandat" = 8556920;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_31' where "IdMandat" = 8556921;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_31' where "IdMandat" = 8556922;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_31' where "IdMandat" = 8556923;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_31' where "IdMandat" = 8556924;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_31' where "IdMandat" = 8556925;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_31' where "IdMandat" = 8556926;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_31' where "IdMandat" = 8556927;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_31' where "IdMandat" = 8556928;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_31' where "IdMandat" = 8556929;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_31' where "IdMandat" = 8556930;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_31' where "IdMandat" = 8556931;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_31' where "IdMandat" = 8556932;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_31' where "IdMandat" = 8556933;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_31' where "IdMandat" = 8556934;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_31' where "IdMandat" = 8556935;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_31' where "IdMandat" = 8556936;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_31' where "IdMandat" = 8556937;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_31' where "IdMandat" = 8556938;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_31' where "IdMandat" = 8556939;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_31' where "IdMandat" = 8556940;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_31' where "IdMandat" = 8556941;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_31' where "IdMandat" = 8556942;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_31' where "IdMandat" = 8556943;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_31' where "IdMandat" = 8556944;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_31' where "IdMandat" = 8556945;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_31' where "IdMandat" = 8556946;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_31' where "IdMandat" = 8556947;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_32' where "IdMandat" = 8556948;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_32' where "IdMandat" = 8556949;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_32' where "IdMandat" = 8556950;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_32' where "IdMandat" = 8556951;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_32' where "IdMandat" = 8556952;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_32' where "IdMandat" = 8556953;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_32' where "IdMandat" = 8556954;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_32' where "IdMandat" = 8556955;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_33' where "IdMandat" = 8556956;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_33' where "IdMandat" = 8556957;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_33' where "IdMandat" = 8556958;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_33' where "IdMandat" = 8556959;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_33' where "IdMandat" = 8556960;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_33' where "IdMandat" = 8556961;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_33' where "IdMandat" = 8556962;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_33' where "IdMandat" = 8556963;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_33' where "IdMandat" = 8556964;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_33' where "IdMandat" = 8556965;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_33' where "IdMandat" = 8556966;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_33' where "IdMandat" = 8556967;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_33' where "IdMandat" = 8556968;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_33' where "IdMandat" = 8556969;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_33' where "IdMandat" = 8556970;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_33' where "IdMandat" = 8556971;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_33' where "IdMandat" = 8556972;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_33' where "IdMandat" = 8556973;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_33' where "IdMandat" = 8556974;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_33' where "IdMandat" = 8556975;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_33' where "IdMandat" = 8556976;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_33' where "IdMandat" = 8556977;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_33' where "IdMandat" = 8556978;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_33' where "IdMandat" = 8556979;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_33' where "IdMandat" = 8556980;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_33' where "IdMandat" = 8556981;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_33' where "IdMandat" = 8556982;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_33' where "IdMandat" = 8556983;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_33' where "IdMandat" = 8556984;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_33' where "IdMandat" = 8556985;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_33' where "IdMandat" = 8556986;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_33' where "IdMandat" = 8556987;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_33' where "IdMandat" = 8556988;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_33' where "IdMandat" = 8556989;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_33' where "IdMandat" = 8556990;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_33' where "IdMandat" = 8556991;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_33' where "IdMandat" = 8556992;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_33' where "IdMandat" = 8556993;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_33' where "IdMandat" = 8556994;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_33' where "IdMandat" = 8556995;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_33' where "IdMandat" = 8556996;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_33' where "IdMandat" = 8556997;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_33' where "IdMandat" = 8556998;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_33' where "IdMandat" = 8556999;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_34' where "IdMandat" = 8557000;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_34' where "IdMandat" = 8557001;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_34' where "IdMandat" = 8557002;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_34' where "IdMandat" = 8557003;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_34' where "IdMandat" = 8557004;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_34' where "IdMandat" = 8557005;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_34' where "IdMandat" = 8557006;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_34' where "IdMandat" = 8557007;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_34' where "IdMandat" = 8557008;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_34' where "IdMandat" = 8557009;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_34' where "IdMandat" = 8557010;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_34' where "IdMandat" = 8557011;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_34' where "IdMandat" = 8557012;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_34' where "IdMandat" = 8557013;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_34' where "IdMandat" = 8557014;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_34' where "IdMandat" = 8557015;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_34' where "IdMandat" = 8557016;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_34' where "IdMandat" = 8557017;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_34' where "IdMandat" = 8557018;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_34' where "IdMandat" = 8557019;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_34' where "IdMandat" = 8557020;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_34' where "IdMandat" = 8557021;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_34' where "IdMandat" = 8557022;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_34' where "IdMandat" = 8557023;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_34' where "IdMandat" = 8557024;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_34' where "IdMandat" = 8557025;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_34' where "IdMandat" = 8557026;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_34' where "IdMandat" = 8557027;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_34' where "IdMandat" = 8557028;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_34' where "IdMandat" = 8557029;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_34' where "IdMandat" = 8557030;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_34' where "IdMandat" = 8557031;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_35' where "IdMandat" = 8557032;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_35' where "IdMandat" = 8557033;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_35' where "IdMandat" = 8557035;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_35' where "IdMandat" = 8557036;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_35' where "IdMandat" = 8557037;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_35' where "IdMandat" = 8557038;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_35' where "IdMandat" = 8557039;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_35' where "IdMandat" = 8557040;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_35' where "IdMandat" = 8557041;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_35' where "IdMandat" = 8557042;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_35' where "IdMandat" = 8557043;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_35' where "IdMandat" = 8557044;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_35' where "IdMandat" = 8557045;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_35' where "IdMandat" = 8557046;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_35' where "IdMandat" = 8557047;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_35' where "IdMandat" = 8557048;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_35' where "IdMandat" = 8557049;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_35' where "IdMandat" = 8557050;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_35' where "IdMandat" = 8557051;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_35' where "IdMandat" = 8557052;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_35' where "IdMandat" = 8557053;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_35' where "IdMandat" = 8557054;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_35' where "IdMandat" = 8557055;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_35' where "IdMandat" = 8557056;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_35' where "IdMandat" = 8557057;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_35' where "IdMandat" = 8557058;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_35' where "IdMandat" = 8557059;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_36' where "IdMandat" = 8557060;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_36' where "IdMandat" = 8557061;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_36' where "IdMandat" = 8557062;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_36' where "IdMandat" = 8557063;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_36' where "IdMandat" = 8557064;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_36' where "IdMandat" = 8557065;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_36' where "IdMandat" = 8557066;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_36' where "IdMandat" = 8557067;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_36' where "IdMandat" = 8557068;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_36' where "IdMandat" = 8557069;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_37' where "IdMandat" = 8557070;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_37' where "IdMandat" = 8557071;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_37' where "IdMandat" = 8557072;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_37' where "IdMandat" = 8557073;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_37' where "IdMandat" = 8557074;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_37' where "IdMandat" = 8557075;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_37' where "IdMandat" = 8557076;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_37' where "IdMandat" = 8557077;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_37' where "IdMandat" = 8557078;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_37' where "IdMandat" = 8557079;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_37' where "IdMandat" = 8557080;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_37' where "IdMandat" = 8557081;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_37' where "IdMandat" = 8557082;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_37' where "IdMandat" = 8557083;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_37' where "IdMandat" = 8557084;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_37' where "IdMandat" = 8557085;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_37' where "IdMandat" = 8557086;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_37' where "IdMandat" = 8557087;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_37' where "IdMandat" = 8557088;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_37' where "IdMandat" = 8557089;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_37' where "IdMandat" = 8557090;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_37' where "IdMandat" = 8557091;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_37' where "IdMandat" = 8557092;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_38' where "IdMandat" = 8557093;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_38' where "IdMandat" = 8557094;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_38' where "IdMandat" = 8557095;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_38' where "IdMandat" = 8557096;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_38' where "IdMandat" = 8557097;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_38' where "IdMandat" = 8557098;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_38' where "IdMandat" = 8557099;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_38' where "IdMandat" = 8557100;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_38' where "IdMandat" = 8557101;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_38' where "IdMandat" = 8557102;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_38' where "IdMandat" = 8557103;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_38' where "IdMandat" = 8557104;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_38' where "IdMandat" = 8557105;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_38' where "IdMandat" = 8557106;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_38' where "IdMandat" = 8557107;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_38' where "IdMandat" = 8557108;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_38' where "IdMandat" = 8557109;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_38' where "IdMandat" = 8557110;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_38' where "IdMandat" = 8557111;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_38' where "IdMandat" = 8557112;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_38' where "IdMandat" = 8557113;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_38' where "IdMandat" = 8557114;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_38' where "IdMandat" = 8557115;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_38' where "IdMandat" = 8557116;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_38' where "IdMandat" = 8557117;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_38' where "IdMandat" = 8557118;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_38' where "IdMandat" = 8557119;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_38' where "IdMandat" = 8557120;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_38' where "IdMandat" = 8557121;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_38' where "IdMandat" = 8557122;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_38' where "IdMandat" = 8557123;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_38' where "IdMandat" = 8557124;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_38' where "IdMandat" = 8557125;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_38' where "IdMandat" = 8557126;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_38' where "IdMandat" = 8557127;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_39' where "IdMandat" = 8557129;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_39' where "IdMandat" = 8557130;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_39' where "IdMandat" = 8557131;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_39' where "IdMandat" = 8557132;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_39' where "IdMandat" = 8557133;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_39' where "IdMandat" = 8557134;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_39' where "IdMandat" = 8557135;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_39' where "IdMandat" = 8557136;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_40' where "IdMandat" = 8557137;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_40' where "IdMandat" = 8557138;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_40' where "IdMandat" = 8557139;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_40' where "IdMandat" = 8557140;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_40' where "IdMandat" = 8557141;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_40' where "IdMandat" = 8557142;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_40' where "IdMandat" = 8557143;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_40' where "IdMandat" = 8557144;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_40' where "IdMandat" = 8557145;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_40' where "IdMandat" = 8557146;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_40' where "IdMandat" = 8557147;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_40' where "IdMandat" = 8557148;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_40' where "IdMandat" = 8557149;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_41' where "IdMandat" = 8557150;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_41' where "IdMandat" = 8557151;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_41' where "IdMandat" = 8557152;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_41' where "IdMandat" = 8557153;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_41' where "IdMandat" = 8557154;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_41' where "IdMandat" = 8557155;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_41' where "IdMandat" = 8557156;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_41' where "IdMandat" = 8557157;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_41' where "IdMandat" = 8557158;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_41' where "IdMandat" = 8557159;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_41' where "IdMandat" = 8557160;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_41' where "IdMandat" = 8557161;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_41' where "IdMandat" = 8557162;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_41' where "IdMandat" = 8557163;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_42' where "IdMandat" = 8557164;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_42' where "IdMandat" = 8557165;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_42' where "IdMandat" = 8557166;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_42' where "IdMandat" = 8557167;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_42' where "IdMandat" = 8557168;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_42' where "IdMandat" = 8557169;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_42' where "IdMandat" = 8557170;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_42' where "IdMandat" = 8557171;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_42' where "IdMandat" = 8557172;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_42' where "IdMandat" = 8557173;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_42' where "IdMandat" = 8557174;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_42' where "IdMandat" = 8557175;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_42' where "IdMandat" = 8557176;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_42' where "IdMandat" = 8557177;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_42' where "IdMandat" = 8557178;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_42' where "IdMandat" = 8557179;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_42' where "IdMandat" = 8557180;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_42' where "IdMandat" = 8557181;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_42' where "IdMandat" = 8557182;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_42' where "IdMandat" = 8557183;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_42' where "IdMandat" = 8557184;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_43' where "IdMandat" = 8557185;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_43' where "IdMandat" = 8557186;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_43' where "IdMandat" = 8557187;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_43' where "IdMandat" = 8557188;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_43' where "IdMandat" = 8557189;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_43' where "IdMandat" = 8557190;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_43' where "IdMandat" = 8557191;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_43' where "IdMandat" = 8557192;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_44' where "IdMandat" = 8557193;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_44' where "IdMandat" = 8557194;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_44' where "IdMandat" = 8557195;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_44' where "IdMandat" = 8557196;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_44' where "IdMandat" = 8557197;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_44' where "IdMandat" = 8557198;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_44' where "IdMandat" = 8557199;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_44' where "IdMandat" = 8557200;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_44' where "IdMandat" = 8557201;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_44' where "IdMandat" = 8557202;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_44' where "IdMandat" = 8557203;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_44' where "IdMandat" = 8557204;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_44' where "IdMandat" = 8557205;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_44' where "IdMandat" = 8557206;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_44' where "IdMandat" = 8557208;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_44' where "IdMandat" = 8557209;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_44' where "IdMandat" = 8557210;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_44' where "IdMandat" = 8557211;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_44' where "IdMandat" = 8557212;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_44' where "IdMandat" = 8557213;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_44' where "IdMandat" = 8557214;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_44' where "IdMandat" = 8557215;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_44' where "IdMandat" = 8557216;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_44' where "IdMandat" = 8557217;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_44' where "IdMandat" = 8557218;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_44' where "IdMandat" = 8557219;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_44' where "IdMandat" = 8557220;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '15_75' where "IdMandat" = 8557221;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_44' where "IdMandat" = 8557222;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_44' where "IdMandat" = 8557223;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_44' where "IdMandat" = 8557224;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_44' where "IdMandat" = 8557225;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_44' where "IdMandat" = 8557226;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_44' where "IdMandat" = 8557227;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_44' where "IdMandat" = 8557228;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_44' where "IdMandat" = 8557229;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_44' where "IdMandat" = 8557230;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_44' where "IdMandat" = 8557231;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_44' where "IdMandat" = 8557232;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_44' where "IdMandat" = 8557233;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_45' where "IdMandat" = 8557234;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_45' where "IdMandat" = 8557235;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_45' where "IdMandat" = 8557236;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_45' where "IdMandat" = 8557237;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_45' where "IdMandat" = 8557238;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_45' where "IdMandat" = 8557239;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_45' where "IdMandat" = 8557240;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_45' where "IdMandat" = 8557241;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_45' where "IdMandat" = 8557242;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_45' where "IdMandat" = 8557243;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_45' where "IdMandat" = 8557244;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_45' where "IdMandat" = 8557245;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_45' where "IdMandat" = 8557246;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_45' where "IdMandat" = 8557247;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_45' where "IdMandat" = 8557248;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_45' where "IdMandat" = 8557249;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_45' where "IdMandat" = 8557250;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_45' where "IdMandat" = 8557251;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_45' where "IdMandat" = 8557252;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_46' where "IdMandat" = 8557253;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_46' where "IdMandat" = 8557254;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_46' where "IdMandat" = 8557255;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_46' where "IdMandat" = 8557256;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_46' where "IdMandat" = 8557257;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_46' where "IdMandat" = 8557258;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_47' where "IdMandat" = 8557259;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_47' where "IdMandat" = 8557260;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_47' where "IdMandat" = 8557261;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_47' where "IdMandat" = 8557262;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_47' where "IdMandat" = 8557263;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_47' where "IdMandat" = 8557264;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_47' where "IdMandat" = 8557265;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_47' where "IdMandat" = 8557266;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_47' where "IdMandat" = 8557267;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_47' where "IdMandat" = 8557268;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_47' where "IdMandat" = 8557269;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_47' where "IdMandat" = 8557270;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_47' where "IdMandat" = 8557271;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_47' where "IdMandat" = 8557272;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_48' where "IdMandat" = 8557273;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_48' where "IdMandat" = 8557274;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_48' where "IdMandat" = 8557275;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_48' where "IdMandat" = 8557276;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_48' where "IdMandat" = 8557277;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_49' where "IdMandat" = 8557278;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_49' where "IdMandat" = 8557279;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_49' where "IdMandat" = 8557280;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_49' where "IdMandat" = 8557281;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_49' where "IdMandat" = 8557282;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_49' where "IdMandat" = 8557283;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_49' where "IdMandat" = 8557284;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_49' where "IdMandat" = 8557285;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_49' where "IdMandat" = 8557286;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_49' where "IdMandat" = 8557287;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_49' where "IdMandat" = 8557288;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_49' where "IdMandat" = 8557289;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_49' where "IdMandat" = 8557290;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_49' where "IdMandat" = 8557291;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_49' where "IdMandat" = 8557292;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_49' where "IdMandat" = 8557293;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_49' where "IdMandat" = 8557294;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_49' where "IdMandat" = 8557295;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_49' where "IdMandat" = 8557296;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_49' where "IdMandat" = 8557297;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_49' where "IdMandat" = 8557298;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_49' where "IdMandat" = 8557299;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_49' where "IdMandat" = 8557300;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_50' where "IdMandat" = 8557301;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_50' where "IdMandat" = 8557302;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_50' where "IdMandat" = 8557303;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_50' where "IdMandat" = 8557304;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_50' where "IdMandat" = 8557305;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_50' where "IdMandat" = 8557306;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_50' where "IdMandat" = 8557307;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_50' where "IdMandat" = 8557308;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_50' where "IdMandat" = 8557309;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_50' where "IdMandat" = 8557310;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_50' where "IdMandat" = 8557311;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_50' where "IdMandat" = 8557312;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_50' where "IdMandat" = 8557313;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_50' where "IdMandat" = 8557314;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_50' where "IdMandat" = 8557315;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_50' where "IdMandat" = 8557317;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_50' where "IdMandat" = 8557318;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_51' where "IdMandat" = 8557319;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_51' where "IdMandat" = 8557320;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_51' where "IdMandat" = 8557321;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_51' where "IdMandat" = 8557322;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_51' where "IdMandat" = 8557323;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_51' where "IdMandat" = 8557324;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_51' where "IdMandat" = 8557325;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_51' where "IdMandat" = 8557326;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_51' where "IdMandat" = 8557327;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_51' where "IdMandat" = 8557328;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_51' where "IdMandat" = 8557329;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_51' where "IdMandat" = 8557330;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_51' where "IdMandat" = 8557331;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_51' where "IdMandat" = 8557332;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_51' where "IdMandat" = 8557333;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_51' where "IdMandat" = 8557334;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_51' where "IdMandat" = 8557335;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_51' where "IdMandat" = 8557336;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_51' where "IdMandat" = 8557337;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_51' where "IdMandat" = 8557338;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_52' where "IdMandat" = 8557339;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_52' where "IdMandat" = 8557340;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_52' where "IdMandat" = 8557341;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_52' where "IdMandat" = 8557342;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_52' where "IdMandat" = 8557343;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_52' where "IdMandat" = 8557344;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_53' where "IdMandat" = 8557345;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_53' where "IdMandat" = 8557346;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_53' where "IdMandat" = 8557347;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_53' where "IdMandat" = 8557348;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_53' where "IdMandat" = 8557349;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_53' where "IdMandat" = 8557350;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_53' where "IdMandat" = 8557351;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_53' where "IdMandat" = 8557352;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_53' where "IdMandat" = 8557353;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_53' where "IdMandat" = 8557354;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_53' where "IdMandat" = 8557355;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_54' where "IdMandat" = 8557356;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_54' where "IdMandat" = 8557357;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_54' where "IdMandat" = 8557358;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_54' where "IdMandat" = 8557359;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_54' where "IdMandat" = 8557360;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_54' where "IdMandat" = 8557361;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_54' where "IdMandat" = 8557362;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_54' where "IdMandat" = 8557363;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_54' where "IdMandat" = 8557364;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_54' where "IdMandat" = 8557365;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_54' where "IdMandat" = 8557366;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_54' where "IdMandat" = 8557367;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_54' where "IdMandat" = 8557368;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_54' where "IdMandat" = 8557369;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_54' where "IdMandat" = 8557370;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_54' where "IdMandat" = 8557371;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_54' where "IdMandat" = 8557372;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_54' where "IdMandat" = 8557373;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_54' where "IdMandat" = 8557374;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_54' where "IdMandat" = 8557375;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_54' where "IdMandat" = 8557376;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_54' where "IdMandat" = 8557377;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_54' where "IdMandat" = 8557378;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_54' where "IdMandat" = 8557379;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_54' where "IdMandat" = 8557380;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_55' where "IdMandat" = 8557381;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_55' where "IdMandat" = 8557382;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_55' where "IdMandat" = 8557383;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_55' where "IdMandat" = 8557384;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_55' where "IdMandat" = 8557385;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_55' where "IdMandat" = 8557386;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_56' where "IdMandat" = 8557387;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_56' where "IdMandat" = 8557388;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_56' where "IdMandat" = 8557389;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_56' where "IdMandat" = 8557390;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_56' where "IdMandat" = 8557391;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_56' where "IdMandat" = 8557392;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_56' where "IdMandat" = 8557393;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_56' where "IdMandat" = 8557394;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_56' where "IdMandat" = 8557395;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_56' where "IdMandat" = 8557396;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_56' where "IdMandat" = 8557397;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_56' where "IdMandat" = 8557398;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_56' where "IdMandat" = 8557399;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_56' where "IdMandat" = 8557400;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_56' where "IdMandat" = 8557401;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_56' where "IdMandat" = 8557402;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_56' where "IdMandat" = 8557403;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_56' where "IdMandat" = 8557404;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_56' where "IdMandat" = 8557405;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_56' where "IdMandat" = 8557406;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_56' where "IdMandat" = 8557407;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_56' where "IdMandat" = 8557408;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_56' where "IdMandat" = 8557409;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_57' where "IdMandat" = 8557410;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_57' where "IdMandat" = 8557412;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_57' where "IdMandat" = 8557413;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_57' where "IdMandat" = 8557414;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_57' where "IdMandat" = 8557415;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_57' where "IdMandat" = 8557416;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_57' where "IdMandat" = 8557417;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_57' where "IdMandat" = 8557418;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_57' where "IdMandat" = 8557419;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_57' where "IdMandat" = 8557420;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_57' where "IdMandat" = 8557421;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_57' where "IdMandat" = 8557422;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_57' where "IdMandat" = 8557423;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_57' where "IdMandat" = 8557424;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_57' where "IdMandat" = 8557425;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_57' where "IdMandat" = 8557426;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_57' where "IdMandat" = 8557427;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_57' where "IdMandat" = 8557428;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_57' where "IdMandat" = 8557429;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_57' where "IdMandat" = 8557430;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_57' where "IdMandat" = 8557431;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_57' where "IdMandat" = 8557432;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_57' where "IdMandat" = 8557433;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_57' where "IdMandat" = 8557434;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_57' where "IdMandat" = 8557435;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_57' where "IdMandat" = 8557436;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_57' where "IdMandat" = 8557437;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_57' where "IdMandat" = 8557438;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_57' where "IdMandat" = 8557439;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_57' where "IdMandat" = 8557440;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_57' where "IdMandat" = 8557441;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_57' where "IdMandat" = 8557442;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_57' where "IdMandat" = 8557443;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_57' where "IdMandat" = 8557444;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_57' where "IdMandat" = 8557445;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_57' where "IdMandat" = 8557446;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_58' where "IdMandat" = 8557447;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_58' where "IdMandat" = 8557448;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_58' where "IdMandat" = 8557449;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_58' where "IdMandat" = 8557450;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_58' where "IdMandat" = 8557451;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_58' where "IdMandat" = 8557452;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_58' where "IdMandat" = 8557453;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_58' where "IdMandat" = 8557454;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_58' where "IdMandat" = 8557455;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '15_59' where "IdMandat" = 8557456;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_59' where "IdMandat" = 8557457;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '22_59' where "IdMandat" = 8557458;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_59' where "IdMandat" = 8557459;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_59' where "IdMandat" = 8557460;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '20_59' where "IdMandat" = 8557461;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '20_59' where "IdMandat" = 8557462;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '21_59' where "IdMandat" = 8557463;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '21_59' where "IdMandat" = 8557464;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '18_59' where "IdMandat" = 8557465;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '16_59' where "IdMandat" = 8557466;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_59' where "IdMandat" = 8557467;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '16_59' where "IdMandat" = 8557468;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_59' where "IdMandat" = 8557469;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '19_59' where "IdMandat" = 8557470;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '14_59' where "IdMandat" = 8557471;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_59' where "IdMandat" = 8557472;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_59' where "IdMandat" = 8557473;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_59' where "IdMandat" = 8557474;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_59' where "IdMandat" = 8557475;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '15_59' where "IdMandat" = 8557477;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '23_59' where "IdMandat" = 8557478;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_59' where "IdMandat" = 8557479;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '14_59' where "IdMandat" = 8557480;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '21_59' where "IdMandat" = 8557481;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '24_59' where "IdMandat" = 8557482;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '13_59' where "IdMandat" = 8557483;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '13_59' where "IdMandat" = 8557484;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_59' where "IdMandat" = 8557485;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '15_59' where "IdMandat" = 8557486;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_59' where "IdMandat" = 8557487;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_59' where "IdMandat" = 8557488;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '21_59' where "IdMandat" = 8557489;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_59' where "IdMandat" = 8557490;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '17_59' where "IdMandat" = 8557491;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '17_59' where "IdMandat" = 8557492;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '19_59' where "IdMandat" = 8557493;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_59' where "IdMandat" = 8557494;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_59' where "IdMandat" = 8557495;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '21_59' where "IdMandat" = 8557496;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '21_59' where "IdMandat" = 8557497;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_59' where "IdMandat" = 8557498;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '16_59' where "IdMandat" = 8557499;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '15_59' where "IdMandat" = 8557500;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '17_59' where "IdMandat" = 8557501;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_59' where "IdMandat" = 8557502;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_59' where "IdMandat" = 8557503;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '13_59' where "IdMandat" = 8557504;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '13_59' where "IdMandat" = 8557505;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_59' where "IdMandat" = 8557506;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_59' where "IdMandat" = 8557507;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_59' where "IdMandat" = 8557508;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_59' where "IdMandat" = 8557509;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_59' where "IdMandat" = 8557510;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_59' where "IdMandat" = 8557511;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_59' where "IdMandat" = 8557512;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_59' where "IdMandat" = 8557513;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_59' where "IdMandat" = 8557514;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_59' where "IdMandat" = 8557515;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '19_59' where "IdMandat" = 8557516;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '23_59' where "IdMandat" = 8557517;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_59' where "IdMandat" = 8557518;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_59' where "IdMandat" = 8557519;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_59' where "IdMandat" = 8557520;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '24_59' where "IdMandat" = 8557521;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_59' where "IdMandat" = 8557522;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_59' where "IdMandat" = 8557523;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_59' where "IdMandat" = 8557524;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_59' where "IdMandat" = 8557525;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_59' where "IdMandat" = 8557526;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '20_59' where "IdMandat" = 8557527;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '19_59' where "IdMandat" = 8557528;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '19_59' where "IdMandat" = 8557529;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_59' where "IdMandat" = 8557530;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_59' where "IdMandat" = 8557531;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_59' where "IdMandat" = 8557532;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_59' where "IdMandat" = 8557533;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_59' where "IdMandat" = 8557534;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_59' where "IdMandat" = 8557535;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '18_59' where "IdMandat" = 8557536;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '18_59' where "IdMandat" = 8557537;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_60' where "IdMandat" = 8557538;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_60' where "IdMandat" = 8557539;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_60' where "IdMandat" = 8557540;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_60' where "IdMandat" = 8557541;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_60' where "IdMandat" = 8557542;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_75' where "IdMandat" = 8557543;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_60' where "IdMandat" = 8557544;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_60' where "IdMandat" = 8557545;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_60' where "IdMandat" = 8557546;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_60' where "IdMandat" = 8557547;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_60' where "IdMandat" = 8557548;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_60' where "IdMandat" = 8557549;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_60' where "IdMandat" = 8557550;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_60' where "IdMandat" = 8557551;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_60' where "IdMandat" = 8557552;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_60' where "IdMandat" = 8557553;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_60' where "IdMandat" = 8557554;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_60' where "IdMandat" = 8557555;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_60' where "IdMandat" = 8557556;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_60' where "IdMandat" = 8557557;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_60' where "IdMandat" = 8557558;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_60' where "IdMandat" = 8557559;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_60' where "IdMandat" = 8557560;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_60' where "IdMandat" = 8557561;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_60' where "IdMandat" = 8557562;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_60' where "IdMandat" = 8557563;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_61' where "IdMandat" = 8557564;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_61' where "IdMandat" = 8557565;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_61' where "IdMandat" = 8557566;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_61' where "IdMandat" = 8557567;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_61' where "IdMandat" = 8557568;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_61' where "IdMandat" = 8557569;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_61' where "IdMandat" = 8557570;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_61' where "IdMandat" = 8557571;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_61' where "IdMandat" = 8557572;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_61' where "IdMandat" = 8557573;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_62' where "IdMandat" = 8557574;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_62' where "IdMandat" = 8557575;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '13_62' where "IdMandat" = 8557576;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_62' where "IdMandat" = 8557577;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_62' where "IdMandat" = 8557578;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_62' where "IdMandat" = 8557579;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_62' where "IdMandat" = 8557580;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_62' where "IdMandat" = 8557581;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_62' where "IdMandat" = 8557582;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_62' where "IdMandat" = 8557583;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_62' where "IdMandat" = 8557584;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_62' where "IdMandat" = 8557585;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '13_62' where "IdMandat" = 8557586;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_62' where "IdMandat" = 8557587;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_62' where "IdMandat" = 8557588;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_62' where "IdMandat" = 8557589;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_62' where "IdMandat" = 8557590;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_62' where "IdMandat" = 8557591;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_62' where "IdMandat" = 8557592;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_62' where "IdMandat" = 8557593;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_62' where "IdMandat" = 8557594;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '14_62' where "IdMandat" = 8557595;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '14_62' where "IdMandat" = 8557596;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_62' where "IdMandat" = 8557597;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_62' where "IdMandat" = 8557598;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_62' where "IdMandat" = 8557599;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_62' where "IdMandat" = 8557600;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_62' where "IdMandat" = 8557601;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_62' where "IdMandat" = 8557602;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_62' where "IdMandat" = 8557603;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_62' where "IdMandat" = 8557604;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_62' where "IdMandat" = 8557605;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_62' where "IdMandat" = 8557606;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_62' where "IdMandat" = 8557607;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_62' where "IdMandat" = 8557608;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_62' where "IdMandat" = 8557609;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_62' where "IdMandat" = 8557610;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_62' where "IdMandat" = 8557611;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_62' where "IdMandat" = 8557612;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_62' where "IdMandat" = 8557613;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_62' where "IdMandat" = 8557614;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_62' where "IdMandat" = 8557615;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_62' where "IdMandat" = 8557616;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_62' where "IdMandat" = 8557617;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_62' where "IdMandat" = 8557618;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_62' where "IdMandat" = 8557619;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_62' where "IdMandat" = 8557620;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_62' where "IdMandat" = 8557621;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_62' where "IdMandat" = 8557622;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_63' where "IdMandat" = 8557623;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_63' where "IdMandat" = 8557624;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_63' where "IdMandat" = 8557625;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_63' where "IdMandat" = 8557626;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_63' where "IdMandat" = 8557627;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_63' where "IdMandat" = 8557628;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_63' where "IdMandat" = 8557629;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_63' where "IdMandat" = 8557630;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_63' where "IdMandat" = 8557631;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_63' where "IdMandat" = 8557632;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_63' where "IdMandat" = 8557633;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_63' where "IdMandat" = 8557634;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_63' where "IdMandat" = 8557635;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_63' where "IdMandat" = 8557636;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_63' where "IdMandat" = 8557637;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_63' where "IdMandat" = 8557638;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_63' where "IdMandat" = 8557639;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_63' where "IdMandat" = 8557640;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_63' where "IdMandat" = 8557641;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_63' where "IdMandat" = 8557642;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_63' where "IdMandat" = 8557643;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_63' where "IdMandat" = 8557644;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_64' where "IdMandat" = 8557645;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_64' where "IdMandat" = 8557646;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_64' where "IdMandat" = 8557647;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_64' where "IdMandat" = 8557648;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_64' where "IdMandat" = 8557649;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_64' where "IdMandat" = 8557650;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_64' where "IdMandat" = 8557651;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_64' where "IdMandat" = 8557652;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_64' where "IdMandat" = 8557653;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_64' where "IdMandat" = 8557654;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_64' where "IdMandat" = 8557655;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_64' where "IdMandat" = 8557656;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_64' where "IdMandat" = 8557657;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_64' where "IdMandat" = 8557658;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_64' where "IdMandat" = 8557659;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_64' where "IdMandat" = 8557660;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_64' where "IdMandat" = 8557661;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_64' where "IdMandat" = 8557662;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_64' where "IdMandat" = 8557663;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_64' where "IdMandat" = 8557664;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_64' where "IdMandat" = 8557665;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_64' where "IdMandat" = 8557666;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_64' where "IdMandat" = 8557667;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_65' where "IdMandat" = 8557668;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_65' where "IdMandat" = 8557669;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_65' where "IdMandat" = 8557670;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_65' where "IdMandat" = 8557671;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_65' where "IdMandat" = 8557672;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_65' where "IdMandat" = 8557673;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_65' where "IdMandat" = 8557674;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_65' where "IdMandat" = 8557675;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_65' where "IdMandat" = 8557676;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_66' where "IdMandat" = 8557677;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_66' where "IdMandat" = 8557678;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_66' where "IdMandat" = 8557679;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_66' where "IdMandat" = 8557680;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_66' where "IdMandat" = 8557681;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_66' where "IdMandat" = 8557682;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_66' where "IdMandat" = 8557683;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_66' where "IdMandat" = 8557684;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_66' where "IdMandat" = 8557685;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_66' where "IdMandat" = 8557686;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_66' where "IdMandat" = 8557687;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_66' where "IdMandat" = 8557688;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_66' where "IdMandat" = 8557689;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_66' where "IdMandat" = 8557690;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_66' where "IdMandat" = 8557691;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_66' where "IdMandat" = 8557692;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_66' where "IdMandat" = 8557693;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_67' where "IdMandat" = 8557694;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_67' where "IdMandat" = 8557695;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_67' where "IdMandat" = 8557696;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_67' where "IdMandat" = 8557697;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_67' where "IdMandat" = 8557698;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_67' where "IdMandat" = 8557699;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_67' where "IdMandat" = 8557700;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_67' where "IdMandat" = 8557701;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_67' where "IdMandat" = 8557702;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_67' where "IdMandat" = 8557703;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_67' where "IdMandat" = 8557704;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_67' where "IdMandat" = 8557705;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_67' where "IdMandat" = 8557706;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_67' where "IdMandat" = 8557707;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_67' where "IdMandat" = 8557708;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_67' where "IdMandat" = 8557709;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_67' where "IdMandat" = 8557710;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_67' where "IdMandat" = 8557711;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_67' where "IdMandat" = 8557712;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_67' where "IdMandat" = 8557713;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_67' where "IdMandat" = 8557714;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_67' where "IdMandat" = 8557715;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_67' where "IdMandat" = 8557716;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_67' where "IdMandat" = 8557717;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_67' where "IdMandat" = 8557718;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_67' where "IdMandat" = 8557719;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_67' where "IdMandat" = 8557720;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_67' where "IdMandat" = 8557721;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_68' where "IdMandat" = 8557722;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_68' where "IdMandat" = 8557723;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_68' where "IdMandat" = 8557724;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_68' where "IdMandat" = 8557725;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_68' where "IdMandat" = 8557726;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_68' where "IdMandat" = 8557727;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_68' where "IdMandat" = 8557728;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_68' where "IdMandat" = 8557729;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_68' where "IdMandat" = 8557730;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_68' where "IdMandat" = 8557731;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_68' where "IdMandat" = 8557732;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_68' where "IdMandat" = 8557733;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_68' where "IdMandat" = 8557734;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_68' where "IdMandat" = 8557735;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_68' where "IdMandat" = 8557736;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_68' where "IdMandat" = 8557737;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_68' where "IdMandat" = 8557738;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_68' where "IdMandat" = 8557739;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '14_69' where "IdMandat" = 8557740;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '14_69' where "IdMandat" = 8557741;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_69' where "IdMandat" = 8557742;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_69' where "IdMandat" = 8557743;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_69' where "IdMandat" = 8557744;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_69' where "IdMandat" = 8557745;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '13_69' where "IdMandat" = 8557746;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_69' where "IdMandat" = 8557747;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_69' where "IdMandat" = 8557748;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_69' where "IdMandat" = 8557749;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '13_69' where "IdMandat" = 8557750;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_69' where "IdMandat" = 8557751;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_69' where "IdMandat" = 8557752;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_69' where "IdMandat" = 8557753;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_69' where "IdMandat" = 8557754;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_69' where "IdMandat" = 8557755;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_69' where "IdMandat" = 8557756;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_69' where "IdMandat" = 8557757;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_69' where "IdMandat" = 8557758;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '14_69' where "IdMandat" = 8557759;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '14_69' where "IdMandat" = 8557760;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_69' where "IdMandat" = 8557761;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_69' where "IdMandat" = 8557762;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_69' where "IdMandat" = 8557763;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_69' where "IdMandat" = 8557764;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_69' where "IdMandat" = 8557765;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_69' where "IdMandat" = 8557766;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_69' where "IdMandat" = 8557767;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_69' where "IdMandat" = 8557768;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_69' where "IdMandat" = 8557769;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '13_69' where "IdMandat" = 8557770;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_69' where "IdMandat" = 8557771;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_69' where "IdMandat" = 8557772;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_69' where "IdMandat" = 8557773;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_69' where "IdMandat" = 8557774;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_69' where "IdMandat" = 8557775;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_69' where "IdMandat" = 8557776;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_69' where "IdMandat" = 8557777;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_69' where "IdMandat" = 8557778;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_69' where "IdMandat" = 8557779;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_69' where "IdMandat" = 8557780;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_69' where "IdMandat" = 8557781;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_69' where "IdMandat" = 8557782;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_69' where "IdMandat" = 8557783;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_69' where "IdMandat" = 8557784;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_69' where "IdMandat" = 8557785;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_69' where "IdMandat" = 8557786;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_69' where "IdMandat" = 8557787;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_69' where "IdMandat" = 8557788;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_70' where "IdMandat" = 8557789;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_70' where "IdMandat" = 8557790;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_70' where "IdMandat" = 8557791;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_70' where "IdMandat" = 8557792;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_70' where "IdMandat" = 8557793;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_70' where "IdMandat" = 8557794;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_70' where "IdMandat" = 8557795;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_70' where "IdMandat" = 8557796;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_70' where "IdMandat" = 8557797;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_70' where "IdMandat" = 8557798;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_71' where "IdMandat" = 8557799;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_71' where "IdMandat" = 8557800;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_71' where "IdMandat" = 8557801;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_71' where "IdMandat" = 8557802;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_71' where "IdMandat" = 8557803;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_71' where "IdMandat" = 8557804;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_71' where "IdMandat" = 8557805;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_71' where "IdMandat" = 8557806;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_71' where "IdMandat" = 8557807;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_71' where "IdMandat" = 8557808;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_71' where "IdMandat" = 8557809;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_71' where "IdMandat" = 8557810;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_71' where "IdMandat" = 8557811;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_71' where "IdMandat" = 8557812;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_71' where "IdMandat" = 8557813;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_71' where "IdMandat" = 8557814;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_71' where "IdMandat" = 8557815;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_71' where "IdMandat" = 8557816;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_71' where "IdMandat" = 8557817;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_71' where "IdMandat" = 8557818;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_71' where "IdMandat" = 8557819;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_72' where "IdMandat" = 8557820;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_72' where "IdMandat" = 8557821;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_72' where "IdMandat" = 8557822;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_72' where "IdMandat" = 8557823;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_72' where "IdMandat" = 8557824;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_72' where "IdMandat" = 8557825;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_72' where "IdMandat" = 8557826;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_72' where "IdMandat" = 8557827;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_72' where "IdMandat" = 8557828;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_72' where "IdMandat" = 8557829;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_72' where "IdMandat" = 8557830;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_72' where "IdMandat" = 8557831;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_72' where "IdMandat" = 8557832;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_72' where "IdMandat" = 8557833;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_72' where "IdMandat" = 8557834;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_72' where "IdMandat" = 8557835;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_72' where "IdMandat" = 8557836;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_72' where "IdMandat" = 8557837;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_72' where "IdMandat" = 8557838;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_72' where "IdMandat" = 8557839;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_73' where "IdMandat" = 8557840;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_73' where "IdMandat" = 8557841;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_73' where "IdMandat" = 8557842;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_73' where "IdMandat" = 8557843;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_73' where "IdMandat" = 8557844;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_73' where "IdMandat" = 8557845;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_73' where "IdMandat" = 8557846;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_73' where "IdMandat" = 8557847;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_73' where "IdMandat" = 8557848;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_73' where "IdMandat" = 8557849;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_73' where "IdMandat" = 8557850;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_74' where "IdMandat" = 8557851;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_74' where "IdMandat" = 8557852;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_74' where "IdMandat" = 8557853;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_74' where "IdMandat" = 8557854;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_74' where "IdMandat" = 8557855;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_74' where "IdMandat" = 8557856;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_74' where "IdMandat" = 8557857;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_74' where "IdMandat" = 8557858;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_74' where "IdMandat" = 8557859;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_74' where "IdMandat" = 8557861;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_74' where "IdMandat" = 8557862;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_74' where "IdMandat" = 8557863;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_74' where "IdMandat" = 8557864;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_74' where "IdMandat" = 8557865;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_74' where "IdMandat" = 8557866;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_75' where "IdMandat" = 8557867;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_75' where "IdMandat" = 8557868;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '21_75' where "IdMandat" = 8557869;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_75' where "IdMandat" = 8557870;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_75' where "IdMandat" = 8557871;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_75' where "IdMandat" = 8557872;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_75' where "IdMandat" = 8557873;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_75' where "IdMandat" = 8557874;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_75' where "IdMandat" = 8557875;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_75' where "IdMandat" = 8557876;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_75' where "IdMandat" = 8557877;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_75' where "IdMandat" = 8557878;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '18_75' where "IdMandat" = 8557879;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '20_75' where "IdMandat" = 8557880;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '20_75' where "IdMandat" = 8557881;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '16_75' where "IdMandat" = 8557882;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '18_75' where "IdMandat" = 8557883;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '18_75' where "IdMandat" = 8557884;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '15_75' where "IdMandat" = 8557885;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '21_75' where "IdMandat" = 8557886;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_75' where "IdMandat" = 8557887;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_75' where "IdMandat" = 8557888;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_75' where "IdMandat" = 8557889;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_75' where "IdMandat" = 8557890;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '16_75' where "IdMandat" = 8557891;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_75' where "IdMandat" = 8557892;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_75' where "IdMandat" = 8557894;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_75' where "IdMandat" = 8557895;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_75' where "IdMandat" = 8557896;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_75' where "IdMandat" = 8557897;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_75' where "IdMandat" = 8557898;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '13_75' where "IdMandat" = 8557899;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '14_75' where "IdMandat" = 8557900;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '14_75' where "IdMandat" = 8557901;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_75' where "IdMandat" = 8557902;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_75' where "IdMandat" = 8557903;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_75' where "IdMandat" = 8557904;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_75' where "IdMandat" = 8557905;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_75' where "IdMandat" = 8557906;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_75' where "IdMandat" = 8557907;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_75' where "IdMandat" = 8557908;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_75' where "IdMandat" = 8557910;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '13_75' where "IdMandat" = 8557911;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_75' where "IdMandat" = 8557912;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_75' where "IdMandat" = 8557913;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_75' where "IdMandat" = 8557914;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_75' where "IdMandat" = 8557915;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_75' where "IdMandat" = 8557916;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_75' where "IdMandat" = 8557917;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_75' where "IdMandat" = 8557918;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_75' where "IdMandat" = 8557919;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '17_75' where "IdMandat" = 8557920;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '17_75' where "IdMandat" = 8557921;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_75' where "IdMandat" = 8557922;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '16_75' where "IdMandat" = 8557923;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '16_75' where "IdMandat" = 8557924;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_75' where "IdMandat" = 8557925;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_75' where "IdMandat" = 8557926;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '16_75' where "IdMandat" = 8557927;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '17_75' where "IdMandat" = 8557928;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '21_75' where "IdMandat" = 8557929;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '15_75' where "IdMandat" = 8557930;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '15_75' where "IdMandat" = 8557931;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '15_75' where "IdMandat" = 8557932;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_75' where "IdMandat" = 8557933;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '13_75' where "IdMandat" = 8557934;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_75' where "IdMandat" = 8557935;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_75' where "IdMandat" = 8557936;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_75' where "IdMandat" = 8557937;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_75' where "IdMandat" = 8557938;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '19_75' where "IdMandat" = 8557939;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '19_75' where "IdMandat" = 8557940;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '17_75' where "IdMandat" = 8557941;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_76' where "IdMandat" = 8557942;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_76' where "IdMandat" = 8557943;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_76' where "IdMandat" = 8557944;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_76' where "IdMandat" = 8557945;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_76' where "IdMandat" = 8557946;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_76' where "IdMandat" = 8557947;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_76' where "IdMandat" = 8557948;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_76' where "IdMandat" = 8557949;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_76' where "IdMandat" = 8557950;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_76' where "IdMandat" = 8557951;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_76' where "IdMandat" = 8557952;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_76' where "IdMandat" = 8557953;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_76' where "IdMandat" = 8557954;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_76' where "IdMandat" = 8557955;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_76' where "IdMandat" = 8557957;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_76' where "IdMandat" = 8557958;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_76' where "IdMandat" = 8557959;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_76' where "IdMandat" = 8557960;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_76' where "IdMandat" = 8557961;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_76' where "IdMandat" = 8557962;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_76' where "IdMandat" = 8557963;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_76' where "IdMandat" = 8557964;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_76' where "IdMandat" = 8557965;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_76' where "IdMandat" = 8557966;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_76' where "IdMandat" = 8557967;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_76' where "IdMandat" = 8557968;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_76' where "IdMandat" = 8557969;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_76' where "IdMandat" = 8557970;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_76' where "IdMandat" = 8557971;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_76' where "IdMandat" = 8557972;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_76' where "IdMandat" = 8557973;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_76' where "IdMandat" = 8557974;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_76' where "IdMandat" = 8557975;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_76' where "IdMandat" = 8557976;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_76' where "IdMandat" = 8557977;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_76' where "IdMandat" = 8557978;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_76' where "IdMandat" = 8557979;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_76' where "IdMandat" = 8557980;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_76' where "IdMandat" = 8557981;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_76' where "IdMandat" = 8557982;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_76' where "IdMandat" = 8557983;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_76' where "IdMandat" = 8557984;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_76' where "IdMandat" = 8557985;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_77' where "IdMandat" = 8557986;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_77' where "IdMandat" = 8557987;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_77' where "IdMandat" = 8557988;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_77' where "IdMandat" = 8557989;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_77' where "IdMandat" = 8557990;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_77' where "IdMandat" = 8557991;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_77' where "IdMandat" = 8557992;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_77' where "IdMandat" = 8557993;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_77' where "IdMandat" = 8557994;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_77' where "IdMandat" = 8557995;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_77' where "IdMandat" = 8557996;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_77' where "IdMandat" = 8557997;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_77' where "IdMandat" = 8557998;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_77' where "IdMandat" = 8557999;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_77' where "IdMandat" = 8558000;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_77' where "IdMandat" = 8558001;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_77' where "IdMandat" = 8558002;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_77' where "IdMandat" = 8558003;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_77' where "IdMandat" = 8558004;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_77' where "IdMandat" = 8558005;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_77' where "IdMandat" = 8558006;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_77' where "IdMandat" = 8558007;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_77' where "IdMandat" = 8558008;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_77' where "IdMandat" = 8558009;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_77' where "IdMandat" = 8558010;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_77' where "IdMandat" = 8558011;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_77' where "IdMandat" = 8558012;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_77' where "IdMandat" = 8558013;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_77' where "IdMandat" = 8558014;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_77' where "IdMandat" = 8558015;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_77' where "IdMandat" = 8558016;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_77' where "IdMandat" = 8558017;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_77' where "IdMandat" = 8558018;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_77' where "IdMandat" = 8558019;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_77' where "IdMandat" = 8558020;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_77' where "IdMandat" = 8558021;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_77' where "IdMandat" = 8558022;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_78' where "IdMandat" = 8558023;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_78' where "IdMandat" = 8558024;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_78' where "IdMandat" = 8558025;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_78' where "IdMandat" = 8558026;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_78' where "IdMandat" = 8558027;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_78' where "IdMandat" = 8558028;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_78' where "IdMandat" = 8558029;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_78' where "IdMandat" = 8558030;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_78' where "IdMandat" = 8558031;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_78' where "IdMandat" = 8558032;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_78' where "IdMandat" = 8558033;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_78' where "IdMandat" = 8558034;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_78' where "IdMandat" = 8558035;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_78' where "IdMandat" = 8558036;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_78' where "IdMandat" = 8558037;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_78' where "IdMandat" = 8558038;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_78' where "IdMandat" = 8558039;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_78' where "IdMandat" = 8558040;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_78' where "IdMandat" = 8558041;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_78' where "IdMandat" = 8558042;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_78' where "IdMandat" = 8558043;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_78' where "IdMandat" = 8558044;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_78' where "IdMandat" = 8558045;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_78' where "IdMandat" = 8558046;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_78' where "IdMandat" = 8558047;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_78' where "IdMandat" = 8558048;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_78' where "IdMandat" = 8558049;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_78' where "IdMandat" = 8558050;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_78' where "IdMandat" = 8558051;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_78' where "IdMandat" = 8558052;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_78' where "IdMandat" = 8558053;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_78' where "IdMandat" = 8558054;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_78' where "IdMandat" = 8558055;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_78' where "IdMandat" = 8558056;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_78' where "IdMandat" = 8558057;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_78' where "IdMandat" = 8558058;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_78' where "IdMandat" = 8558059;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_78' where "IdMandat" = 8558060;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_78' where "IdMandat" = 8558061;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_78' where "IdMandat" = 8558062;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_78' where "IdMandat" = 8558063;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_78' where "IdMandat" = 8558064;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_78' where "IdMandat" = 8558065;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_78' where "IdMandat" = 8558066;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_78' where "IdMandat" = 8558067;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_78' where "IdMandat" = 8558068;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_78' where "IdMandat" = 8558069;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_78' where "IdMandat" = 8558070;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_78' where "IdMandat" = 8558071;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_78' where "IdMandat" = 8558072;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_78' where "IdMandat" = 8558073;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_78' where "IdMandat" = 8558074;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_78' where "IdMandat" = 8558075;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_78' where "IdMandat" = 8558076;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_79' where "IdMandat" = 8558077;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_79' where "IdMandat" = 8558078;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_79' where "IdMandat" = 8558079;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_79' where "IdMandat" = 8558080;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_79' where "IdMandat" = 8558081;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_79' where "IdMandat" = 8558082;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_79' where "IdMandat" = 8558083;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_79' where "IdMandat" = 8558084;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_79' where "IdMandat" = 8558085;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_79' where "IdMandat" = 8558086;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_79' where "IdMandat" = 8558087;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_79' where "IdMandat" = 8558088;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_79' where "IdMandat" = 8558089;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_80' where "IdMandat" = 8558090;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_80' where "IdMandat" = 8558091;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_80' where "IdMandat" = 8558092;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_80' where "IdMandat" = 8558093;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_80' where "IdMandat" = 8558094;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_80' where "IdMandat" = 8558095;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_80' where "IdMandat" = 8558096;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_80' where "IdMandat" = 8558097;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_80' where "IdMandat" = 8558098;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_80' where "IdMandat" = 8558099;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_80' where "IdMandat" = 8558100;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_80' where "IdMandat" = 8558101;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_80' where "IdMandat" = 8558102;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_80' where "IdMandat" = 8558103;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_80' where "IdMandat" = 8558104;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_80' where "IdMandat" = 8558105;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_80' where "IdMandat" = 8558106;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_80' where "IdMandat" = 8558107;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_80' where "IdMandat" = 8558108;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_80' where "IdMandat" = 8558109;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_80' where "IdMandat" = 8558110;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_80' where "IdMandat" = 8558111;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_81' where "IdMandat" = 8558112;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_81' where "IdMandat" = 8558113;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_81' where "IdMandat" = 8558114;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_81' where "IdMandat" = 8558115;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_81' where "IdMandat" = 8558116;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_81' where "IdMandat" = 8558117;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_81' where "IdMandat" = 8558118;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_81' where "IdMandat" = 8558119;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_81' where "IdMandat" = 8558120;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_81' where "IdMandat" = 8558121;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_81' where "IdMandat" = 8558122;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_81' where "IdMandat" = 8558123;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_81' where "IdMandat" = 8558124;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_81' where "IdMandat" = 8558125;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_82' where "IdMandat" = 8558126;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_82' where "IdMandat" = 8558127;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_82' where "IdMandat" = 8558128;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_82' where "IdMandat" = 8558129;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_82' where "IdMandat" = 8558130;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_82' where "IdMandat" = 8558131;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_82' where "IdMandat" = 8558132;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_82' where "IdMandat" = 8558133;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_82' where "IdMandat" = 8558134;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_83' where "IdMandat" = 8558135;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_83' where "IdMandat" = 8558136;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_83' where "IdMandat" = 8558137;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_83' where "IdMandat" = 8558138;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_83' where "IdMandat" = 8558139;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_83' where "IdMandat" = 8558140;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_83' where "IdMandat" = 8558141;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_83' where "IdMandat" = 8558142;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_83' where "IdMandat" = 8558143;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_83' where "IdMandat" = 8558144;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_83' where "IdMandat" = 8558145;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_83' where "IdMandat" = 8558146;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_83' where "IdMandat" = 8558147;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_83' where "IdMandat" = 8558148;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_83' where "IdMandat" = 8558149;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_83' where "IdMandat" = 8558150;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_83' where "IdMandat" = 8558151;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_84' where "IdMandat" = 8558152;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_84' where "IdMandat" = 8558153;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_84' where "IdMandat" = 8558154;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_84' where "IdMandat" = 8558155;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_84' where "IdMandat" = 8558156;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_84' where "IdMandat" = 8558157;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_84' where "IdMandat" = 8558158;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_84' where "IdMandat" = 8558159;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_84' where "IdMandat" = 8558160;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_84' where "IdMandat" = 8558161;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_84' where "IdMandat" = 8558162;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_84' where "IdMandat" = 8558163;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_84' where "IdMandat" = 8558164;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_84' where "IdMandat" = 8558165;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_84' where "IdMandat" = 8558166;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_84' where "IdMandat" = 8558167;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_84' where "IdMandat" = 8558168;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_84' where "IdMandat" = 8558169;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_84' where "IdMandat" = 8558170;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_84' where "IdMandat" = 8558171;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_84' where "IdMandat" = 8558172;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_85' where "IdMandat" = 8558173;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_85' where "IdMandat" = 8558174;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_85' where "IdMandat" = 8558175;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_85' where "IdMandat" = 8558176;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_85' where "IdMandat" = 8558177;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_85' where "IdMandat" = 8558178;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_85' where "IdMandat" = 8558179;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_85' where "IdMandat" = 8558180;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_85' where "IdMandat" = 8558181;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_85' where "IdMandat" = 8558182;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_85' where "IdMandat" = 8558183;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_85' where "IdMandat" = 8558184;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_85' where "IdMandat" = 8558185;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_85' where "IdMandat" = 8558186;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_85' where "IdMandat" = 8558187;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_85' where "IdMandat" = 8558188;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_85' where "IdMandat" = 8558189;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_85' where "IdMandat" = 8558190;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_85' where "IdMandat" = 8558191;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_86' where "IdMandat" = 8558192;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_86' where "IdMandat" = 8558193;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_86' where "IdMandat" = 8558194;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_86' where "IdMandat" = 8558195;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_86' where "IdMandat" = 8558196;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_86' where "IdMandat" = 8558197;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_86' where "IdMandat" = 8558198;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_86' where "IdMandat" = 8558199;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_86' where "IdMandat" = 8558200;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_86' where "IdMandat" = 8558201;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_86' where "IdMandat" = 8558202;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_86' where "IdMandat" = 8558203;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_86' where "IdMandat" = 8558204;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_87' where "IdMandat" = 8558205;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_87' where "IdMandat" = 8558206;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_87' where "IdMandat" = 8558207;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_87' where "IdMandat" = 8558208;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_87' where "IdMandat" = 8558209;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_87' where "IdMandat" = 8558210;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_87' where "IdMandat" = 8558211;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_87' where "IdMandat" = 8558212;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_87' where "IdMandat" = 8558213;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_87' where "IdMandat" = 8558214;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_87' where "IdMandat" = 8558215;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_87' where "IdMandat" = 8558216;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_87' where "IdMandat" = 8558217;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_87' where "IdMandat" = 8558218;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_88' where "IdMandat" = 8558219;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_88' where "IdMandat" = 8558220;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_88' where "IdMandat" = 8558221;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_88' where "IdMandat" = 8558222;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_88' where "IdMandat" = 8558223;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_88' where "IdMandat" = 8558224;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_88' where "IdMandat" = 8558225;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_88' where "IdMandat" = 8558226;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_88' where "IdMandat" = 8558227;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_88' where "IdMandat" = 8558228;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_88' where "IdMandat" = 8558229;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_89' where "IdMandat" = 8558230;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_89' where "IdMandat" = 8558231;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_89' where "IdMandat" = 8558232;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_89' where "IdMandat" = 8558233;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_89' where "IdMandat" = 8558234;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_89' where "IdMandat" = 8558235;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_89' where "IdMandat" = 8558236;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_89' where "IdMandat" = 8558237;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_89' where "IdMandat" = 8558238;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_89' where "IdMandat" = 8558239;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_90' where "IdMandat" = 8558240;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_90' where "IdMandat" = 8558241;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_90' where "IdMandat" = 8558242;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_90' where "IdMandat" = 8558243;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_90' where "IdMandat" = 8558244;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_90' where "IdMandat" = 8558245;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_90' where "IdMandat" = 8558246;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_91' where "IdMandat" = 8558247;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_91' where "IdMandat" = 8558248;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_91' where "IdMandat" = 8558249;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_91' where "IdMandat" = 8558250;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_91' where "IdMandat" = 8558251;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_91' where "IdMandat" = 8558252;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_91' where "IdMandat" = 8558253;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_91' where "IdMandat" = 8558254;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_91' where "IdMandat" = 8558255;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_91' where "IdMandat" = 8558256;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_91' where "IdMandat" = 8558257;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_91' where "IdMandat" = 8558258;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_91' where "IdMandat" = 8558259;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_91' where "IdMandat" = 8558260;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_91' where "IdMandat" = 8558261;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_91' where "IdMandat" = 8558262;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_91' where "IdMandat" = 8558263;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_91' where "IdMandat" = 8558264;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_91' where "IdMandat" = 8558265;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_91' where "IdMandat" = 8558266;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_91' where "IdMandat" = 8558267;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_91' where "IdMandat" = 8558268;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_91' where "IdMandat" = 8558269;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_91' where "IdMandat" = 8558270;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_91' where "IdMandat" = 8558271;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_91' where "IdMandat" = 8558272;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_91' where "IdMandat" = 8558273;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_91' where "IdMandat" = 8558274;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_91' where "IdMandat" = 8558276;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_91' where "IdMandat" = 8558277;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_91' where "IdMandat" = 8558278;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_91' where "IdMandat" = 8558279;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_91' where "IdMandat" = 8558280;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_91' where "IdMandat" = 8558281;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_91' where "IdMandat" = 8558282;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_91' where "IdMandat" = 8558283;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_91' where "IdMandat" = 8558284;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_91' where "IdMandat" = 8558285;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_91' where "IdMandat" = 8558286;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_91' where "IdMandat" = 8558287;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_91' where "IdMandat" = 8558288;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_91' where "IdMandat" = 8558289;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_91' where "IdMandat" = 8558290;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_91' where "IdMandat" = 8558291;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_92' where "IdMandat" = 8558292;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_92' where "IdMandat" = 8558293;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_92' where "IdMandat" = 8558294;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_92' where "IdMandat" = 8558295;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_92' where "IdMandat" = 8558296;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_92' where "IdMandat" = 8558297;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_92' where "IdMandat" = 8558298;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_92' where "IdMandat" = 8558299;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_92' where "IdMandat" = 8558300;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_92' where "IdMandat" = 8558301;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_92' where "IdMandat" = 8558302;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_92' where "IdMandat" = 8558303;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_92' where "IdMandat" = 8558304;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '13_92' where "IdMandat" = 8558305;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '13_92' where "IdMandat" = 8558306;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '13_92' where "IdMandat" = 8558307;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '13_92' where "IdMandat" = 8558308;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '13_92' where "IdMandat" = 8558309;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_92' where "IdMandat" = 8558310;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_92' where "IdMandat" = 8558311;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_92' where "IdMandat" = 8558312;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_92' where "IdMandat" = 8558313;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_92' where "IdMandat" = 8558314;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_92' where "IdMandat" = 8558315;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_92' where "IdMandat" = 8558316;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_92' where "IdMandat" = 8558317;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_92' where "IdMandat" = 8558318;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_92' where "IdMandat" = 8558319;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_92' where "IdMandat" = 8558320;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_92' where "IdMandat" = 8558321;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_92' where "IdMandat" = 8558322;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_92' where "IdMandat" = 8558323;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_92' where "IdMandat" = 8558324;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_92' where "IdMandat" = 8558325;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_92' where "IdMandat" = 8558326;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_92' where "IdMandat" = 8558327;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_92' where "IdMandat" = 8558328;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_92' where "IdMandat" = 8558329;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_92' where "IdMandat" = 8558330;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_92' where "IdMandat" = 8558331;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_92' where "IdMandat" = 8558332;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_92' where "IdMandat" = 8558333;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_92' where "IdMandat" = 8558334;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_92' where "IdMandat" = 8558335;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_92' where "IdMandat" = 8558336;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_92' where "IdMandat" = 8558337;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_92' where "IdMandat" = 8558338;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_92' where "IdMandat" = 8558339;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_92' where "IdMandat" = 8558341;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '13_92' where "IdMandat" = 8558342;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_92' where "IdMandat" = 8558343;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_92' where "IdMandat" = 8558344;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_92' where "IdMandat" = 8558345;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_92' where "IdMandat" = 8558346;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_93' where "IdMandat" = 8558347;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_93' where "IdMandat" = 8558348;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_93' where "IdMandat" = 8558349;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_93' where "IdMandat" = 8558350;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_93' where "IdMandat" = 8558351;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_93' where "IdMandat" = 8558352;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_93' where "IdMandat" = 8558353;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_93' where "IdMandat" = 8558354;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_93' where "IdMandat" = 8558355;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_93' where "IdMandat" = 8558356;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_93' where "IdMandat" = 8558357;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_93' where "IdMandat" = 8558358;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_93' where "IdMandat" = 8558359;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_93' where "IdMandat" = 8558360;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_93' where "IdMandat" = 8558361;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_93' where "IdMandat" = 8558362;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_93' where "IdMandat" = 8558363;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_93' where "IdMandat" = 8558364;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_93' where "IdMandat" = 8558365;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_93' where "IdMandat" = 8558366;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_93' where "IdMandat" = 8558367;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_93' where "IdMandat" = 8558368;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_93' where "IdMandat" = 8558369;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_93' where "IdMandat" = 8558370;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_39' where "IdMandat" = 8558371;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_93' where "IdMandat" = 8558372;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_93' where "IdMandat" = 8558373;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_93' where "IdMandat" = 8558374;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_93' where "IdMandat" = 8558375;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_93' where "IdMandat" = 8558376;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_93' where "IdMandat" = 8558377;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_93' where "IdMandat" = 8558378;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_93' where "IdMandat" = 8558379;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_93' where "IdMandat" = 8558380;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_93' where "IdMandat" = 8558381;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_93' where "IdMandat" = 8558382;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '13_93' where "IdMandat" = 8558383;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '13_93' where "IdMandat" = 8558384;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_93' where "IdMandat" = 8558385;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_93' where "IdMandat" = 8558386;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_93' where "IdMandat" = 8558387;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_93' where "IdMandat" = 8558388;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_93' where "IdMandat" = 8558389;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_93' where "IdMandat" = 8558390;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_93' where "IdMandat" = 8558391;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_93' where "IdMandat" = 8558392;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_93' where "IdMandat" = 8558393;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_93' where "IdMandat" = 8558394;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_93' where "IdMandat" = 8558395;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_94' where "IdMandat" = 8558396;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_94' where "IdMandat" = 8558397;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_94' where "IdMandat" = 8558398;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_94' where "IdMandat" = 8558399;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_94' where "IdMandat" = 8558400;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_94' where "IdMandat" = 8558401;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_94' where "IdMandat" = 8558403;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_94' where "IdMandat" = 8558404;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_94' where "IdMandat" = 8558405;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_94' where "IdMandat" = 8558406;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_94' where "IdMandat" = 8558407;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_94' where "IdMandat" = 8558408;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_94' where "IdMandat" = 8558409;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_94' where "IdMandat" = 8558410;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_94' where "IdMandat" = 8558411;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_94' where "IdMandat" = 8558412;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_94' where "IdMandat" = 8558413;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_94' where "IdMandat" = 8558414;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_94' where "IdMandat" = 8558415;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_94' where "IdMandat" = 8558416;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_94' where "IdMandat" = 8558417;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_94' where "IdMandat" = 8558418;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_94' where "IdMandat" = 8558419;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_94' where "IdMandat" = 8558420;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_94' where "IdMandat" = 8558421;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_94' where "IdMandat" = 8558422;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_94' where "IdMandat" = 8558423;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_94' where "IdMandat" = 8558424;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_94' where "IdMandat" = 8558425;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_94' where "IdMandat" = 8558426;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_94' where "IdMandat" = 8558427;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_94' where "IdMandat" = 8558428;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_94' where "IdMandat" = 8558429;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_94' where "IdMandat" = 8558430;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_94' where "IdMandat" = 8558431;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_94' where "IdMandat" = 8558432;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_94' where "IdMandat" = 8558433;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_94' where "IdMandat" = 8558435;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_94' where "IdMandat" = 8558436;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_94' where "IdMandat" = 8558437;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_94' where "IdMandat" = 8558438;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_95' where "IdMandat" = 8558439;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_95' where "IdMandat" = 8558440;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_95' where "IdMandat" = 8558441;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_95' where "IdMandat" = 8558442;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_95' where "IdMandat" = 8558443;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_95' where "IdMandat" = 8558444;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_95' where "IdMandat" = 8558445;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_95' where "IdMandat" = 8558446;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_95' where "IdMandat" = 8558447;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_95' where "IdMandat" = 8558448;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_95' where "IdMandat" = 8558449;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_95' where "IdMandat" = 8558450;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_95' where "IdMandat" = 8558451;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_95' where "IdMandat" = 8558452;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_95' where "IdMandat" = 8558453;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_95' where "IdMandat" = 8558454;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_95' where "IdMandat" = 8558455;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_95' where "IdMandat" = 8558456;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_95' where "IdMandat" = 8558457;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_95' where "IdMandat" = 8558458;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_95' where "IdMandat" = 8558459;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_95' where "IdMandat" = 8558460;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_95' where "IdMandat" = 8558461;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_95' where "IdMandat" = 8558462;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_95' where "IdMandat" = 8558463;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_95' where "IdMandat" = 8558464;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_95' where "IdMandat" = 8558465;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_95' where "IdMandat" = 8558466;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_95' where "IdMandat" = 8558468;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_95' where "IdMandat" = 8558469;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_95' where "IdMandat" = 8558470;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_95' where "IdMandat" = 8558471;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_95' where "IdMandat" = 8558472;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_95' where "IdMandat" = 8558473;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_95' where "IdMandat" = 8558474;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_ZA' where "IdMandat" = 8558475;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZA' where "IdMandat" = 8558476;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_ZA' where "IdMandat" = 8558477;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZA' where "IdMandat" = 8558478;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZA' where "IdMandat" = 8558479;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZA' where "IdMandat" = 8558480;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_ZA' where "IdMandat" = 8558481;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_ZA' where "IdMandat" = 8558482;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_ZA' where "IdMandat" = 8558483;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_ZA' where "IdMandat" = 8558484;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_ZA' where "IdMandat" = 8558485;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZA' where "IdMandat" = 8558486;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_ZA' where "IdMandat" = 8558487;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_ZA' where "IdMandat" = 8558488;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZB' where "IdMandat" = 8558489;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZB' where "IdMandat" = 8558490;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZB' where "IdMandat" = 8558491;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZB' where "IdMandat" = 8558492;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_ZB' where "IdMandat" = 8558493;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_ZB' where "IdMandat" = 8558494;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_ZB' where "IdMandat" = 8558495;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZB' where "IdMandat" = 8558496;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZB' where "IdMandat" = 8558497;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZB' where "IdMandat" = 8558498;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_ZB' where "IdMandat" = 8558499;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_ZB' where "IdMandat" = 8558500;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZB' where "IdMandat" = 8558501;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZB' where "IdMandat" = 8558502;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_ZB' where "IdMandat" = 8558503;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_ZB' where "IdMandat" = 8558504;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZC' where "IdMandat" = 8558505;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZC' where "IdMandat" = 8558506;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZC' where "IdMandat" = 8558507;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZC' where "IdMandat" = 8558508;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZC' where "IdMandat" = 8558509;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZC' where "IdMandat" = 8558510;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZC' where "IdMandat" = 8558511;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZC' where "IdMandat" = 8558512;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZC' where "IdMandat" = 8558513;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_ZD' where "IdMandat" = 8558514;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZD' where "IdMandat" = 8558515;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZD' where "IdMandat" = 8558516;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_ZD' where "IdMandat" = 8558517;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZD' where "IdMandat" = 8558518;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZD' where "IdMandat" = 8558519;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZD' where "IdMandat" = 8558520;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_ZD' where "IdMandat" = 8558521;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_ZD' where "IdMandat" = 8558522;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_ZD' where "IdMandat" = 8558523;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_ZD' where "IdMandat" = 8558524;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZD' where "IdMandat" = 8558525;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_ZD' where "IdMandat" = 8558526;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_ZD' where "IdMandat" = 8558527;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_ZD' where "IdMandat" = 8558528;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_ZD' where "IdMandat" = 8558530;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_ZD' where "IdMandat" = 8558531;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_ZD' where "IdMandat" = 8558532;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_ZD' where "IdMandat" = 8558533;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_ZD' where "IdMandat" = 8558534;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZD' where "IdMandat" = 8558535;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZD' where "IdMandat" = 8558536;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_ZD' where "IdMandat" = 8558537;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZM' where "IdMandat" = 8558538;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZM' where "IdMandat" = 8558539;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZM' where "IdMandat" = 8558540;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZM' where "IdMandat" = 8558541;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZM' where "IdMandat" = 8558542;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZM' where "IdMandat" = 8558543;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZM' where "IdMandat" = 8558544;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZN' where "IdMandat" = 8558545;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZN' where "IdMandat" = 8558546;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZN' where "IdMandat" = 8558547;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZN' where "IdMandat" = 8558548;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZN' where "IdMandat" = 8558549;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZN' where "IdMandat" = 8558550;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZN' where "IdMandat" = 8558551;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZN' where "IdMandat" = 8558552;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_ZP' where "IdMandat" = 8558553;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZP' where "IdMandat" = 8558554;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZP' where "IdMandat" = 8558555;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZP' where "IdMandat" = 8558556;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZP' where "IdMandat" = 8558557;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZP' where "IdMandat" = 8558558;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZP' where "IdMandat" = 8558559;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZP' where "IdMandat" = 8558560;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZP' where "IdMandat" = 8558562;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_ZP' where "IdMandat" = 8558563;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZP' where "IdMandat" = 8558564;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZS' where "IdMandat" = 8558565;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZS' where "IdMandat" = 8558566;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZS' where "IdMandat" = 8558567;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZS' where "IdMandat" = 8558568;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZS' where "IdMandat" = 8558569;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZS' where "IdMandat" = 8558570;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZW' where "IdMandat" = 8558571;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZW' where "IdMandat" = 8558572;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZW' where "IdMandat" = 8558573;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZW' where "IdMandat" = 8558574;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZW' where "IdMandat" = 8558575;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZX' where "IdMandat" = 8558576;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZX' where "IdMandat" = 8558577;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_ZZ' where "IdMandat" = 8558578;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_ZZ' where "IdMandat" = 8558579;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_ZZ' where "IdMandat" = 8558580;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_ZZ' where "IdMandat" = 8558581;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_ZZ' where "IdMandat" = 8558582;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZZ' where "IdMandat" = 8558583;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_ZZ' where "IdMandat" = 8558584;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZZ' where "IdMandat" = 8558585;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_ZZ' where "IdMandat" = 8558586;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_ZZ' where "IdMandat" = 8558587;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_ZZ' where "IdMandat" = 8558588;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_ZZ' where "IdMandat" = 8558589;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_ZZ' where "IdMandat" = 8558590;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_ZZ' where "IdMandat" = 8558591;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZZ' where "IdMandat" = 8558592;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_ZZ' where "IdMandat" = 8558593;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_ZZ' where "IdMandat" = 8558594;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_ZZ' where "IdMandat" = 8558595;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZZ' where "IdMandat" = 8558596;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_ZZ' where "IdMandat" = 8558597;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_ZZ' where "IdMandat" = 8558598;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZZ' where "IdMandat" = 8558599;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_ZZ' where "IdMandat" = 8558600;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_ZZ' where "IdMandat" = 8558601;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_ZZ' where "IdMandat" = 8558602;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_ZZ' where "IdMandat" = 8558603;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_ZZ' where "IdMandat" = 8558604;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_01' where "IdMandat" = 8558605;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_01' where "IdMandat" = 8558606;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_01' where "IdMandat" = 8558607;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_01' where "IdMandat" = 8558608;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_01' where "IdMandat" = 8558609;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_02' where "IdMandat" = 8558610;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_03' where "IdMandat" = 8558611;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_03' where "IdMandat" = 8558612;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_05' where "IdMandat" = 8558613;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_06' where "IdMandat" = 8558614;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_06' where "IdMandat" = 8558615;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_06' where "IdMandat" = 8558616;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_06' where "IdMandat" = 8558617;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_06' where "IdMandat" = 8558618;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_06' where "IdMandat" = 8558619;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_06' where "IdMandat" = 8558620;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_06' where "IdMandat" = 8558621;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_06' where "IdMandat" = 8558622;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_06' where "IdMandat" = 8558623;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_06' where "IdMandat" = 8558624;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_06' where "IdMandat" = 8558625;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_07' where "IdMandat" = 8558627;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_08' where "IdMandat" = 8558628;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_08' where "IdMandat" = 8558629;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_09' where "IdMandat" = 8558630;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_10' where "IdMandat" = 8558631;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_10' where "IdMandat" = 8558632;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_11' where "IdMandat" = 8558633;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_11' where "IdMandat" = 8558634;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_12' where "IdMandat" = 8558635;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_12' where "IdMandat" = 8558636;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_12' where "IdMandat" = 8558637;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_13' where "IdMandat" = 8558638;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_13' where "IdMandat" = 8558639;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_13' where "IdMandat" = 8558640;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_13' where "IdMandat" = 8558641;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '15_13' where "IdMandat" = 8558642;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_13' where "IdMandat" = 8558643;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_13' where "IdMandat" = 8558644;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_13' where "IdMandat" = 8558645;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_13' where "IdMandat" = 8558646;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '16_13' where "IdMandat" = 8558647;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_14' where "IdMandat" = 8558648;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_14' where "IdMandat" = 8558649;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_15' where "IdMandat" = 8558650;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_16' where "IdMandat" = 8558651;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_16' where "IdMandat" = 8558652;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_17' where "IdMandat" = 8558653;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_17' where "IdMandat" = 8558654;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_17' where "IdMandat" = 8558655;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_17' where "IdMandat" = 8558656;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_18' where "IdMandat" = 8558657;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_19' where "IdMandat" = 8558658;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_21' where "IdMandat" = 8558659;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_21' where "IdMandat" = 8558660;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_21' where "IdMandat" = 8558661;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_21' where "IdMandat" = 8558662;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_22' where "IdMandat" = 8558663;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_22' where "IdMandat" = 8558664;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_23' where "IdMandat" = 8558665;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_24' where "IdMandat" = 8558666;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_24' where "IdMandat" = 8558667;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_24' where "IdMandat" = 8558668;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_25' where "IdMandat" = 8558669;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_25' where "IdMandat" = 8558670;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_25' where "IdMandat" = 8558671;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_25' where "IdMandat" = 8558672;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_26' where "IdMandat" = 8558673;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_26' where "IdMandat" = 8558674;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_26' where "IdMandat" = 8558675;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_27' where "IdMandat" = 8558676;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_27' where "IdMandat" = 8558677;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_27' where "IdMandat" = 8558678;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_27' where "IdMandat" = 8558679;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_28' where "IdMandat" = 8558680;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_28' where "IdMandat" = 8558681;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_28' where "IdMandat" = 8558682;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_29' where "IdMandat" = 8558683;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_29' where "IdMandat" = 8558684;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_29' where "IdMandat" = 8558685;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_29' where "IdMandat" = 8558686;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_29' where "IdMandat" = 8558687;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_2A' where "IdMandat" = 8558688;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_2A' where "IdMandat" = 8558689;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_2B' where "IdMandat" = 8558690;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_30' where "IdMandat" = 8558691;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_31' where "IdMandat" = 8558692;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_31' where "IdMandat" = 8558693;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_31' where "IdMandat" = 8558694;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_31' where "IdMandat" = 8558695;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_31' where "IdMandat" = 8558696;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_31' where "IdMandat" = 8558697;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_32' where "IdMandat" = 8558698;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_32' where "IdMandat" = 8558699;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_33' where "IdMandat" = 8558700;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_33' where "IdMandat" = 8558701;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_33' where "IdMandat" = 8558702;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_33' where "IdMandat" = 8558703;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_33' where "IdMandat" = 8558704;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_33' where "IdMandat" = 8558705;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_34' where "IdMandat" = 8558706;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_34' where "IdMandat" = 8558707;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_35' where "IdMandat" = 8558708;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_35' where "IdMandat" = 8558709;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_35' where "IdMandat" = 8558710;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_37' where "IdMandat" = 8558711;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_37' where "IdMandat" = 8558712;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_38' where "IdMandat" = 8558713;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_38' where "IdMandat" = 8558714;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_38' where "IdMandat" = 8558715;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_38' where "IdMandat" = 8558716;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_38' where "IdMandat" = 8558717;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_38' where "IdMandat" = 8558718;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_38' where "IdMandat" = 8558719;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_39' where "IdMandat" = 8558720;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_39' where "IdMandat" = 8558721;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_39' where "IdMandat" = 8558722;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_40' where "IdMandat" = 8558723;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_40' where "IdMandat" = 8558724;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_40' where "IdMandat" = 8558725;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_41' where "IdMandat" = 8558726;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_41' where "IdMandat" = 8558727;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_41' where "IdMandat" = 8558728;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_41' where "IdMandat" = 8558729;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_41' where "IdMandat" = 8558730;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_41' where "IdMandat" = 8558731;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_42' where "IdMandat" = 8558732;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_42' where "IdMandat" = 8558733;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_42' where "IdMandat" = 8558734;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_42' where "IdMandat" = 8558735;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_42' where "IdMandat" = 8558736;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_42' where "IdMandat" = 8558737;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_43' where "IdMandat" = 8558738;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_44' where "IdMandat" = 8558739;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_44' where "IdMandat" = 8558740;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_44' where "IdMandat" = 8558741;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_44' where "IdMandat" = 8558742;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_44' where "IdMandat" = 8558743;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_44' where "IdMandat" = 8558744;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_45' where "IdMandat" = 8558745;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_45' where "IdMandat" = 8558746;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_45' where "IdMandat" = 8558747;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_45' where "IdMandat" = 8558748;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_45' where "IdMandat" = 8558749;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_46' where "IdMandat" = 8558750;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_46' where "IdMandat" = 8558751;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_47' where "IdMandat" = 8558752;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_48' where "IdMandat" = 8558753;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_49' where "IdMandat" = 8558755;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_49' where "IdMandat" = 8558756;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_49' where "IdMandat" = 8558757;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_49' where "IdMandat" = 8558758;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_49' where "IdMandat" = 8558759;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_49' where "IdMandat" = 8558760;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_49' where "IdMandat" = 8558761;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_49' where "IdMandat" = 8558762;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_50' where "IdMandat" = 8558763;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_50' where "IdMandat" = 8558764;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_51' where "IdMandat" = 8558765;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_51' where "IdMandat" = 8558766;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_51' where "IdMandat" = 8558767;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_51' where "IdMandat" = 8558768;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_52' where "IdMandat" = 8558769;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_52' where "IdMandat" = 8558770;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_52' where "IdMandat" = 8558771;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_53' where "IdMandat" = 8558772;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_53' where "IdMandat" = 8558773;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_53' where "IdMandat" = 8558774;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_54' where "IdMandat" = 8558775;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_54' where "IdMandat" = 8558776;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_54' where "IdMandat" = 8558777;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_55' where "IdMandat" = 8558778;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_55' where "IdMandat" = 8558779;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_56' where "IdMandat" = 8558780;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_56' where "IdMandat" = 8558781;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_57' where "IdMandat" = 8558782;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_57' where "IdMandat" = 8558783;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_57' where "IdMandat" = 8558784;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_57' where "IdMandat" = 8558785;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_57' where "IdMandat" = 8558786;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_57' where "IdMandat" = 8558787;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_58' where "IdMandat" = 8558788;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_59' where "IdMandat" = 8558789;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '22_59' where "IdMandat" = 8558790;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '20_59' where "IdMandat" = 8558791;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '21_59' where "IdMandat" = 8558792;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '16_59' where "IdMandat" = 8558793;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_59' where "IdMandat" = 8558794;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '14_59' where "IdMandat" = 8558795;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '14_59' where "IdMandat" = 8558796;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '17_59' where "IdMandat" = 8558797;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_59' where "IdMandat" = 8558798;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_59' where "IdMandat" = 8558799;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_59' where "IdMandat" = 8558800;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_59' where "IdMandat" = 8558801;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_59' where "IdMandat" = 8558802;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_59' where "IdMandat" = 8558803;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_59' where "IdMandat" = 8558804;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '18_59' where "IdMandat" = 8558805;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_60' where "IdMandat" = 8558806;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_60' where "IdMandat" = 8558807;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_60' where "IdMandat" = 8558808;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_60' where "IdMandat" = 8558809;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_60' where "IdMandat" = 8558810;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_60' where "IdMandat" = 8558811;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_60' where "IdMandat" = 8558812;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_60' where "IdMandat" = 8558813;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_61' where "IdMandat" = 8558814;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_61' where "IdMandat" = 8558815;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_62' where "IdMandat" = 8558816;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_62' where "IdMandat" = 8558817;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_62' where "IdMandat" = 8558818;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_62' where "IdMandat" = 8558819;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_62' where "IdMandat" = 8558820;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_63' where "IdMandat" = 8558821;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_63' where "IdMandat" = 8558822;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_63' where "IdMandat" = 8558823;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_64' where "IdMandat" = 8558824;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_64' where "IdMandat" = 8558825;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_64' where "IdMandat" = 8558826;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_65' where "IdMandat" = 8558827;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_66' where "IdMandat" = 8558828;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_67' where "IdMandat" = 8558829;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_67' where "IdMandat" = 8558830;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_67' where "IdMandat" = 8558831;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_67' where "IdMandat" = 8558832;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_67' where "IdMandat" = 8558833;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_67' where "IdMandat" = 8558834;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_67' where "IdMandat" = 8558835;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_67' where "IdMandat" = 8558836;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_67' where "IdMandat" = 8558837;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_68' where "IdMandat" = 8558838;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_68' where "IdMandat" = 8558839;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_68' where "IdMandat" = 8558840;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_68' where "IdMandat" = 8558841;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_68' where "IdMandat" = 8558842;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_68' where "IdMandat" = 8558843;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_68' where "IdMandat" = 8558844;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_68' where "IdMandat" = 8558845;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_69' where "IdMandat" = 8558846;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_69' where "IdMandat" = 8558847;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_69' where "IdMandat" = 8558848;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_69' where "IdMandat" = 8558849;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_69' where "IdMandat" = 8558850;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '13_69' where "IdMandat" = 8558851;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_69' where "IdMandat" = 8558852;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_69' where "IdMandat" = 8558853;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_69' where "IdMandat" = 8558854;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_69' where "IdMandat" = 8558855;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_70' where "IdMandat" = 8558856;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_70' where "IdMandat" = 8558857;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_71' where "IdMandat" = 8558858;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_72' where "IdMandat" = 8558859;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_72' where "IdMandat" = 8558860;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_72' where "IdMandat" = 8558861;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_73' where "IdMandat" = 8558862;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_73' where "IdMandat" = 8558863;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_73' where "IdMandat" = 8558864;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_74' where "IdMandat" = 8558865;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_74' where "IdMandat" = 8558866;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_74' where "IdMandat" = 8558867;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_74' where "IdMandat" = 8558868;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_74' where "IdMandat" = 8558869;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_74' where "IdMandat" = 8558870;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_74' where "IdMandat" = 8558871;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_75' where "IdMandat" = 8558872;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_75' where "IdMandat" = 8558873;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '18_75' where "IdMandat" = 8558874;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '16_75' where "IdMandat" = 8558875;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '15_75' where "IdMandat" = 8558876;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '14_75' where "IdMandat" = 8558877;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '14_75' where "IdMandat" = 8558878;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_75' where "IdMandat" = 8558879;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_75' where "IdMandat" = 8558880;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '13_75' where "IdMandat" = 8558881;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_75' where "IdMandat" = 8558882;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_75' where "IdMandat" = 8558883;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_75' where "IdMandat" = 8558884;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_76' where "IdMandat" = 8558885;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_76' where "IdMandat" = 8558886;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_76' where "IdMandat" = 8558887;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_76' where "IdMandat" = 8558888;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '12_76' where "IdMandat" = 8558889;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_76' where "IdMandat" = 8558890;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_76' where "IdMandat" = 8558891;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_77' where "IdMandat" = 8558892;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_77' where "IdMandat" = 8558893;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_77' where "IdMandat" = 8558894;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_77' where "IdMandat" = 8558895;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_77' where "IdMandat" = 8558896;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_77' where "IdMandat" = 8558897;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_77' where "IdMandat" = 8558898;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_78' where "IdMandat" = 8558899;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_78' where "IdMandat" = 8558900;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_78' where "IdMandat" = 8558901;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_78' where "IdMandat" = 8558902;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_78' where "IdMandat" = 8558903;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_78' where "IdMandat" = 8558904;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_78' where "IdMandat" = 8558905;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_78' where "IdMandat" = 8558906;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_79' where "IdMandat" = 8558907;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_79' where "IdMandat" = 8558908;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_79' where "IdMandat" = 8558909;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_80' where "IdMandat" = 8558910;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_80' where "IdMandat" = 8558911;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_82' where "IdMandat" = 8558912;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_83' where "IdMandat" = 8558913;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_83' where "IdMandat" = 8558914;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_83' where "IdMandat" = 8558915;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_83' where "IdMandat" = 8558916;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_83' where "IdMandat" = 8558917;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_83' where "IdMandat" = 8558918;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_83' where "IdMandat" = 8558919;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_83' where "IdMandat" = 8558920;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_83' where "IdMandat" = 8558921;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_83' where "IdMandat" = 8558922;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_83' where "IdMandat" = 8558923;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_83' where "IdMandat" = 8558924;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_83' where "IdMandat" = 8558925;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_84' where "IdMandat" = 8558926;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_85' where "IdMandat" = 8558927;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_85' where "IdMandat" = 8558928;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_85' where "IdMandat" = 8558929;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_86' where "IdMandat" = 8558930;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_86' where "IdMandat" = 8558931;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_86' where "IdMandat" = 8558932;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_87' where "IdMandat" = 8558933;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_88' where "IdMandat" = 8558934;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_88' where "IdMandat" = 8558935;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_88' where "IdMandat" = 8558936;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_88' where "IdMandat" = 8558937;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_88' where "IdMandat" = 8558938;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_89' where "IdMandat" = 8558939;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_90' where "IdMandat" = 8558940;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_90' where "IdMandat" = 8558941;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_91' where "IdMandat" = 8558942;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_91' where "IdMandat" = 8558943;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_91' where "IdMandat" = 8558944;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_91' where "IdMandat" = 8558945;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_91' where "IdMandat" = 8558946;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_91' where "IdMandat" = 8558947;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_91' where "IdMandat" = 8558948;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_92' where "IdMandat" = 8558949;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_92' where "IdMandat" = 8558950;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_92' where "IdMandat" = 8558951;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '13_92' where "IdMandat" = 8558952;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_92' where "IdMandat" = 8558953;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_92' where "IdMandat" = 8558954;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_92' where "IdMandat" = 8558955;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_92' where "IdMandat" = 8558956;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_92' where "IdMandat" = 8558957;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_92' where "IdMandat" = 8558958;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '10_92' where "IdMandat" = 8558959;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_92' where "IdMandat" = 8558960;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_92' where "IdMandat" = 8558961;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_93' where "IdMandat" = 8558962;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_93' where "IdMandat" = 8558963;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_93' where "IdMandat" = 8558964;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_93' where "IdMandat" = 8558965;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_94' where "IdMandat" = 8558966;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_94' where "IdMandat" = 8558967;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_94' where "IdMandat" = 8558968;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_94' where "IdMandat" = 8558969;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_94' where "IdMandat" = 8558970;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '11_94' where "IdMandat" = 8558971;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_94' where "IdMandat" = 8558972;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '9_94' where "IdMandat" = 8558973;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '7_95' where "IdMandat" = 8558974;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_95' where "IdMandat" = 8558975;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_95' where "IdMandat" = 8558976;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '8_95' where "IdMandat" = 8558977;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '6_95' where "IdMandat" = 8558978;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZA' where "IdMandat" = 8558979;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZA' where "IdMandat" = 8558981;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZA' where "IdMandat" = 8558982;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_ZA' where "IdMandat" = 8558983;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '3_ZB' where "IdMandat" = 8558984;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZC' where "IdMandat" = 8558985;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '2_ZD' where "IdMandat" = 8558986;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '5_ZD' where "IdMandat" = 8558987;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '4_ZD' where "IdMandat" = 8558988;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZS' where "IdMandat" = 8558989;
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1_ZW' where "IdMandat" = 8558990;

--suppression des mauvaises circonscriptions législatives
delete from "BREF"."Territoire" where "IdTerritoire" in
('66872',	'66873',	'66874',	'66875',	'66876',	'66877',	'66878',	'66879',	'66880',	'66881',	'66882',	'66883',	'66884',	'66885',	'66886',	'66887',	'66888',	'66889',	'66890',	'66891',	'66892',	'66893',	'66894',	'66895',	'66896');



-- ****** other cleanings ***

--insertion des départements français de l’étranger (anciens et nouveaux) il faudra réattribuer les mandats existants et supprimer le département existant
insert into "BREF"."Territoire"("IdTerritoire", "NomTerritoire", "TypeTerritoire", "CodeTerritoire", "DateLiee", "Actif")
values ('1947_ZZA', 'FRANCAIS DE L ETRANGER A', 'Département', 'ZZA', '01/01/2009', false);
insert into "BREF"."Territoire"("IdTerritoire", "NomTerritoire", "TypeTerritoire", "CodeTerritoire", "DateLiee", "Actif")
values ('1947_ZZB', 'FRANCAIS DE L ETRANGER B', 'Département', 'ZZB', '01/01/2009', false);
insert into "BREF"."Territoire"("IdTerritoire", "NomTerritoire", "TypeTerritoire", "CodeTerritoire", "DateLiee", "Actif")
values ('1947_ZZC', 'FRANCAIS DE L ETRANGER C', 'Département', 'ZZC', '01/01/2009', false);
insert into "BREF"."Territoire"("IdTerritoire", "NomTerritoire", "TypeTerritoire", "CodeTerritoire", "Actif")
values ('2009_ZZ1', 'FRANCAIS DE L ETRANGER 1', 'Département', 'ZZ1', true);
insert into "BREF"."Territoire"("IdTerritoire", "NomTerritoire", "TypeTerritoire", "CodeTerritoire", "Actif")
values ('2009_ZZ2', 'FRANCAIS DE L ETRANGER 2', 'Département', 'ZZ2', true);

--correction erreurs dans 04 - circonscription législatives
update "BREF"."Mandat" set "Territoire_IdTerritoire" =
"BREF"."Territoire"."IdTerritoire" from "BREF"."Territoire"
where "TypeTerritoire" = 'Circonscription Legislative' and "BREF"."Territoire"."CodeTerritoire" = "BREF"."Mandat"."Territoire_IdTerritoire";
update "BREF"."Territoire" set "TypeTerritoire" = 'Circonscription Législative'
where  "TypeTerritoire" = 'Circonscription Legislative';

--activation de Boulogne-sur-Mer, Desvres
update "BREF"."Territoire" set "DateLiee" = NULL, "Actif" = true where "IdTerritoire" = '49564';
update "BREF"."Territoire" set "DateLiee" = NULL, "Actif" = true where "IdTerritoire" = '47910';
update "BREF"."Territoire" set "DateLiee" = NULL, "Actif" = true where "IdTerritoire" = '41079';

--réaffectation des mandats
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '49564' where "Territoire_IdTerritoire" = '55531';
--135
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '47910' where "Territoire_IdTerritoire" = '44337';
--87
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '41079' where "Territoire_IdTerritoire" = '54934';
--83

--suppression des mauvaises communes
delete from "BREF"."Territoire" where "IdTerritoire" in
('55531',    '61957',	'52105',	'49033',	'36644',	'59092',	'45823',    '64137',	'47860',	'48995',	'44516',	'38576',	'46600');
delete from "BREF"."Territoire" where "IdTerritoire" in
('44337',	'51046',	'43304',	'40273',	'64732',	'55648',	'50678',	'39157',	'65648');
delete from "BREF"."Territoire" where "IdTerritoire" in
('54934',	'47430',	'47528',	'39744',	'34543',	'47627',	'53137',	'60915');

update "BREF"."Territoire"
set "Actif" = false, "DateLiee" = '01/01/1976'
where "IdTerritoire" = '1790_19';
update "BREF"."Territoire"
set "IdTerritoire" = '1976_19', "Actif" = true
where "IdTerritoire" = '1793_19';
update "BREF"."Territoire"
set "IdTerritoire" = '1976_90', "Actif" = true
where "IdTerritoire" = '1793_90';
insert into "BREF"."Territoire" ("IdTerritoire", "NomTerritoire", "TypeTerritoire", "Actif")
values ('1982_19', 'CORSE', 'Collectivité territoriale', true);
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire")
values ('1976_90', '1982_19');
insert into "BREF"."Inclusion" ("TerritoireInclu_IdTerritoire", "TerritoireIncluant_IdTerritoire")
values ('1976_19', '1982_19');

--Ajout des départements qui existe pas dans BREF.
INSERT INTO "BREF"."Territoire" values('1957_9B','BATNA','Département','9B','1962-01-01',false);
INSERT INTO "BREF"."Territoire" values('1958_9P','BOUGIE','Département','9P','1959-01-01',false);
INSERT INTO "BREF"."Territoire" values('1957_9M','TLEMCEN','Département','9M','1962-01-01',false);
INSERT INTO "BREF"."Territoire" values('1957_9K','TIARET','Département','9K','1962-01-01',false);
INSERT INTO "BREF"."Territoire" values('1957_9E','MEDEA','Département','9E','1962-01-01',false);
	
SELECT max("IdTerritoire")
FROM "BREF"."Territoire"
WHERE "TypeTerritoire" not in ('Canton','EPCI')
-- 67507


--Pour l'idTerritoire n'est pas sous-forme de 'date creation_codeterritoire' comme les autres départements, car je trouve pas la date de creation et codeterritoire
INSERT INTO "BREF"."Territoire" values('67508','TCHAD','Pays',  NULL,'1960-08-11',false);
INSERT INTO "BREF"."Territoire" values('67509','SOUDAN','Pays',NULL,'1960-06-20',false);
INSERT INTO "BREF"."Territoire" values('67510','SENEGAL','Pays',NULL,'1960-11-25',false);
INSERT INTO "BREF"."Territoire" values('67511','OUBANGUI CHARI TCHAD','Pays',NULL,'1960-08-13',false);
INSERT INTO "BREF"."Territoire" values('67512','NIGER','Pays',NULL,'1960-08-03',false);
INSERT INTO "BREF"."Territoire" values('67513','MOYEN CONGO/GABON','Pays',NULL,'1960-08-15',false);
INSERT INTO "BREF"."Territoire" values('67514','MAURITANIE','Pays',NULL,'1960-11-28',false);
INSERT INTO "BREF"."Territoire" values('67515','MADAGASCAR','Pays',NULL,'1960-06-26',false);
INSERT INTO "BREF"."Territoire" values('67516','HAUTE VOLTA','Pays',NULL,'1960-08-05',false);
INSERT INTO "BREF"."Territoire" values('67517','GABON','Pays',NULL,'1960-08-17',false);
INSERT INTO "BREF"."Territoire" values('67518','DAHOMEY','Pays',NULL,'1960-08-01',false);
INSERT INTO "BREF"."Territoire" values('67519','COTE D IVOIRE','Pays',NULL,'1960-08-07',false);
	
--Ajout de la Circonscription europeen TRAITE LISBONNE
INSERT INTO "BREF"."Territoire" values('67520','TRAITE LISBONNE','Circonscription Européenne','9',null,null);



-- ****** Individus ****

--351 individus ont même nom, prénom et date de naissance
select "NomDeNaissance", "Prenom", "DateNaissance", count(*) from "BREF"."Individu"
group by "NomDeNaissance", "Prenom", "DateNaissance"
having count(*) > 1
--351

--284 individus ont même nom, prénom, date de naissance, sexe
select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", count(*) from "BREF"."Individu"
group by "NomDeNaissance", "Prenom", "DateNaissance", "Sexe"
having count(*) > 1
--284

select "IdIndividu", "IdEluRNEHisto", "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", "Mandat".*
from "BREF"."Individu" 
join "BREF"."Mandat" on "Mandat"."Elu_IdIndividu" = "Individu"."IdIndividu"
where ("NomDeNaissance", "Prenom", "DateNaissance") in 
	(select "NomDeNaissance", "Prenom", "DateNaissance" from 
		(select "NomDeNaissance", "Prenom", "DateNaissance", count(*) from "BREF"."Individu"
		group by "NomDeNaissance", "Prenom", "DateNaissance"
		having count(*) > 1)A
	where ("NomDeNaissance", "Prenom", "DateNaissance") not in 
		(select "NomDeNaissance", "Prenom", "DateNaissance" from 
			(select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", count(*) from "BREF"."Individu"
			group by "NomDeNaissance", "Prenom", "DateNaissance", "Sexe"
			having count(*) > 1)B))
--67
--162

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0989244';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0989244'
where "IdMandat" = 9048784;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1322467';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0024673'
where "IdMandat" = 9390843;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1436763';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_1062613';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_1062613'
where "IdMandat" = 9278637;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1398859';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0639061';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0639061'
where "IdMandat" in (8603838, 9010787);
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1309053';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_1062609';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_1062609'
where "IdMandat" = 9278632;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1398865';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0988407';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0988407'
where "IdMandat" = 9044854;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1321107';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0990703';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0990703'
where "IdMandat" = 9053450;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1323981';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0936048';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0936048'
where "IdMandat" = 8879344;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1265834';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_1034437';

update "BREF"."Individu"
set "Sexe" = 'M'
where "IdIndividu" = 'RNE_0219386';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0219386'
where "IdMandat" in (8646479, 8646482, 9331834);
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1417462';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_1012757';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_1012757'
where "IdMandat" = 9119432;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1346605';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0989155';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0989155'
where "IdMandat" = 9048673;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1322423';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0116700';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0116700'
where "IdMandat" = 8938263;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1286762';

update "BREF"."Individu"
set "Sexe" = 'M'
where "IdIndividu" = 'RNE_0444598';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0444598'
where "IdMandat" = 9103331;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1340612';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0450171';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0450171'
where "IdMandat" = 8195611;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1495998';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0979329';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0979329'
where "IdMandat" = 9016902;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1311214';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0891982';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0987837';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0987837'
where "IdMandat" = 9043178;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1320494';

update "BREF"."Individu"
set "Sexe" = 'M'
where "IdIndividu" = 'RNE_0810823';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0810823'
where "IdMandat" in (8588412, 8886500);
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1268978';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_1110601';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_1110601'
where "IdMandat" = 9427040;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1449355';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0970880';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0970880'
where "IdMandat" in (8601668, 8992319);
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1302871';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0335139';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0335139'
where "IdMandat" = 8743942;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1218293';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0334933';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0334933'
where "IdMandat" = 9108148;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1342179';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0938190';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0938190'
where "IdMandat" in (8884102, 8888977);
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1270144';

update "BREF"."Individu"
set "Sexe" = 'M'
where "IdIndividu" = 'RNE_0796739';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0796739'
where "IdMandat" = 9477948;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1465354';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0919136';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0919136'
where "IdMandat" = 8838577;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1249320';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0618931';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0618931'
where "IdMandat" = 9494190;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1471116';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_1079291';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_1079291'
where "IdMandat" = 9330038;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1416905';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_1062611';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_1062611'
where "IdMandat" = 9278640;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1398866';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0977200';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0977200'
where "IdMandat" in (8268997, 8604095);
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1309904';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0763886';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0763886'
where "IdMandat" = 9319450;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1413397';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0345373';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0345373'
where "IdMandat" = 8930514;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1284317';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0157956';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0157956'
where "IdMandat" in (8615495,104272);
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1340930';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_1052061';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_1052061'
where "IdMandat" = 9238650;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1385680';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_1013229';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_1013229'
where "IdMandat" in (8617818, 21931);
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1347786';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0757754';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0757754'
where "IdMandat" = 9322415;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1414388';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_1143991';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_1143991'
where "IdMandat" = 8162709;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1485856';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_1076700';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_1076700'
where "IdMandat" = 9323794;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1414880';

update "BREF"."Individu"
set "Sexe" = 'M'
where "IdIndividu" = 'RNE_0219536';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0219536'
where "IdMandat" in (8645365, 9326665, 9326666);
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1415831';

update "BREF"."Individu"
set "Sexe" = 'M'
where "IdIndividu" = 'RNE_0006287';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0006287'
where "IdMandat" in (8188732, 8678378);
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1494395';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_1099770';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_1099770'
where "IdMandat" = 9395903;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1438559';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0938558';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0938558'
where "IdMandat" = 8889301;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1270275';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_1060530';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_1060530'
where "IdMandat" = 9270278;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1396235';

update "BREF"."Individu"
set "Sexe" = 'M'
where "IdIndividu" = 'RNE_0982469';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0982469'
where "IdMandat" = 9028816;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1315439';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_1196130'
where "IdMandat" = 9057113;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1196133';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0337601';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0337601'
where "IdMandat" = 9179775;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1525268';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_1339647';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_1339647'
where "IdMandat" = 9100399;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1524443';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0763553';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0763553'
where "IdMandat" = 9323121;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1414656';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0901021';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0901021'
where "IdMandat" = 8783405;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1511645';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0988863';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0988863'
where "IdMandat" in (8656768, 9411525);
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1444316';

update "BREF"."Individu"
set "Sexe" = 'M'
where "IdIndividu" = 'RNE_1122291';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_1122291'
where "IdMandat" = 9469019;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1462196';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_1130251';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_1130251'
where "IdMandat" = 9492972;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1470663';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0996158';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0996158'
where "IdMandat" = 9069095;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1329477';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0965842';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0965842'
where "IdMandat" = 8978012;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1297733';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0966385';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0966385'
where "IdMandat" = 8976737;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1297245';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_1127945';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_1127945'
where "IdMandat" = 9485770;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1468136';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0836263';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0836263'
where "IdMandat" = 9014206;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1310254';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0990053';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0990053'
where "IdMandat" = 9053041;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1323836';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_1061629';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_1061629'
where "IdMandat" = 9278461;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1398835';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0971377';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0971377'
where "IdMandat" in (8601975, 8994840);
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1303782';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_1119998';

update "BREF"."Individu"
set "Sexe" = 'M'
where "IdIndividu" = 'RNE_0556751';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0556751'
where "IdMandat" in (8667052, 9490075);
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1469618';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0161742';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0161742'
where "IdMandat" = 8994492;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1303658';

update "BREF"."Individu"
set "Sexe" = 'F'
where "IdIndividu" = 'RNE_0965889';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0965889'
where "IdMandat" = 8978032;
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_1297741';

--- fin traitement fichier même individus sexe différents.csv

select "IdIndividu", "IdEluRNEHisto", "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", "Mandat".*
from "BREF"."Individu" 
join "BREF"."Mandat" on "Mandat"."Elu_IdIndividu" = "Individu"."IdIndividu"
where ("NomDeNaissance", "Prenom", "DateNaissance") in 
	(select "NomDeNaissance", "Prenom", "DateNaissance" from 
		(select "NomDeNaissance", "Prenom", "DateNaissance", count(*) from "BREF"."Individu"
		group by "NomDeNaissance", "Prenom", "DateNaissance"
		having count(*) > 1)A
	where ("NomDeNaissance", "Prenom", "DateNaissance") not in 
		(select "NomDeNaissance", "Prenom", "DateNaissance" from 
			(select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", count(*) from "BREF"."Individu"
			group by "NomDeNaissance", "Prenom", "DateNaissance", "Sexe"
			having count(*) > 1)B))
order by "NomDeNaissance"
-- ajout de ces 3 couples dans la liste homonyme

-- encore 287 individus ont même nom, prénom, date de naissance, sexe identique
select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", count(*) from "BREF"."Individu"
group by "NomDeNaissance", "Prenom", "DateNaissance", "Sexe"
having count(*) > 1
--287

select "NomDeNaissance", "Prenom", "DateNaissance", "IdEluRNEHisto", count(*) from "BREF"."Individu"
group by "NomDeNaissance", "Prenom", "DateNaissance", "IdEluRNEHisto"
having count(*) > 1
--20 de ces individus n'ont pas du tout de "IdEluRNEHisto"
-->ces 287 individus sont des doublons entre rnehisto et une autre source ou deux autres sources (pour les 20) - vérifier avec les mandats

--- traitement de ces 20 individus

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'EUR_0001772'
where "IdMandat" = 8686300;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_0000465';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0336840'
where "IdMandat" = 8557869;
delete from "BREF"."Individu" 
where "IdIndividu" = 'ASN_0000324';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0336840'
where "IdMandat" = 8686302;
delete from "BREF"."Individu" 
where "IdIndividu" = 'ASN_0000324';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'EUR_0001807'
where "IdMandat" = 8687823;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_059527T';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'SEN_059528U'
where "IdMandat" = 8559147;
delete from "BREF"."Individu" 
where "IdIndividu" = 'EUR_0000905';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'EUR_0000974'
where "IdMandat" in (8687828, 8687829);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_077046H';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'EUR_0001736'
where "IdMandat" = 8685404;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_058043X';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'SEN_065017N'
where "IdMandat" = 8559231;
delete from "BREF"."Individu" 
where "IdIndividu" = 'EUR_0000880';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'EUR_0002018'
where "IdMandat" = 8687517;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_099001N';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'EUR_0001693'
where "IdMandat" = 8687603;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_092021M';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'SEN_0000197'
where "IdMandat" = 8449929;
delete from "BREF"."Individu" 
where "IdIndividu" = 'EUR_0000868';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'EUR_0000853'
where "IdMandat" = 8685887;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_058818X';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'EUR_0001639'
where "IdMandat" = 8687338;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_092026S';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'EUR_0001639'
where "IdMandat" in (8559784, 8559419);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_0000442';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'SEN_0000379'
where "IdMandat" in (8688331, 8688332);
delete from "BREF"."Individu" 
where "IdIndividu" = 'PRF_0000004';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'SEN_0000514'
where "IdMandat" = 8559534;
delete from "BREF"."Individu" 
where "IdIndividu" = 'EUR_0000720';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'SEN_057321W'
where "IdMandat" = 8559539;
delete from "BREF"."Individu" 
where "IdIndividu" = 'EUR_0000721';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'SEN_0000211'
where "IdMandat" in (8688327, 8688329);
delete from "BREF"."Individu" 
where "IdIndividu" = 'PRF_0000002';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'EUR_0001541'
where "IdMandat" = 8688199;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_059556Y';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'EUR_0001017'
where "IdMandat" = 8686772;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_059250H';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'SEN_058411C'
where "IdMandat" = 8559106;
delete from "BREF"."Individu" 
where "IdIndividu" = 'EUR_0000917';

--- fin traitement de ces 20 individus
















