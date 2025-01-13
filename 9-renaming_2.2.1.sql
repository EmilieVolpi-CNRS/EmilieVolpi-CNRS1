alter table "BREF"."Individual" rename column "IdIndividual" to "IndividualId";
alter table "BREF"."Individual" rename column "IdRNEHist" to "RNEHistId";
alter table "BREF"."Individual" rename column "IdSenate" to "SenateId";
alter table "BREF"."Individual" rename column "IdAssembly" to "AssemblyId";
alter table "BREF"."Individual" rename column "IdEurope" to "EuropeId";
alter table "BREF"."Individual" rename column "DateBirth" to "BirthDate";
alter table "BREF"."Individual" rename column "DateDeath" to "DeathDate";
alter table "BREF"."Individual" rename column "MunicipalityBirth" to "MunicipalityBirth";
alter table "BREF"."Individual" rename column "DepartmentBirth" to "BirthDepartment";
alter table "BREF"."Individual" rename column "CountryBirth" to "BirthCountry";

alter table "BREF"."Mandate" rename column "IdMandate" to "MandateId";
alter table "BREF"."Mandate" rename column "TypeMandate" to "MandateType";
alter table "BREF"."Mandate" rename column "MandateStartDate" to "MandStartDateMandateateId";
alter table "BREF"."Mandate" rename column "MandateEndDate" to "EndDateMandate";
alter table "BREF"."Mandate" rename column "MandateEndReasonEnd" to "EndReasonEndMandate";
alter table "BREF"."Mandate" rename column "IdIndividual" to "IndividualId";
alter table "BREF"."Mandate" rename column "IndividualLastNameUsage" to "UsedLastNameIndividual";
alter table "BREF"."Mandate" rename column "IdArea" to "AreaId";
alter table "BREF"."Mandate" rename column "IdPoliticalNuanceRNE" to "PoliticalNuanceRNEId";
alter table "BREF"."Mandate" rename column "IdProfession" to "ProfessionId";

alter table "BREF"."Function" rename column "IdFunction" to "FunctionId";
alter table "BREF"."Function" rename column "TypeFunction" to "FunctionType";
alter table "BREF"."Function" rename column "FunctionStartDate" to "StartDateFunction";
alter table "BREF"."Function" rename column "FunctionEndDate" to "EndDateFunction";
alter table "BREF"."Function" rename column "FunctionEndReasonEnd" to "EndReasonEndFunction";
alter table "BREF"."Function" rename column "IdMandate" to "MandateId";

alter table "BREF"."Area" rename column "IdArea" to "AreaId";
alter table "BREF"."Area" rename column "NameArea" to "AreaName";
alter table "BREF"."Area" rename column "TypeArea" to "AreaType";
alter table "BREF"."Area" rename column "CodeArea" to "AreaCode";
alter table "BREF"."Area" rename column "DateLinked" to "LinkedDate";

alter table "BREF"."Inclusion" rename column "IdInclusion" to "InclusionId";
alter table "BREF"."Inclusion" rename column "IdAreaIncluded" to "IncludedAreaId";
alter table "BREF"."Inclusion" rename column "AreaIncluding" to "IncludingAreaId";
alter table "BREF"."Inclusion" rename column "InclusionStartDate" to "StartDateInclusion";
alter table "BREF"."Inclusion" rename column "InclusionEndDate" to "EndDateInclusion";

alter table "BREF"."PoliticalNuance" rename column "IdPoliticalNuance" to "PoliticalNuanceId";
alter table "BREF"."PoliticalNuance" rename column "PoliticalNuance" to "PoliticalNuanceName";

alter table "BREF"."Profession" rename column "IdProfession" to "ProfessionId";
alter table "BREF"."Profession" rename column "Profession" to "ProfessionName";



