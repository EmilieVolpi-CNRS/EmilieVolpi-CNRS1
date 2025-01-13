alter table "BREF"."Individual" rename column "IdIndividual" to "IndividualId";
alter table "BREF"."Individual" rename column "IdRNEHist" to "RNEHistId";
alter table "BREF"."Individual" rename column "IdSenate" to "SenateId";
alter table "BREF"."Individual" rename column "IdAssembly" to "AssemblyId";
alter table "BREF"."Individual" rename column "IdEurope" to "EuropeId";
alter table "BREF"."Individual" rename column "DateBirth" to "BirthDate";
alter table "BREF"."Individual" rename column "DateDeath" to "DeathDate";
alter table "BREF"."Individual" rename column "MunicipalityBirth" to "BirthMunicipality";
alter table "BREF"."Individual" rename column "DepartmentBirth" to "BirthDepartment";
alter table "BREF"."Individual" rename column "CountryBirth" to "BirthCountry";

alter table "BREF"."Mandate" rename column "IdMandate" to "MandateId";
alter table "BREF"."Mandate" rename column "TypeMandate" to "MandateType";
alter table "BREF"."Mandate" rename column "StartDateMandate" to "MandateStartDate";
alter table "BREF"."Mandate" rename column "EndDateMandate" to "MandateEndDate";
alter table "BREF"."Mandate" rename column "ReasonEndMandate" to "EndReasonMandate";
alter table "BREF"."Mandate" rename column "IdIndividual" to "IndividualId";
alter table "BREF"."Mandate" rename column "LastNameUsageIndividual" to "UsedLastNameIndividual";
alter table "BREF"."Mandate" rename column "IdArea" to "AreaId";
alter table "BREF"."Mandate" rename column "IdPoliticalNuanceRNE" to "PoliticalNuanceRNEId";
alter table "BREF"."Mandate" rename column "IdProfession" to "ProfessionId";

alter table "BREF"."Function" rename column "IdFunction" to "FunctionId";
alter table "BREF"."Function" rename column "TypeFunction" to "FunctionType";
alter table "BREF"."Function" rename column "StartDateFunction" to "FunctionStartDate";
alter table "BREF"."Function" rename column "EndDateFunction" to "FunctionEndDate";
alter table "BREF"."Function" rename column "ReasonEndFunction" to "FunctionEndReasonEnd";
alter table "BREF"."Function" rename column "IdMandate" to "MandateId";

alter table "BREF"."Area" rename column "IdArea" to "AreaId";
alter table "BREF"."Area" rename column "NameArea" to "AreaName";
alter table "BREF"."Area" rename column "TypeArea" to "AreaType";
alter table "BREF"."Area" rename column "CodeArea" to "AreaCode";
alter table "BREF"."Area" rename column "DateLinked" to "LinkedDate";

alter table "BREF"."Inclusion" rename column "IdInclusion" to "InclusionId";
alter table "BREF"."Inclusion" rename column "IdAreaIncluded" to "IncludedAreaId";
alter table "BREF"."Inclusion" rename column "IdAreaIncluding" to "IncludingAreaId";
alter table "BREF"."Inclusion" rename column "StartDateInclusion" to "InclusionStartDate";
alter table "BREF"."Inclusion" rename column "EndDateInclusion" to "InclusionEndDate";

alter table "BREF"."PoliticalNuance" rename column "IdPoliticalNuance" to "PoliticalNuanceId";
alter table "BREF"."PoliticalNuance" rename column "PoliticalNuance" to "PoliticalNuanceName";

alter table "BREF"."Profession" rename column "IdProfession" to "ProfessionId";
alter table "BREF"."Profession" rename column "Profession" to "ProfessionName";
