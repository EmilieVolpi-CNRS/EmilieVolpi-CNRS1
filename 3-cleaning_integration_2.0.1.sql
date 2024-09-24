
/* nettoyage des professions, certaines existantes n'avaient pas d'id -> ces professions ont été mis à jour avec des ids
CHEFS D ENTREPRISE DE 10 SALARIES OU PLUS
AGRICULTEURS EXPLOITANTS
ANCIENS CADRES ET PROFESSIONS INTERMEDIAIRES
CADRES D ENTREPRISE
PROFESSIONS LIBERALES ET ASSIMILES
PROFESSIONS INTERMEDIAIRES DE L ENSEIGNEMENT DE LA SANTE DE LA FONCTION PUBLIQUE ET ASSIMILES
CADRES DE LA FONCTION PUBLIQUE PROFESSIONS INTELLECTUELLES ET ARTISTIQUES
COMMERCANTS ET ASSIMILES */



--doublon mandats

select * from "BREF".rne_integration where code_profession is not null
--1368939
select distinct id_universel, date_debut_mandat, date_fin_mandat, libelle_mandat, motif_fin_mandat, 
libelle_fonction, date_debut_fonction, date_fin_fonction, motif_fin_fonction
from "BREF".rne_integration where code_profession is not null
--136902

--->37 doublons supprimés

select "BREF".rne_integration.* from 
(
	select count(*), id_universel, date_debut_mandat, date_fin_mandat, libelle_mandat, motif_fin_mandat, 
	libelle_fonction, date_debut_fonction, date_fin_fonction, motif_fin_fonction
	from "BREF".rne_integration where code_profession is not null
	group by id_universel, date_debut_mandat, date_fin_mandat, libelle_mandat, motif_fin_mandat, 
	libelle_fonction, date_debut_fonction, date_fin_fonction, motif_fin_fonction
	having count(*) > 1) A--37
join "BREF".rne_integration on "BREF".rne_integration.id_universel = A.id_universel
and "BREF".rne_integration.date_debut_mandat = A.date_debut_mandat
and "BREF".rne_integration.date_fin_mandat = A.date_fin_mandat
order by "BREF".rne_integration.id_universel

and "BREF".rne_integration.libelle_mandat = A.libelle_mandat
and "BREF".rne_integration.motif_fin_mandat = A.motif_fin_mandat
and "BREF".rne_integration.libelle_fonction = A.libelle_fonction
and "BREF".rne_integration.date_debut_fonction = A.date_debut_fonction
and "BREF".rne_integration.date_fin_fonction = A.date_fin_fonction
and "BREF".rne_integration.motif_fin_fonction = A.motif_fin_fonction
order by "BREF".rne_integration.id_universel



--département d’outremer

/* les codesterritoires des département d’outremer sont des codes à deux lettres
"ZA"    "GUADELOUPE"
"ZB"    "MARTINIQUE"
"ZC"    "GUYANE"
"ZD"    "LA REUNION"
"ZM"    "MAYOTTE"
"ZN"    "NOUVELLE CALEDONIE"
"ZP"    "POLYNESIE FRANCAISE"
"ZS"    "SAINT PIERRE ET MIQUELON"

Du coup les communes de ces territoires ont eu un codeterritoire erroné lors de sa construction (code insee commune) et création en base de données BREF. 
ex : "64735"    "PAPAICHTON"    "Commune"    "ZC362"

on renomme les deux premières lettres des codeterritoire des communes selon
"ZA"    "GUADELOUPE" -> 97
"ZB"    "MARTINIQUE" -> 97
"ZC"    "GUYANE" -> 97
"ZD"    "LA REUNION" -> 97
"ZM"    "MAYOTTE" -> 97
"ZN"    "NOUVELLE CALEDONIE" -> 98
"ZP0"    "POLYNESIE FRANCAISE" -> 987
"ZS"    "SAINT PIERRE ET MIQUELON" -> 97 */

update "BREF"."Territoire"
set "CodeTerritoire" = '97'||substring("CodeTerritoire" from 3 for 3)
where "CodeTerritoire" like 'ZA%'
