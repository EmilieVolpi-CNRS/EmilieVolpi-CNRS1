

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

--type Area

update "BREF"."Area"
set "TypeArea" = 'Pays'
where "TypeArea" = 'Nation';

delete from "BREF"."Area"
where "TypeArea" = 'Departement';
