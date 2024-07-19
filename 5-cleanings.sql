
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





















