
-- ***** cleaning that were made to add contraints AFTER *****

/* Doublons dans la table Mandat */

delete from "BREF"."Mandat" where "IdMandat" = 9527849;
INSERT INTO "BREF"."Mandat"(
	"IdMandat", "TypeDuMandat_IdTypeMandat", "DateDebutMandat", "DateFinMandat", "MotifFinMandat", "Elu_IdIndividu", "NomDUsageIndividu", "Territoire_IdTerritoire", "IdNuancePolitique", "IdProfession", "Sources", "CorrectionsDate", "CorrectionsAutres", "Commentaire", "IdPartiPolitique")
	VALUES (9527849, 2, '1971-09-25', '1974-09-21', 'AU', 'ARC_130', 'RAVE', '21_34-23', NULL, NULL, 'BOTTIN CdO', NULL, NULL, NULL, NULL);
delete from "BREF"."Mandat" where "IdMandat" = 9527711;
INSERT INTO "BREF"."Mandat"(
	"IdMandat", "TypeDuMandat_IdTypeMandat", "DateDebutMandat", "DateFinMandat", "MotifFinMandat", "Elu_IdIndividu", "NomDUsageIndividu", "Territoire_IdTerritoire", "IdNuancePolitique", "IdProfession", "Sources", "CorrectionsDate", "CorrectionsAutres", "Commentaire", "IdPartiPolitique")
	VALUES (9527711, 4, '1975-03-15', '1981-03-11', 'FM', '0', 'SAUCY', '55725', NULL, NULL, 'ARCHIVES', NULL, NULL, NULL, NULL);
delete from "BREF"."Mandat" where "IdMandat" = 9527527;
INSERT INTO "BREF"."Mandat"(
	"IdMandat", "TypeDuMandat_IdTypeMandat", "DateDebutMandat", "DateFinMandat", "MotifFinMandat", "Elu_IdIndividu", "NomDUsageIndividu", "Territoire_IdTerritoire", "IdNuancePolitique", "IdProfession", "Sources", "CorrectionsDate", "CorrectionsAutres", "Commentaire", "IdPartiPolitique")
	VALUES (9527527, 4, '1904-01-01', '1904-01-01', NULL, 'ARC_064', 'HAUSER', '47564', NULL, NULL, 'BOTTIN CdO', NULL, NULL, NULL, NULL);
delete from "BREF"."Mandat" where "IdMandat" = 9527407;
INSERT INTO "BREF"."Mandat"(
	"IdMandat", "TypeDuMandat_IdTypeMandat", "DateDebutMandat", "DateFinMandat", "MotifFinMandat", "Elu_IdIndividu", "NomDUsageIndividu", "Territoire_IdTerritoire", "IdNuancePolitique", "IdProfession", "Sources", "CorrectionsDate", "CorrectionsAutres", "Commentaire", "IdPartiPolitique")
	VALUES (9527407, 4, '1904-01-01', '1904-01-01', NULL, 'ARC_002', 'AMIOT', '49381', NULL, NULL, 'BOTTIN CdO', NULL, NULL, NULL, NULL);
delete from "BREF"."Mandat" where "IdMandat" = 9527365;
INSERT INTO "BREF"."Mandat"(
	"IdMandat", "TypeDuMandat_IdTypeMandat", "DateDebutMandat", "DateFinMandat", "MotifFinMandat", "Elu_IdIndividu", "NomDUsageIndividu", "Territoire_IdTerritoire", "IdNuancePolitique", "IdProfession", "Sources", "CorrectionsDate", "CorrectionsAutres", "Commentaire", "IdPartiPolitique")
	VALUES (9527365, 4, '1981-03-14', '1987-03-06', 'FM', 'ARC_064', 'D''HARCOURT', '63599', NULL, NULL, 'BOTTIN CdO', NULL, NULL, NULL, NULL);
select * from "BREF"."Mandat" where "IdMandat" = 9527513;
delete from "BREF"."Mandat" where "IdMandat" = 9527513;
INSERT INTO "BREF"."Mandat"(
	"IdMandat", "TypeDuMandat_IdTypeMandat", "DateDebutMandat", "DateFinMandat", "MotifFinMandat", "Elu_IdIndividu", "NomDUsageIndividu", "Territoire_IdTerritoire", "IdNuancePolitique", "IdProfession", "Sources", "CorrectionsDate", "CorrectionsAutres", "Commentaire", "IdPartiPolitique")
	VALUES (9527513, 4, '1904-01-01', '1904-01-01', NULL, 'ARC_003', 'AMPAUD', '47564', NULL, NULL, 'BOTTIN CdO', NULL, NULL, NULL, NULL);
delete from "BREF"."Mandat" where "IdMandat" = 9527364;
INSERT INTO "BREF"."Mandat"(
	"IdMandat", "TypeDuMandat_IdTypeMandat", "DateDebutMandat", "DateFinMandat", "MotifFinMandat", "Elu_IdIndividu", "NomDUsageIndividu", "Territoire_IdTerritoire", "IdNuancePolitique", "IdProfession", "Sources", "CorrectionsDate", "CorrectionsAutres", "Commentaire", "IdPartiPolitique")
	VALUES (9527364, 4, '1975-03-14', '1981-03-11', 'FM', 'ARC_064', 'D''HARCOURT', '63599', NULL, NULL, 'BOTTIN CdO', NULL, NULL, NULL, NULL);
delete from "BREF"."Mandat" where "IdMandat" = 9527367;
INSERT INTO "BREF"."Mandat"(
	"IdMandat", "TypeDuMandat_IdTypeMandat", "DateDebutMandat", "DateFinMandat", "MotifFinMandat", "Elu_IdIndividu", "NomDUsageIndividu", "Territoire_IdTerritoire", "IdNuancePolitique", "IdProfession", "Sources", "CorrectionsDate", "CorrectionsAutres", "Commentaire", "IdPartiPolitique")
	VALUES (9527367, 4, '1993-03-13', '1998-12-01', 'DC', 'ARC_064', 'D''HARCOURT', '63599', NULL, NULL, 'BOTTIN CdO', NULL, NULL, NULL, NULL);
delete from "BREF"."Mandat" where "IdMandat" = 9527366;
INSERT INTO "BREF"."Mandat"(
	"IdMandat", "TypeDuMandat_IdTypeMandat", "DateDebutMandat", "DateFinMandat", "MotifFinMandat", "Elu_IdIndividu", "NomDUsageIndividu", "Territoire_IdTerritoire", "IdNuancePolitique", "IdProfession", "Sources", "CorrectionsDate", "CorrectionsAutres", "Commentaire", "IdPartiPolitique")
	VALUES (9527366, 4, '1987-03-07', '1993-03-11', 'FM', 'ARC_064', 'D''HARCOURT', '63599', NULL, NULL, 'BOTTIN CdO', NULL, NULL, NULL, NULL);
delete from "BREF"."Mandat" where "IdMandat" = 9527422;
INSERT INTO "BREF"."Mandat"(
	"IdMandat", "TypeDuMandat_IdTypeMandat", "DateDebutMandat", "DateFinMandat", "MotifFinMandat", "Elu_IdIndividu", "NomDUsageIndividu", "Territoire_IdTerritoire", "IdNuancePolitique", "IdProfession", "Sources", "CorrectionsDate", "CorrectionsAutres", "Commentaire", "IdPartiPolitique")
	VALUES (9527422, 4, '1904-01-01', '1904-01-01', NULL, 'ARC_123', 'PETITFOUR', '55724', NULL, NULL, 'BOTTIN CdO', NULL, NULL, NULL, NULL);
delete from "BREF"."Mandat" where "IdMandat" = 9527514;
INSERT INTO "BREF"."Mandat"(
	"IdMandat", "TypeDuMandat_IdTypeMandat", "DateDebutMandat", "DateFinMandat", "MotifFinMandat", "Elu_IdIndividu", "NomDUsageIndividu", "Territoire_IdTerritoire", "IdNuancePolitique", "IdProfession", "Sources", "CorrectionsDate", "CorrectionsAutres", "Commentaire", "IdPartiPolitique")
	VALUES (9527514, 4, '1904-01-01', '1904-01-01', NULL, 'ARC_007', 'BARBIER', '47564', NULL, NULL, 'BOTTIN CdO', NULL, NULL, NULL, NULL);
delete from "BREF"."Mandat" where "IdMandat" = 9527428;
INSERT INTO "BREF"."Mandat"(
	"IdMandat", "TypeDuMandat_IdTypeMandat", "DateDebutMandat", "DateFinMandat", "MotifFinMandat", "Elu_IdIndividu", "NomDUsageIndividu", "Territoire_IdTerritoire", "IdNuancePolitique", "IdProfession", "Sources", "CorrectionsDate", "CorrectionsAutres", "Commentaire", "IdPartiPolitique")
	VALUES (9527428, 4, '1904-01-01', '1904-01-01', NULL, 'ARC_074', 'JALQUIN', '48506', NULL, NULL, 'BOTTIN CdO', NULL, NULL, NULL, NULL);
delete from "BREF"."Mandat" where "IdMandat" = 9527363;
INSERT INTO "BREF"."Mandat"(
	"IdMandat", "TypeDuMandat_IdTypeMandat", "DateDebutMandat", "DateFinMandat", "MotifFinMandat", "Elu_IdIndividu", "NomDUsageIndividu", "Territoire_IdTerritoire", "IdNuancePolitique", "IdProfession", "Sources", "CorrectionsDate", "CorrectionsAutres", "Commentaire", "IdPartiPolitique")
	VALUES (9527363, 4, '1969-03-15', '1975-03-11', 'FM', 'ARC_064', 'D''HARCOURT', '63599', NULL, NULL, 'BOTTIN CdO', NULL, NULL, NULL, NULL);
delete from "BREF"."Mandat" where "IdMandat" = 9527526;
INSERT INTO "BREF"."Mandat"(
	"IdMandat", "TypeDuMandat_IdTypeMandat", "DateDebutMandat", "DateFinMandat", "MotifFinMandat", "Elu_IdIndividu", "NomDUsageIndividu", "Territoire_IdTerritoire", "IdNuancePolitique", "IdProfession", "Sources", "CorrectionsDate", "CorrectionsAutres", "Commentaire", "IdPartiPolitique")
	VALUES (9527526, 4, '1904-01-01', '1904-01-01', NULL, 'ARC_060', 'GUERRIN', '47564', NULL, NULL, 'BOTTIN CdO', NULL, NULL, NULL, NULL);

/* doublons table Territoire */

update "BREF"."Territoire" set "IdTerritoire" = '67596' where "TypeTerritoire" = 'Pays' and "IdTerritoire" = '67508';
update "BREF"."Territoire" set "IdTerritoire" = '67597' where "TypeTerritoire" = 'Pays' and "IdTerritoire" = '67509';
update "BREF"."Territoire" set "IdTerritoire" = '67598' where "TypeTerritoire" = 'Pays' and "IdTerritoire" = '67510';
update "BREF"."Territoire" set "IdTerritoire" = '67599' where "TypeTerritoire" = 'Pays' and "IdTerritoire" = '67511';
update "BREF"."Territoire" set "IdTerritoire" = '67600' where "TypeTerritoire" = 'Pays' and "IdTerritoire" = '67512';
update "BREF"."Territoire" set "IdTerritoire" = '67601' where "TypeTerritoire" = 'Pays' and "IdTerritoire" = '67513';
update "BREF"."Territoire" set "IdTerritoire" = '67602' where "TypeTerritoire" = 'Pays' and "IdTerritoire" = '67514';
update "BREF"."Territoire" set "IdTerritoire" = '67603' where "TypeTerritoire" = 'Pays' and "IdTerritoire" = '67515';
update "BREF"."Territoire" set "IdTerritoire" = '67604' where "TypeTerritoire" = 'Pays' and "IdTerritoire" = '67516';
update "BREF"."Territoire" set "IdTerritoire" = '67605' where "TypeTerritoire" = 'Pays' and "IdTerritoire" = '67517';
update "BREF"."Territoire" set "IdTerritoire" = '67606' where "TypeTerritoire" = 'Pays' and "IdTerritoire" = '67518';
update "BREF"."Territoire" set "IdTerritoire" = '67607' where "TypeTerritoire" = 'Pays' and "IdTerritoire" = '67519';
update "BREF"."Territoire" set "IdTerritoire" = '67608' where "TypeTerritoire" = 'Circonscription Européenne' and "IdTerritoire" = '67520';


/* un type de fonction manquant, venant des données "BOTTIN CdO" */

update "BREF"."Mandat"
set "DateDebutMandat" ='1986-03-16'
where "IdMandat" = 9527501;

update "BREF"."TypeFonction"
set "TypeFonction" = 'VICE PRESIDENT DU CONSEIL DEPARTEMENTAL'
where "IdTypeFonction" = 166;

--INSERT INTO "BREF"."TypeFonction"("IdTypeFonction", "TypeFonction")
   --VALUES (166, 'VICE PRESIDENT DU CONSEIL DEPARTEMENTAL');



/* problèmes mandats manquants dans table fonction : origine https://drive.google.com/drive/folders/1EqzXISSfYCXXwttDSsRzt8qhjXFqOmk0?usp=sharing */

-- problème (avant passage des requetes ci-dessous
--Select distinct "IdMandat" from "BREF"."Fonction"
--where "IdMandat" not in
--(select distinct "IdMandat" from "BREF"."Mandat");
--136 mandats inexistants dans Mandat sont dans Fonction

update "BREF"."Fonction" set  "IdMandat" = 8246055 where "IdMandat" = 8813306;
update "BREF"."Fonction" set  "IdMandat" = 8246055 where "IdMandat" = 8246167;
update "BREF"."Fonction" set  "IdMandat" = 8246055 where "IdMandat" = 8814304;
update "BREF"."Fonction" set  "IdMandat" = 8817516 where "IdMandat" = 8817517;
update "BREF"."Fonction" set  "IdMandat" = 8817516 where "IdMandat" = 8813306;
update "BREF"."Fonction" set  "IdMandat" = 8824852 where "IdMandat" = 8824852;
update "BREF"."Fonction" set  "IdMandat" = 8865342 where "IdMandat" = 8865343;
update "BREF"."Fonction" set  "IdMandat" = 8865343 where "IdMandat" = 8824852;
update "BREF"."Fonction" set  "IdMandat" = 8865343 where "IdMandat" = 8865342;
update "BREF"."Fonction" set  "IdMandat" = 8912667 where "IdMandat" = 8898172;
update "BREF"."Fonction" set  "IdMandat" = 8912667 where "IdMandat" = 8898171;
update "BREF"."Fonction" set  "IdMandat" = 8912667 where "IdMandat" = 8258422;
update "BREF"."Fonction" set  "IdMandat" = 8911686 where "IdMandat" = 8911685;
update "BREF"."Fonction" set  "IdMandat" = 8914984 where "IdMandat" = 8914983;
update "BREF"."Fonction" set  "IdMandat" = 8927301 where "IdMandat" = 8927302;
update "BREF"."Fonction" set  "IdMandat" = 8927301 where "IdMandat" = 8911111;
update "BREF"."Fonction" set  "IdMandat" = 8927301 where "IdMandat" = 8911110;
update "BREF"."Fonction" set  "IdMandat" = 8927293 where "IdMandat" = 8927292;
update "BREF"."Fonction" set  "IdMandat" = 8927225 where "IdMandat" = 8260330;
update "BREF"."Fonction" set  "IdMandat" = 9053852 where "IdMandat" = 8983774;
update "BREF"."Fonction" set  "IdMandat" = 9053852 where "IdMandat" = 9053851;
update "BREF"."Fonction" set  "IdMandat" = 9053852 where "IdMandat" = 8983775;
update "BREF"."Fonction" set  "IdMandat" = 9059979 where "IdMandat" = 9059978;
update "BREF"."Fonction" set  "IdMandat" = 8273816 where "IdMandat" = 9059302;
update "BREF"."Fonction" set  "IdMandat" = 9058531 where "IdMandat" = 8272546;
update "BREF"."Fonction" set  "IdMandat" = 9058531 where "IdMandat" = 9050790;
update "BREF"."Fonction" set  "IdMandat" = 9058531 where "IdMandat" = 9058532;
update "BREF"."Fonction" set  "IdMandat" = 8273932 where "IdMandat" = 9060001;
update "BREF"."Fonction" set  "IdMandat" = 9073637 where "IdMandat" = 9073636;
update "BREF"."Fonction" set  "IdMandat" = 9069001 where "IdMandat" = 9071573;
update "BREF"."Fonction" set  "IdMandat" = 9069001 where "IdMandat" = 9071574;
update "BREF"."Fonction" set  "IdMandat" = 9069001 where "IdMandat" = 8275008;
update "BREF"."Fonction" set  "IdMandat" = 9111063 where "IdMandat" = 9111064;
update "BREF"."Fonction" set  "IdMandat" = 9112979 where "IdMandat" = 9112980;
update "BREF"."Fonction" set  "IdMandat" = 9133126 where "IdMandat" = 9127011;
update "BREF"."Fonction" set  "IdMandat" = 9133126 where "IdMandat" = 9127012;
update "BREF"."Fonction" set  "IdMandat" = 9133126 where "IdMandat" = 9133127;
update "BREF"."Fonction" set  "IdMandat" = 9137430 where "IdMandat" = 9137431;
update "BREF"."Fonction" set  "IdMandat" = 9129414 where "IdMandat" = 9129413;
update "BREF"."Fonction" set  "IdMandat" = 9136356 where "IdMandat" = 9137926;
update "BREF"."Fonction" set  "IdMandat" = 9136356 where "IdMandat" = 9137925;
update "BREF"."Fonction" set  "IdMandat" = 9136356 where "IdMandat" = 9136357;
update "BREF"."Fonction" set  "IdMandat" = 9129171 where "IdMandat" = 9129172;
update "BREF"."Fonction" set  "IdMandat" = 9127021 where "IdMandat" = 9127022;
update "BREF"."Fonction" set  "IdMandat" = 9138627 where "IdMandat" = 9133688;
update "BREF"."Fonction" set  "IdMandat" = 9138627 where "IdMandat" = 9133687;
update "BREF"."Fonction" set  "IdMandat" = 9138627 where "IdMandat" = 9138628;
update "BREF"."Fonction" set  "IdMandat" = 9134521 where "IdMandat" = 9134520;
update "BREF"."Fonction" set  "IdMandat" = 9134338 where "IdMandat" = 9134339;
update "BREF"."Fonction" set  "IdMandat" = 9129506 where "IdMandat" = 9129456;
update "BREF"."Fonction" set  "IdMandat" = 9129506 where "IdMandat" = 9129457;
update "BREF"."Fonction" set  "IdMandat" = 9129506 where "IdMandat" = 9129505;
update "BREF"."Fonction" set  "IdMandat" = 9128650 where "IdMandat" = 9128651;
update "BREF"."Fonction" set  "IdMandat" = 9127058 where "IdMandat" = 9127059;
update "BREF"."Fonction" set  "IdMandat" = 9150124 where "IdMandat" = 9149178;
update "BREF"."Fonction" set  "IdMandat" = 9150124 where "IdMandat" = 9149179;
update "BREF"."Fonction" set  "IdMandat" = 9150124 where "IdMandat" = 9150123;
update "BREF"."Fonction" set  "IdMandat" = 9168933 where "IdMandat" = 8285963;
update "BREF"."Fonction" set  "IdMandat" = 9217660 where "IdMandat" = 9217661;
update "BREF"."Fonction" set  "IdMandat" = 9394541 where "IdMandat" = 9369679;
update "BREF"."Fonction" set  "IdMandat" = 9394541 where "IdMandat" = 8307875;
update "BREF"."Fonction" set  "IdMandat" = 9394541 where "IdMandat" = 8311053;
update "BREF"."Fonction" set  "IdMandat" = 9394555 where "IdMandat" = 9394554;
update "BREF"."Fonction" set  "IdMandat" = 9410967 where "IdMandat" = 8312790;
update "BREF"."Fonction" set  "IdMandat" = 8221630 where "IdMandat" = 8144089;
update "BREF"."Fonction" set  "IdMandat" = 8221630 where "IdMandat" = 8144090;
update "BREF"."Fonction" set  "IdMandat" = 8221630 where "IdMandat" = 8221629;
update "BREF"."Fonction" set  "IdMandat" = 9132398 where "IdMandat" = 9132397;
update "BREF"."Fonction" set  "IdMandat" = 9144807 where "IdMandat" = 9144806;
update "BREF"."Fonction" set  "IdMandat" = 9128005 where "IdMandat" = 9133221;
update "BREF"."Fonction" set  "IdMandat" = 9128005 where "IdMandat" = 9133222;
update "BREF"."Fonction" set  "IdMandat" = 9128005 where "IdMandat" = 9128006;
update "BREF"."Fonction" set  "IdMandat" = 9133717 where "IdMandat" = 9133718;
update "BREF"."Fonction" set  "IdMandat" = 8281731 where "IdMandat" = 9137960;
update "BREF"."Fonction" set  "IdMandat" = 8281593 where "IdMandat" = 9133061;
update "BREF"."Fonction" set  "IdMandat" = 8281593 where "IdMandat" = 9133062;
update "BREF"."Fonction" set  "IdMandat" = 8281593 where "IdMandat" = 9135920;
update "BREF"."Fonction" set  "IdMandat" = 9131540 where "IdMandat" = 9131539;
update "BREF"."Fonction" set  "IdMandat" = 9146915 where "IdMandat" = 9146914;
update "BREF"."Fonction" set  "IdMandat" = 9131540 where "IdMandat" = 9135920;
update "BREF"."Fonction" set  "IdMandat" = 9146915 where "IdMandat" = 9131539;
update "BREF"."Fonction" set  "IdMandat" = 8927276 where "IdMandat" = 9146914;
update "BREF"."Fonction" set  "IdMandat" = 8799605 where "IdMandat" = 8707764;
update "BREF"."Fonction" set  "IdMandat" = 8799605 where "IdMandat" = 8232921;
update "BREF"."Fonction" set  "IdMandat" = 8799605 where "IdMandat" = 8799604;
update "BREF"."Fonction" set  "IdMandat" = 8221237 where "IdMandat" = 8221236;
update "BREF"."Fonction" set  "IdMandat" = 9144758 where "IdMandat" = 9144757;
update "BREF"."Fonction" set  "IdMandat" = 8221195 where "IdMandat" = 9130373;
update "BREF"."Fonction" set  "IdMandat" = 8221195 where "IdMandat" = 9130374;
update "BREF"."Fonction" set  "IdMandat" = 8221195 where "IdMandat" = 8221196;
update "BREF"."Fonction" set  "IdMandat" = 8221276 where "IdMandat" = 8221275;
update "BREF"."Fonction" set  "IdMandat" = 8221225 where "IdMandat" = 8221226;
update "BREF"."Fonction" set  "IdMandat" = 8705493 where "IdMandat" = 8221635;
update "BREF"."Fonction" set  "IdMandat" = 8705493 where "IdMandat" = 8221634;
update "BREF"."Fonction" set  "IdMandat" = 8705493 where "IdMandat" = 8705494;
update "BREF"."Fonction" set  "IdMandat" = 8708926 where "IdMandat" = 8708927;
update "BREF"."Fonction" set  "IdMandat" = 8705905 where "IdMandat" = 8705906;
update "BREF"."Fonction" set  "IdMandat" = 8242309 where "IdMandat" = 8777879;
update "BREF"."Fonction" set  "IdMandat" = 8242309 where "IdMandat" = 8777878;
update "BREF"."Fonction" set  "IdMandat" = 8242309 where "IdMandat" = 8779746;
update "BREF"."Fonction" set  "IdMandat" = 8780835 where "IdMandat" = 8780836;
update "BREF"."Fonction" set  "IdMandat" = 8780832 where "IdMandat" = 8242488;
update "BREF"."Fonction" set  "IdMandat" = 8784341 where "IdMandat" = 8784222;
update "BREF"."Fonction" set  "IdMandat" = 8784341 where "IdMandat" = 8784221;
update "BREF"."Fonction" set  "IdMandat" = 8784341 where "IdMandat" = 8784340;
update "BREF"."Fonction" set  "IdMandat" = 8243796 where "IdMandat" = 8790562;
update "BREF"."Fonction" set  "IdMandat" = 8807975 where "IdMandat" = 8807974;
update "BREF"."Fonction" set  "IdMandat" = 8807177 where "IdMandat" = 8806609;
update "BREF"."Fonction" set  "IdMandat" = 8807177 where "IdMandat" = 8245147;
update "BREF"."Fonction" set  "IdMandat" = 8807177 where "IdMandat" = 8807178;
update "BREF"."Fonction" set  "IdMandat" = 8813915 where "IdMandat" = 8813916;
update "BREF"."Fonction" set  "IdMandat" = 8799844 where "IdMandat" = 8799843;
update "BREF"."Fonction" set  "IdMandat" = 8818270 where "IdMandat" = 8816785;
update "BREF"."Fonction" set  "IdMandat" = 8818270 where "IdMandat" = 8816786;
update "BREF"."Fonction" set  "IdMandat" = 8818270 where "IdMandat" = 8818271;
update "BREF"."Fonction" set  "IdMandat" = 8817534 where "IdMandat" = 8246615;
update "BREF"."Fonction" set  "IdMandat" = 8816796 where "IdMandat" = 8816795;


-- après passage des requetes ci-dessus
--Select distinct "IdMandat" from "BREF"."Fonction"
--where "IdMandat" not in
--(select distinct "IdMandat" from "BREF"."Mandat");
--136->48 mandats inexistants dans Mandat sont dans Fonction

update "BREF"."Fonction" set  "IdMandat" = 9525723 where "IdMandat" = 8558540;
update "BREF"."Fonction" set  "IdMandat" = 9525721 where "IdMandat" = 8558507;

update "BREF"."Fonction" set  "IdMandat" = 9527038 where "IdMandat" = 8688057;
update "BREF"."Fonction" set  "IdMandat" = 9526959 where "IdMandat" = 8687227;
update "BREF"."Fonction" set  "IdMandat" = 9526614 where "IdMandat" = 8685623;
update "BREF"."Fonction" set  "IdMandat" = 9526770 where "IdMandat" = 8688020;
update "BREF"."Fonction" set  "IdMandat" = 9526771 where "IdMandat" = 8686055;
update "BREF"."Fonction" set  "IdMandat" = 9526932 where "IdMandat" = 8686551;
update "BREF"."Fonction" set  "IdMandat" = 9526933 where "IdMandat" = 8688127;
update "BREF"."Fonction" set  "IdMandat" = 9526934 where "IdMandat" = 8688137;
update "BREF"."Fonction" set  "IdMandat" = 9526935 where "IdMandat" = 8688143;
update "BREF"."Fonction" set  "IdMandat" = 9527022 where "IdMandat" = 8688203;
update "BREF"."Fonction" set  "IdMandat" = 9527024 where "IdMandat" = 8686567;
update "BREF"."Fonction" set  "IdMandat" = 9527025 where "IdMandat" = 8686630;
update "BREF"."Fonction" set  "IdMandat" = 9527039 where "IdMandat" = 8685873;
update "BREF"."Fonction" set  "IdMandat" = 9527040 where "IdMandat" = 8686045;
update "BREF"."Fonction" set  "IdMandat" = 9527134 where "IdMandat" = 8686758;
update "BREF"."Fonction" set  "IdMandat" = 9527088 where "IdMandat" = 8686761;
update "BREF"."Fonction" set  "IdMandat" = 9527216 where "IdMandat" = 8686772;
update "BREF"."Fonction" set  "IdMandat" = 9527196 where "IdMandat" = 8686865;
update "BREF"."Fonction" set  "IdMandat" = 9527197 where "IdMandat" = 8687097;

delete from "BREF"."Fonction"
where "IdMandat" not in
	(select distinct "IdMandat" from "BREF"."Mandat");


-- problèmes territoires
update "BREF"."Inclusion" set "TerritoireIncluant_IdTerritoire" = '1976_19' where "TerritoireIncluant_IdTerritoire" = '1793_19';
update "BREF"."Inclusion" set "TerritoireIncluant_IdTerritoire" = '1976_90' where "TerritoireIncluant_IdTerritoire" = '1793_90';
delete from "BREF"."Inclusion"
where "TerritoireInclu_IdTerritoire" not in
(select distinct "IdTerritoire" from "BREF"."Territoire");
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1976_19' where "Territoire_IdTerritoire" = '1793_19';
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '1976_90' where "Territoire_IdTerritoire" = '1793_90';
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '67597' where "Territoire_IdTerritoire" = '67915';
update "BREF"."Mandat" set "Territoire_IdTerritoire" = '67388' where "Territoire_IdTerritoire" = '67975';
delete from "BREF"."PopulationCommune" where "Territoire_IdTerritoire" in ('54934', '55531', '44337');
INSERT INTO "BREF"."Territoire"(
	"IdTerritoire", "NomTerritoire", "TypeTerritoire", "CodeTerritoire", "DateLiee", "Actif", "Siret")
	VALUES ('1793_19', 'HAUTE CORSE', 'Departement', '2B', NULL, false, NULL);
INSERT INTO "BREF"."Territoire"(
	"IdTerritoire", "NomTerritoire", "TypeTerritoire", "CodeTerritoire", "DateLiee", "Actif", "Siret")
	VALUES ('1793_90', 'CORSE SUD', 'Departement', '2A', NULL, false, NULL);


--problèmes individus
INSERT INTO "BREF"."Individu"(
	"IdIndividu")
	VALUES (0);
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0338003', "Sources" = 'RNE,ASSEMBLEE'
where "Elu_IdIndividu" = 'ASN_0721674';
update "BREF"."Individu"
set "IdEluAssemblee" = 'PA721674', "Nationalite" = 'FRANCAISE', "CommuneNaissance" = 'SARCELLES', "DepartementNaissance" = 'VAL D''OISE', "PaysNaissance" = 'FRANCE',
"Sources" = 'RNE,ASSEMBLEE'
where "IdIndividu" = 'RNE_0338003';
INSERT INTO "BREF"."Individu"(
	"IdIndividu", "IdEluRNEHisto", "IdEluSenat", "IdEluAssemblee", "NomDeNaissance", "NomMarital1", "NomMarital2", "Prenom", "Sexe", "DateNaissance", "DateDeces",
	"Nationalite", "IdEurope", "CommuneNaissance", "DepartementNaissance", "PaysNaissance", "Prénom2", "Prénom3", "Dit", "IdPolitiquemania",
	"CommuneDeDeces", "Commentaires", "Sources")
	VALUES ('RNE_0335394', 335394, '11111C', NULL, 'LASSERRE', NULL, NULL, 'JEAN JACQUES', 'M', '11/03/1944', NULL,
        	'FRANCAIS', NULL, 'BIDACHE', 'BASSES-PYRENEES', 'FRANCE', NULL, NULL, NULL, 12654,
        	NULL, NULL, 'RNE,SENAT,POLITIQUEMANIA');
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0335394'
where "IdMandat" in (9518095, 9518096, 9518097);
delete from "BREF"."Mandat" where "IdMandat" = 9518098;
update "BREF"."Mandat"
set "Sources" = 'RNE,POLITIQUEMANIA', "IdPartiPolitique" = 161
where "IdMandat" = 8554338;
delete from "BREF"."Mandat" where "IdMandat" = 9515746;
update "BREF"."Mandat"
set "Sources" = 'RNE,POLITIQUEMANIA', "IdPartiPolitique" = 84
where "IdMandat" = 8694955;
delete from "BREF"."Mandat" where "IdMandat" = 9518099;
update "BREF"."Mandat"
set "Sources" = 'RNE,POLITIQUEMANIA', "IdPartiPolitique" = 84
where "IdMandat" = 9527198;
delete from "BREF"."Mandat" where "IdMandat" = 9518099;
update "BREF"."Mandat"
set "Sources" = 'RNE,SENAT,POLITIQUEMANIA', "IdPartiPolitique" = 84
where "IdMandat" = 8554339;
delete from "BREF"."Individu" where "IdIndividu" = 'PLM_1528297';
INSERT INTO "BREF"."Individu"(
	"IdIndividu", "IdEluRNEHisto", "IdEluSenat", "IdEluAssemblee", "NomDeNaissance", "NomMarital1", "NomMarital2", "Prenom", "Sexe", "DateNaissance", "DateDeces",
	"Nationalite", "IdEurope", "CommuneNaissance", "DepartementNaissance", "PaysNaissance", "Prénom2", "Prénom3", "Dit", "IdPolitiquemania",
	"CommuneDeDeces", "Commentaires", "Sources")
	VALUES ('RNE_0166587', 4877, NULL, NULL, 'LASSERRE', NULL, NULL, 'JEAN JACQUES', 'M', '22/07/1947', NULL,
        	'FRANCAIS', NULL, 'BIDACHE', 'BASSES-PYRENEES', 'FRANCE', NULL, NULL, NULL, 1528297,
        	NULL, NULL, 'RNE,POLITIQUEMANIA');
delete from "BREF"."Mandat" where "IdMandat" = 9517505;
update "BREF"."Mandat"
set "Sources" = 'RNE,POLITIQUEMANIA', "IdPartiPolitique" = 168
where "IdMandat" = 8551174;
delete from "BREF"."Individu" where "IdIndividu" = 'PLM_1527476';
delete from "BREF"."Mandat" where "IdMandat" = 9527198;
update "BREF"."Mandat"
set "Sources" = 'RNE,POLITIQUEMANIA', "IdPartiPolitique" = 84
where "IdMandat" = 8694956;
delete from "BREF"."Mandat" where  "IdMandat" = 9515742;
update "BREF"."Mandat"
set "Sources" = 'RNE,POLITIQUEMANIA', "IdPartiPolitique" = 136
where "IdMandat" = 8692321;
delete from "BREF"."Mandat" where "IdMandat" = 9052212;
delete from "BREF"."Individu" where "IdIndividu" = 'RNE_1323548';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0031978', "Sources" = 'RNE,POLITIQUEMANIA', "IdPartiPolitique" = 75
where "IdMandat" = 9525383;
update "BREF"."Individu"
set "CommuneNaissance" = 'ARINTHOD', "DepartementNaissance" = 'JURA', "PaysNaissance" = 'FRANCE'
where "IdIndividu" = 'RNE_0031978';
delete from "BREF"."Individu" where "IdIndividu" = 'PLM_1527625';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0031978'
where "IdMandat" = '9059246';
update "BREF"."Mandat"
set "IdNuancePolitique" = 56, "IdProfession" = 98, "Sources" = 'SENAT,POLITIQUEMANIA'
where "IdMandat" = 9526909;
delete from "BREF"."Mandat" where "IdMandat" = 8685995;    
update "BREF"."Mandat"
set "IdNuancePolitique" = 56, "IdProfession" = 98, "Sources" = 'SENAT,POLITIQUEMANIA'
where "IdMandat" = 9526910;
delete from "BREF"."Mandat" where "IdMandat" = 8687472;    
update "BREF"."Mandat"
set "IdNuancePolitique" = 68, "IdProfession" = 143, "Sources" = 'SENAT,POLITIQUEMANIA'
where "IdMandat" = 9526521;
delete from "BREF"."Mandat" where "IdMandat" = 8686287;    
update "BREF"."Mandat"
set "IdNuancePolitique" = 35, "IdProfession" = 98, "Sources" = 'SENAT,POLITIQUEMANIA'
where "IdMandat" = 9526555;
delete from "BREF"."Mandat" where "IdMandat" = 8686319;    
update "BREF"."Mandat"
set "IdNuancePolitique" = 69, "IdProfession" = 96, "Sources" = 'SENAT,POLITIQUEMANIA'
where "IdMandat" = 9526530;
delete from "BREF"."Mandat" where "IdMandat" = 8686373;    
update "BREF"."Mandat"
set "IdNuancePolitique" = 69, "IdProfession" = 96, "Sources" = 'SENAT,POLITIQUEMANIA'
where "IdMandat" = 9526531;
delete from "BREF"."Mandat" where "IdMandat" = 8686374;    
update "BREF"."Mandat"
set "IdNuancePolitique" = 69, "IdProfession" = 96, "Sources" = 'SENAT,POLITIQUEMANIA'
where "IdMandat" = 9526532;
delete from "BREF"."Mandat" where "IdMandat" = 8686375;    
update "BREF"."Mandat"
set "IdNuancePolitique" = 69, "IdProfession" = 96, "Sources" = 'SENAT,POLITIQUEMANIA'
where "IdMandat" = 9526533;
delete from "BREF"."Mandat" where "IdMandat" = 8686376;    
update "BREF"."Mandat"
set "IdNuancePolitique" = 68, "IdProfession" = 107, "Sources" = 'SENAT,POLITIQUEMANIA'
where "IdMandat" = 9526946;
delete from "BREF"."Mandat" where "IdMandat" = 8688353;
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0144292', "IdNuancePolitique" = 68, "IdProfession" = 107, "Sources" = 'SENAT,POLITIQUEMANIA'
where "IdMandat" = 8688348;
delete from "BREF"."Mandat" where "IdMandat" = 9526947;    
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0157956'
where "Elu_IdIndividu" = 'RNE_1340930';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_1013229'
where "Elu_IdIndividu" = 'RNE_1347786';
update "BREF"."Mandat"
set "DateFinMandat" = '28/03/2015', "MotifFinMandat" = 'DV', "IdNuancePolitique" = 41, "IdProfession" = 142, "Sources" = 'RNE,POLITIQUEMANIA'
where "IdMandat" = '9515986';
delete from "BREF"."Mandat" where "IdMandat" = 8694988;
update "BREF"."Mandat"
set "DateFinMandat" = '17/04/2014', "MotifFinMandat" = 'FM', "IdNuancePolitique" = 41, "IdProfession" = 142, "Sources" = 'RNE,POLITIQUEMANIA'
where "IdMandat" = '9517786';
delete from "BREF"."Mandat" where "IdMandat" = 8554350;    
update "BREF"."Mandat"
set "DateFinMandat" = '17/04/2014', "IdNuancePolitique" = 39, "IdProfession" = 142, "Sources" = 'RNE,ASSEMBLEE,POLITIQUEMANIA'
where "IdMandat" = '9525479';
delete from "BREF"."Mandat" where "IdMandat" = 8557665;
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0335385'
where "Elu_IdIndividu" = 'RNE_1185762';
update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0834231'
where "Elu_IdIndividu" = 'RNE_0862286';
delete from "BREF"."Mandat" where "IdMandat" in (9517712, 9517713);
delete from "BREF"."Mandat" where "IdMandat" = 9527407;
INSERT INTO "BREF"."Mandat"(
	"IdMandat", "TypeDuMandat_IdTypeMandat", "DateDebutMandat", "DateFinMandat", "MotifFinMandat", "Elu_IdIndividu", "NomDUsageIndividu", "Territoire_IdTerritoire", "IdNuancePolitique", "IdProfession", "Sources", "CorrectionsDate", "CorrectionsAutres", "Commentaire", "IdPartiPolitique")
	VALUES (9527407, 4, '1904-01-01', '1904-01-01', NULL, 'ARC_002', 'AMIOT', '49381', NULL, NULL, 'BOTTIN CdO', NULL, NULL, NULL, NULL);

INSERT INTO "BREF"."TypeFonction"(
    "IdTypeFonction", "TypeFonction")
    VALUES (0, '');

-- TABLE Fonction
ALTER TABLE ONLY "BREF"."Fonction"
	ADD CONSTRAINT "pk_Fonction" PRIMARY KEY ("IdFonction");

-- TABLE Inclusion
ALTER TABLE ONLY "BREF"."Inclusion"
	ADD CONSTRAINT "pk_Inclusion" PRIMARY KEY ("IdInclusion");

-- TABLE Individu
ALTER TABLE ONLY "BREF"."Individu"
	ADD CONSTRAINT "pk_Individu" PRIMARY KEY ("IdIndividu");

-- TABLE Mandat
ALTER TABLE ONLY "BREF"."Mandat"
	ADD CONSTRAINT "pk_Mandat" PRIMARY KEY ("IdMandat");

-- TABLE NuancePolitique
ALTER TABLE ONLY "BREF"."NuancePolitique"
	ADD CONSTRAINT "pk_NuancePolitique" PRIMARY KEY ("IdNuancePolitique");

-- TABLE Profession
ALTER TABLE ONLY "BREF"."Profession"
	ADD CONSTRAINT "pk_Profession" PRIMARY KEY ("CodeProfession");

-- TABLE TypeFonction
ALTER TABLE ONLY "BREF"."TypeFonction"
	ADD CONSTRAINT "pk_TypeFonction" PRIMARY KEY ("IdTypeFonction");

-- TABLE PartiPolitique
ALTER TABLE ONLY "BREF"."PartiPolitique"
	ADD CONSTRAINT "pk_PartiPolitique" PRIMARY KEY ("IdPartiPolitique");

-- TABLE PopulationCommune
ALTER TABLE ONLY "BREF"."PopulationCommune"
	ADD CONSTRAINT "pk_PopulationCommune" PRIMARY KEY ("IdPopulationCommune");

-- TABLE SuffrageElection
ALTER TABLE ONLY "BREF"."SuffrageElection"
	ADD CONSTRAINT "pk_SuffrageElection" PRIMARY KEY ("IdSuffrage");

-- TABLE Territoire
ALTER TABLE ONLY "BREF"."Territoire"
	ADD CONSTRAINT "pk_Territoire" PRIMARY KEY ("IdTerritoire");

-- TABLE TypeMandat
ALTER TABLE ONLY "BREF"."TypeMandat"
	ADD CONSTRAINT "pk_TypeMandat" PRIMARY KEY ("IdTypeMandat");
    
    -- TABLE Fonction
ALTER TABLE ONLY "BREF"."Fonction"
	ADD CONSTRAINT "fk_Fonction_TypeFonction" FOREIGN KEY ("TypeDeFonction_IdTypeFonction") REFERENCES "BREF"."TypeFonction"("IdTypeFonction"),
	ADD CONSTRAINT "fk_Fonction_Mandat" FOREIGN KEY ("IdMandat") REFERENCES "BREF"."Mandat"("IdMandat");

--TABLE Inclusion
ALTER TABLE ONLY "BREF"."Inclusion"
	ADD CONSTRAINT "fk_Inclusion_TerritoireInclu" FOREIGN KEY ("TerritoireInclu_IdTerritoire") REFERENCES "BREF"."Territoire"("IdTerritoire"),
	ADD CONSTRAINT "fk_Inclusion_TerritoireIncluant" FOREIGN KEY ("TerritoireIncluant_IdTerritoire") REFERENCES "BREF"."Territoire"("IdTerritoire");

-- TABLE Mandat
ALTER TABLE ONLY "BREF"."Mandat"
	ADD CONSTRAINT "fk_Mandat_TypeMandat" FOREIGN KEY ("TypeDuMandat_IdTypeMandat") REFERENCES "BREF"."TypeMandat"("IdTypeMandat"),
	ADD CONSTRAINT "fk_Mandat_Individu" FOREIGN KEY ("Elu_IdIndividu") REFERENCES "BREF"."Individu"("IdIndividu"),
	ADD CONSTRAINT "fk_Mandat_Territoire" FOREIGN KEY ("Territoire_IdTerritoire") REFERENCES "BREF"."Territoire"("IdTerritoire"),
	ADD CONSTRAINT "fk_Mandat_NuancePolitique" FOREIGN KEY ("IdNuancePolitique") REFERENCES "BREF"."NuancePolitique"("IdNuancePolitique"),
	ADD CONSTRAINT "fk_Mandat_Profession" FOREIGN KEY ("IdProfession") REFERENCES "BREF"."Profession"("CodeProfession"),
	ADD CONSTRAINT "fk_Mandat_PartiPolitique" FOREIGN KEY ("IdPartiPolitique") REFERENCES "BREF"."PartiPolitique"("IdPartiPolitique");

-- TABLE PopulationCommune
ALTER TABLE ONLY "BREF"."PopulationCommune"
	ADD CONSTRAINT "fk_PopulationCommune_Territoire" FOREIGN KEY ("Territoire_IdTerritoire") REFERENCES "BREF"."Territoire"("IdTerritoire");





-- ***** constraints ****


-- TABLE Fonction
ALTER TABLE ONLY "BREF"."Fonction"
    DROP CONSTRAINT "fk_Fonction_TypeFonction",
        ADD CONSTRAINT "fk_Fonction_TypeFonction" FOREIGN KEY ("TypeDeFonction_IdTypeFonction") 
        REFERENCES "BREF"."TypeFonction"("IdTypeFonction") ON UPDATE CASCADE,
    DROP CONSTRAINT "fk_Fonction_Mandat",
        ADD CONSTRAINT "fk_Fonction_Mandat" FOREIGN KEY ("IdMandat") 
        REFERENCES "BREF"."Mandat"("IdMandat") ON UPDATE CASCADE;

--TABLE Inclusion
ALTER TABLE ONLY "BREF"."Inclusion"
    DROP CONSTRAINT "fk_Inclusion_TerritoireInclu",
        ADD CONSTRAINT "fk_Inclusion_TerritoireInclu" FOREIGN KEY ("TerritoireInclu_IdTerritoire") 
        REFERENCES "BREF"."Territoire"("IdTerritoire") ON UPDATE CASCADE,
    DROP CONSTRAINT "fk_Inclusion_TerritoireIncluant",
        ADD CONSTRAINT "fk_Inclusion_TerritoireIncluant" FOREIGN KEY ("TerritoireIncluant_IdTerritoire") 
        REFERENCES "BREF"."Territoire"("IdTerritoire") ON UPDATE CASCADE;

-- TABLE Mandat
ALTER TABLE ONLY "BREF"."Mandat"
    DROP CONSTRAINT "fk_Mandat_TypeMandat",
        ADD CONSTRAINT "fk_Mandat_TypeMandat" FOREIGN KEY ("TypeDuMandat_IdTypeMandat") 
        REFERENCES "BREF"."TypeMandat"("IdTypeMandat") ON UPDATE CASCADE,
    DROP CONSTRAINT "fk_Mandat_Individu",
        ADD CONSTRAINT "fk_Mandat_Individu" FOREIGN KEY ("Elu_IdIndividu") 
        REFERENCES "BREF"."Individu"("IdIndividu") ON UPDATE CASCADE,
    DROP CONSTRAINT "fk_Mandat_Territoire",
        ADD CONSTRAINT "fk_Mandat_Territoire" FOREIGN KEY ("Territoire_IdTerritoire") 
        REFERENCES "BREF"."Territoire"("IdTerritoire") ON UPDATE CASCADE,
    DROP CONSTRAINT "fk_Mandat_NuancePolitique",
        ADD CONSTRAINT "fk_Mandat_NuancePolitique" FOREIGN KEY ("IdNuancePolitiqueRNE") 
        REFERENCES "BREF"."NuancePolitique"("IdNuancePolitique") ON UPDATE CASCADE,
    DROP CONSTRAINT "fk_Mandat_Profession",
        ADD CONSTRAINT "fk_Mandat_Profession" FOREIGN KEY ("IdProfession") 
        REFERENCES "BREF"."Profession"("CodeProfession") ON UPDATE CASCADE,
    DROP CONSTRAINT "fk_Mandat_PartiPolitique",
        ADD CONSTRAINT "fk_Mandat_PartiPolitique" FOREIGN KEY ("IdPartiPolitiquePM") 
        REFERENCES "BREF"."PartiPolitique"("IdPartiPolitique") ON UPDATE CASCADE;

-- TABLE PopulationCommune
ALTER TABLE ONLY "BREF"."PopulationCommune"
    DROP CONSTRAINT "fk_PopulationCommune_Territoire",
        ADD CONSTRAINT "fk_PopulationCommune_Territoire" FOREIGN KEY ("Territoire_IdTerritoire") 
        REFERENCES "BREF"."Territoire"("IdTerritoire") ON UPDATE CASCADE;