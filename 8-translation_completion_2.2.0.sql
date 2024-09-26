

--tables PopulationCommune and TypeMandate were not included in the dataset, as well as few fields that are not used or necessary


--a lot of tables and fields names were renamed in english

Territoire : Area
IdTerritoire : IdArea
NomTerritoire : NameArea
TypeTerritoire : TypeArea
CodeTerritoire : CodeArea
DateLiee : DateLinked
Actif : Active

Inclusion
TerritoireInclu_IdTerritoire : IdAreaIncluded
TerritoireIncluant_IdTerritoire : IdAreaIncluding
DateDebutInclusion : StartDateInclusion
DateFinInclusion : EndDateInclusion

Individu : Individual
IdIndividu : IdIndividual
IdEluRNEHisto : IdEluRNEHist
IdEluSenat : IdSenate
IdEluAssemblee : IdAssembly
NomDeNaissance : LastName
Prenom : FirstName
Sexe : Gender
DateNaissance : DateBirth
DateDeces : DateDeath
Nationalite : Nationality
CommuneNaissance : MunicipalityBirth
DepartementNaissance : DepartmentBirth
PaysNaissance : CountryBirth

Mandat : Mandate
IdMandat : IdMandate
TypeDuMandat_IdTypeMandat : TypeMandate
DateDebutMandat : StartDateMandate
DateFinMandat : EndDateMandate
MotifFinMandat : ReasonEndMandate
Elu_IdIndividu : IdIndividual
NomDUsageIndividu : LastNameUsageIndividual
Territoire_IdTerritoire : IdArea
IdNuancePolitique : IdPoliticalNuanceRNE

Fonction : Function
IdFonction : IdFunction
DateDebutFonction : StartDateFunction
DateFinFonction : EndDateFunction
MotifFinFonction : ReasonEndFunction
TypeDeFonction_IdTypeFonction : TypeFunction
IdMandat : IdMandate

NuancePolitique : PoliticalNuance
IdNuancePolitique : IdPoliticalNuance
NuancePolitique : PoliticalNuance

Profession
CodeProfession : IdProfession
LibelleProfession : Profession

TypeFonction : TypeFunction
IdTypeFonction : IdTypeFunction
TypeFonction : TypeFunction



-- harmonization field ReasonEndMandate

update "BREF"."Mandate" set "ReasonEndMandate" = 'DC'
where "ReasonEndMandate" = 'DECEDE';
update "BREF"."Mandate" set "ReasonEndMandate" = 'DC'
where "ReasonEndMandate" = 'DECES';
update "BREF"."Mandate" set "ReasonEndMandate" = 'DV'
where "ReasonEndMandate" = 'DEMISSIONNAIRE';
update "BREF"."Mandate" set "ReasonEndMandate" = 'DV'
where "ReasonEndMandate" = 'DEMISSION';
update "BREF"."Mandate" set "ReasonEndMandate" = 'ELU DEPUTE EUROPEEN'
where "ReasonEndMandate" = 'ELECTION COMME REPRESENTANT AU PARLEMENT EUROPEEN';
update "BREF"."Mandate" set "ReasonEndMandate" = 'NOMINATION COMME MEMBRE DU GOUVERNEMENT'
where "ReasonEndMandate" = 'MEMBRE GOUVERNEMENT';
update "BREF"."Mandate" set "ReasonEndMandate" = 'ANNULE PAR CC'
where "ReasonEndMandate" = 'ANNULATION DE L ELECTION SUR DECISION DU CONSEIL CONSTITUTIONNEL';
update "BREF"."Mandate" set "ReasonEndMandate" = 'FM'
where "ReasonEndMandate" = 'FIN DE LEGISLATURE';
update "BREF"."Mandate" set "ReasonEndMandate" = 'FM'
where "ReasonEndMandate" = 'FIN DE MANDAT';
update "BREF"."Mandate" set "ReasonEndMandate" = 'MEMBRE GOUVERNEMENT'
where "ReasonEndMandate" = 'NOMINATION COMME MEMBRE DU GOUVERNEMENT';
update "BREF"."Mandate" set "ReasonEndMandate" = 'AUTRE'
where "ReasonEndMandate" = 'AU';
update "BREF"."Mandate" set "ReasonEndMandate" = 'DECES'
where "ReasonEndMandate" = 'DC';
update "BREF"."Mandate" set "ReasonEndMandate" = 'DEMISSION D OFFICE'
where "ReasonEndMandate" = 'DO';
update "BREF"."Mandate" set "ReasonEndMandate" = 'DEMISSION VOLONTAIRE'
where "ReasonEndMandate" = 'DV';
update "BREF"."Mandate" set "ReasonEndMandate" = 'FIN DE MANDAT'
where "ReasonEndMandate" = 'FM';
update "BREF"."Mandate" set "ReasonEndMandate" = 'NOMME AU GOUVERNEMENT'
where "ReasonEndMandate" = 'MEMBRE GOUVERNEMENT';

--type Area

update "BREF"."Area"
set "TypeArea" = 'Pays'
where "TypeArea" = 'Nation';

delete from "BREF"."Area"
where "TypeArea" = 'Departement';



--departmentEPCI

update "BREF"."Area" set "NameArea" = '1976_90' where "IdArea" = '01793_90';
update "BREF"."Area" set "NameArea" = '1976_19' where "IdArea" = '01793_19';

insert into "BREF"."Inclusion" ("IdAreaIncluded", "IdAreaIncluding")
SELECT T2."IdArea" as "EPCI", T1."NameArea" as "departement"
FROM "BREF"."Inclusion"
join "BREF"."Area" T1 on T1."IdArea" = "Inclusion"."IdAreaIncluded"
join "BREF"."Area" T2 on T2."IdArea" = "Inclusion"."IdAreaIncluding"
where T1."TypeArea" = 'Département EPCI';
--3182

--on supprime les anciennes inclusions
delete from "BREF"."Inclusion"
where "IdAreaIncluded" in
 (SELECT "IdArea"
 FROM "BREF"."Area" where "TypeArea" = 'Département EPCI');
--3182

delete from "BREF"."TypeFunction" where "TypeFunction" = '';
delete from "BREF"."Mandate" where "IdIndividual" = '0';
delete from "BREF"."Individual" where "LastName" is null;
