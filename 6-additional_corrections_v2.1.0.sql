-- ***Individu ***

-- encore 268 individus ont même nom, prénom, date de naissance, sexe identique
select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", count(*) from "BREF"."Individu"
group by "NomDeNaissance", "Prenom", "DateNaissance", "Sexe"
having count(*) > 1
--268

--parmis eux, 173 individus sont issus excclusivement du RNEHisto
-- select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", count(*) from "BREF"."Individu"
-- where "IdEluSenat" is null and "IdEluAssemblee" is null
-- group by "NomDeNaissance", "Prenom", "DateNaissance", "Sexe"
-- having count(*) > 1
--173

--parmis ces 173, 37 ont les mêmes dates de mandat et type
-- select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", "TypeDuMandat_IdTypeMandat", "DateDebutMandat", "DateFinMandat", count(*)
-- from "BREF"."Individu" 
-- join "BREF"."Mandat" on "Mandat"."Elu_IdIndividu" = "Individu"."IdIndividu"
-- where ("NomDeNaissance", "Prenom", "DateNaissance", "Sexe") in
	-- (select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe" from
	-- (select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", count(*) from "BREF"."Individu"
	 -- where "IdEluSenat" is null and "IdEluAssemblee" is null
	-- group by "NomDeNaissance", "Prenom", "DateNaissance", "Sexe"
	-- having count(*) > 1
	-- )A)
-- group by "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", "TypeDuMandat_IdTypeMandat","DateDebutMandat", "DateFinMandat"
-- having count(*) > 1

-- select "IdIndividu", "IdEluRNEHisto", "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", "IdMandat", "TypeMandat"."TypeMandat", "DateDebutMandat", "DateFinMandat",
-- "Territoire".*, "NuancePolitique"."NuancePolitique","Profession"."LibelleProfession", "Sources"
-- from "BREF"."Individu" 
-- join "BREF"."Mandat" on "Mandat"."Elu_IdIndividu" = "Individu"."IdIndividu"
-- join "BREF"."TypeMandat" on "BREF"."TypeMandat"."IdTypeMandat" = "BREF"."Mandat"."TypeDuMandat_IdTypeMandat"
-- join "BREF"."Territoire" on "Territoire"."IdTerritoire" = "Mandat"."Territoire_IdTerritoire" 
-- join "BREF"."NuancePolitique" on "NuancePolitique"."IdNuancePolitique" = "Mandat"."IdNuancePolitique"
-- join "BREF"."Profession" on "Profession"."CodeProfession" = "Mandat"."IdProfession"
-- where ("NomDeNaissance", "Prenom", "DateNaissance", "Sexe", "TypeDuMandat_IdTypeMandat", "DateDebutMandat") in 
	-- (select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", "TypeDuMandat_IdTypeMandat", "DateDebutMandat" from
	-- (select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", "TypeDuMandat_IdTypeMandat", "DateDebutMandat", "DateFinMandat", count(*)
	-- from "BREF"."Individu" 
	-- join "BREF"."Mandat" on "Mandat"."Elu_IdIndividu" = "Individu"."IdIndividu"
	-- where ("NomDeNaissance", "Prenom", "DateNaissance", "Sexe") in
		-- (select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe" from
		-- (select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", count(*) from "BREF"."Individu"
		 -- where "IdEluSenat" is null and "IdEluAssemblee" is null
		-- group by "NomDeNaissance", "Prenom", "DateNaissance", "Sexe"
		-- having count(*) > 1
		-- )A)
	-- group by "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", "TypeDuMandat_IdTypeMandat", "DateDebutMandat", "DateFinMandat"
	-- having count(*) > 1)B)
-- order by "NomDeNaissance", "IdEluRNEHisto"
--74
-- envoyés aux chercheur -- attente retour chercheurs -> tous des homonymes : ajout au fichier des homonymes


--173 - 37
-- select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe" from 	
	-- (select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", count(*) from "BREF"."Individu"
	-- where "IdEluSenat" is null and "IdEluAssemblee" is null
	-- group by "NomDeNaissance", "Prenom", "DateNaissance", "Sexe"
	-- having count(*) > 1)C
-- where ("NomDeNaissance", "Prenom", "DateNaissance", "Sexe") not in
	-- (select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe" from 
		-- (select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", "TypeDuMandat_IdTypeMandat", "DateDebutMandat", "DateFinMandat", count(*)
		-- from "BREF"."Individu" 
		-- join "BREF"."Mandat" on "Mandat"."Elu_IdIndividu" = "Individu"."IdIndividu"
		-- where ("NomDeNaissance", "Prenom", "DateNaissance", "Sexe") in
			-- (select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe" from
			-- (select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", count(*) from "BREF"."Individu"
			 -- where "IdEluSenat" is null and "IdEluAssemblee" is null
			-- group by "NomDeNaissance", "Prenom", "DateNaissance", "Sexe"
			-- having count(*) > 1
			-- )A)
		-- group by "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", "TypeDuMandat_IdTypeMandat","DateDebutMandat", "DateFinMandat"
		-- having count(*) > 1)B)
--137

--affichage de toutes les infos pour ces 137 individus pour traitement manuel
-- select "IdIndividu", "IdEluRNEHisto", "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", "IdMandat", "TypeMandat"."TypeMandat", "DateDebutMandat", "DateFinMandat",
-- "Territoire".*, "NuancePolitique"."NuancePolitique","Profession"."LibelleProfession", "Sources"
-- from "BREF"."Individu" 
-- join "BREF"."Mandat" on "Mandat"."Elu_IdIndividu" = "Individu"."IdIndividu"
-- join "BREF"."TypeMandat" on "BREF"."TypeMandat"."IdTypeMandat" = "BREF"."Mandat"."TypeDuMandat_IdTypeMandat"
-- join "BREF"."Territoire" on "Territoire"."IdTerritoire" = "Mandat"."Territoire_IdTerritoire" 
-- join "BREF"."NuancePolitique" on "NuancePolitique"."IdNuancePolitique" = "Mandat"."IdNuancePolitique"
-- join "BREF"."Profession" on "Profession"."CodeProfession" = "Mandat"."IdProfession"
-- where ("NomDeNaissance", "Prenom", "DateNaissance", "Sexe") in
	-- (select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe" from 	
		-- (select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", count(*) from "BREF"."Individu"
		-- where "IdEluSenat" is null and "IdEluAssemblee" is null
		-- group by "NomDeNaissance", "Prenom", "DateNaissance", "Sexe"
		-- having count(*) > 1)C
	-- where ("NomDeNaissance", "Prenom", "DateNaissance", "Sexe") not in
		-- (select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe" from 
			-- (select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", "TypeDuMandat_IdTypeMandat", "DateDebutMandat", "DateFinMandat", count(*)
			-- from "BREF"."Individu" 
			-- join "BREF"."Mandat" on "Mandat"."Elu_IdIndividu" = "Individu"."IdIndividu"
			-- where ("NomDeNaissance", "Prenom", "DateNaissance", "Sexe") in
				-- (select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe" from
				-- (select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", count(*) from "BREF"."Individu"
				 -- where "IdEluSenat" is null and "IdEluAssemblee" is null
				-- group by "NomDeNaissance", "Prenom", "DateNaissance", "Sexe"
				-- having count(*) > 1
				-- )A)
			-- group by "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", "TypeDuMandat_IdTypeMandat","DateDebutMandat", "DateFinMandat"
			-- having count(*) > 1)B))
-- order by "NomDeNaissance", "Prenom", "IdIndividu", "DateDebutMandat"

--> ces 137 individus contiennet de nombreux homonymes qui ont été rajuotés au fichier des homonymes
-- les autres lignes, analysées initialement comme des doublons, sont en fait des homonymes déjà présents dans le fichier --> les correction ci-dessous ne sont donc pas passées !

--traitement partiel des 137 individus 
-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0368946'
-- where "IdMandat" = 9451807;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1167705';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0143228'
-- where "IdMandat" = 9499410;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_0644495';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0733981'
-- where "IdMandat" = 9452362;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1167718';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0826517'
-- where "IdMandat" = 9391940;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1166742';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0826517'
-- where "IdMandat" = 9391940;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1166742';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0152648'
-- where "IdMandat" = 8163774;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1168418';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0593998'
-- where "IdMandat" in (8516125, 9498810);
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1168098';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0002958'
where "IdMandat" in (8444842, 9199449);
delete from "BREF"."Individu" 
where "IdIndividu" = 'RNE_0688027';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0591154'
-- where "IdMandat" = 8749149;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1517360';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0062271'
-- where "IdMandat" = 9245884;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_0704913';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0342298'
-- where "IdMandat" = 9225620;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1164583';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0094033'
-- where "IdMandat" = 9240636;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_0332296';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0146838'
-- where "IdMandat" = 9191213;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1369925';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0591583'
-- where "IdMandat" = 9393352;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1166758';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0180502'
-- where "IdMandat" in (8882582, 8587986);
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1267212';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_1034437'
-- where "IdMandat" in (8608233, 9046766);
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1321766';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0090755'
-- where "IdMandat" = 8303559;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1166066';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0577657'
-- where "IdMandat" = 8203954;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_0683077';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0011944'
-- where "IdMandat" = 8174469;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1168657';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0543576'
-- where "IdMandat" = 8319853;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_0847417';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0173239'
-- where "IdMandat" = 9302635;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1165896';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_1122263'
-- where "IdMandat" = 9026821;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1314759';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0607153'
-- where "IdMandat" = 9005762;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_0704395';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0658363'
-- where "IdMandat" = 9512480;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1168168';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0160378'
-- where "IdMandat" = 8167064;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1169702';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_1094212'
-- where "IdMandat" = 8857709;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1258452';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0029254'
-- where "IdMandat" = 8174703;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1168668';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0144068'
-- where "IdMandat" = 9183155;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1164200';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0590105'
-- where "IdMandat" = 8836116;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_0859876';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0097506'
-- where "IdMandat" in (8412147, 9057851);
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_0991953';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0160728'
-- where "IdMandat" in (8175579, 8175580);
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_0740944';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_1031042'
-- where "IdMandat" = 9420193;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1447263';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0399834'
-- where "IdMandat" = 8895913;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_0763291';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0277063'
-- where "IdMandat" = 9454076;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_0542282';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0468339'
-- where "IdMandat" = 9184409;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1164210';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0848771'
-- where "IdMandat" = 8811039;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1239888';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0149915'
-- where "IdMandat" = 9410504;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1166892';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0596584'
-- where "IdMandat" = 8712353;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1207187';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0145084'
-- where "IdMandat" = 8156962;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1168317';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0603020'
-- where "IdMandat" = 9387258;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1166700';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_1162642'
-- where "IdMandat" = 8209234;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1499324';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0629304'
-- where "IdMandat" = 8752781;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1519242';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0037661'
-- where "IdMandat" = 8929735;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1169957';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0044269'
-- where "IdMandat" = 9488470;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1168057';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0496279'
-- where "IdMandat" = 9479682;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1167974';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0091690'
-- where "IdMandat" = 8148171;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1168242';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0057009'
-- where "IdMandat" = 9403683;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1166840';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0862716'
-- where "IdMandat" = 9256612;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1164814';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0152330'
-- where "IdMandat" = 9475320;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1167934';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0054532'
-- where "IdMandat" = 9493174;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1168076';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0449177'
-- where "IdMandat" in (8512991, 9485922);
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_0645806';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0895468'
-- where "IdMandat" = 9491838;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1524797';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0074013'
-- where "IdMandat" = 9374863;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_0399853';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0662011'
-- where "IdMandat" in (8521229, 8148702);
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1168251';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0673192'
-- where "IdMandat" = 9493233;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1168077';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0141502'
-- where "IdMandat" = 8161180;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_0685704';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0531687'
-- where "IdMandat" = 8143240;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1168215';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0839084'
-- where "IdMandat" = 9480504;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1167980';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0116188'
-- where "IdMandat" in (8516897, 8668657, 9503221);
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1168119';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0660563'
-- where "IdMandat" = 8147934;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1168239';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0335627'
-- where "IdMandat" = 8158243;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1484200';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0835851'
-- where "IdMandat" = 9371117;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_0858376';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0392285'
-- where "IdMandat" = 8143677;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_0822138';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_1015306'
-- where "IdMandat" = 8693226;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1185737';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0496537'
-- where "IdMandat" = 8168336;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1168491';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0839071'
-- where "IdMandat" in (8536115, 8222920, 8561550);
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_0877682';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0858213'
-- where "IdMandat" = 8174283;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1168649';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0737859'
-- where "IdMandat" = 8163588;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1168415';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0021879'
-- where "IdMandat" in (8520358, 8145052, 8145053);
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_0823497';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0495043'
-- where "IdMandat" = 9033599;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1317066';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0180460'
-- where "IdMandat" = 8958757;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1291385';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0837178'
-- where "IdMandat" = 8832357;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1247237';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0630221'
-- where "IdMandat" = 9045081;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1321213';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0846487'
-- where "IdMandat" = 9404666;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1166851';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0164019'
-- where "IdMandat" = 9224511;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1164574';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0540123'
-- where "IdMandat" = 8803930;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_0737452';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0077848'
-- where "IdMandat" = 8170205;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_0352296';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0355954'
-- where "IdMandat" = 9098035;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_0646187';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0496070'
-- where "IdMandat" = 8743468;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_0844235';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0148263'
-- where "IdMandat" = 8179086;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1168796';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0081604'
-- where "IdMandat" = 9467346;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1167822';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0162401'
-- where "IdMandat" = 9405717;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1166856';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0173044'
-- where "IdMandat" = 8162812;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1168400';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0044637'
-- where "IdMandat" = 8208476;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1161298';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0673201'
-- where "IdMandat" = 9463817;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1167806';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0661437'
-- where "IdMandat" in (8555286, 8307600, 8650549, 8555595);
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1186214';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0891982'
-- where "IdMandat" = 8948068;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1255349';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0161832'
-- where "IdMandat" = 8165476;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1168456';

-- update "BREF"."Mandat"
-- set "Elu_IdIndividu" = 'RNE_0031939'
-- where "IdMandat" = 8313217;
-- delete from "BREF"."Individu" 
-- where "IdIndividu" = 'RNE_1182572';

-- fin traitement partiel 137 individus - attente retour chercheur


--encore 268 individus ont même nom, prénom, date de naissance, sexe
select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", count(*) from "BREF"."Individu"
group by "NomDeNaissance", "Prenom", "DateNaissance", "Sexe"
having count(*) > 1
--268

--sur ces 268 couples, on enlève les homonymes contenu dans la table de référence homonyme issu du fichier R
select i1."IdIndividu" as i1, i2."IdIndividu" as i2
from "BREF"."Individu" i1
join "BREF"."Individu" i2 on i1."IdIndividu" != i2."IdIndividu" 
and i1."NomDeNaissance" = i2."NomDeNaissance"
and i1."Prenom" = i2."Prenom"
and i1."DateNaissance" = i2."DateNaissance"
and i1."Sexe" = i2."Sexe"
where (i1."NomDeNaissance", i1."Prenom", i1."DateNaissance", i1."Sexe") in
	(select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe" from
	(select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", count(*) from "BREF"."Individu"
	group by "NomDeNaissance", "Prenom", "DateNaissance", "Sexe"
	having count(*) > 1
	)A)
and (i2."NomDeNaissance", i2."Prenom", i2."DateNaissance", i2."Sexe") in
	(select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe" from
	(select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", count(*) from "BREF"."Individu"
	group by "NomDeNaissance", "Prenom", "DateNaissance", "Sexe"
	having count(*) > 1
	)A)
and (i1."IdIndividu", i2."IdIndividu") not in 
	(select id1, id2 from "BREF".homonyme where id2 is not null)
and (i2."IdIndividu", i1."IdIndividu") not in 
	(select id1, id2 from "BREF".homonyme where id2 is not null)--188
and i1."IdIndividu" like 'RNE%'
--94

-->ce sont les 95 ci-dessous !!

-- encore 180 individus ont même nom, prénom, date de naissance, sexe identique
select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", count(*) from "BREF"."Individu"
group by "NomDeNaissance", "Prenom", "DateNaissance", "Sexe"
having count(*) > 1
--180

--parmis eux, 85 individus encore sont issus excclusivement du RNEHisto : attente retour chercheurs pour les traiter
select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", count(*) from "BREF"."Individu"
where "IdEluSenat" is null and "IdEluAssemblee" is null
group by "NomDeNaissance", "Prenom", "DateNaissance", "Sexe"
having count(*) > 1
--85

-- 180 - 85
select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe" from 
	(select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", count(*) from "BREF"."Individu"
	group by "NomDeNaissance", "Prenom", "DateNaissance", "Sexe"
	having count(*) > 1)A
where ("NomDeNaissance", "Prenom", "DateNaissance", "Sexe") not in
	(select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe" from 
		(select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", count(*) from "BREF"."Individu"
		where "IdEluSenat" is null and "IdEluAssemblee" is null
		group by "NomDeNaissance", "Prenom", "DateNaissance", "Sexe"
		having count(*) > 1)B
		)
--95

--affichage de toutes les infos pour ces 95 individus pour traitement manuel
select "IdIndividu", "IdEluRNEHisto", "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", "IdMandat", "TypeMandat"."TypeMandat", "DateDebutMandat", "DateFinMandat",
"Territoire".*, "NuancePolitique"."NuancePolitique","Profession"."LibelleProfession", "Sources"
from "BREF"."Individu" 
join "BREF"."Mandat" on "Mandat"."Elu_IdIndividu" = "Individu"."IdIndividu"
join "BREF"."TypeMandat" on "BREF"."TypeMandat"."IdTypeMandat" = "BREF"."Mandat"."TypeDuMandat_IdTypeMandat"
join "BREF"."Territoire" on "Territoire"."IdTerritoire" = "Mandat"."Territoire_IdTerritoire" 
join "BREF"."NuancePolitique" on "NuancePolitique"."IdNuancePolitique" = "Mandat"."IdNuancePolitique"
join "BREF"."Profession" on "Profession"."CodeProfession" = "Mandat"."IdProfession"
where ("NomDeNaissance", "Prenom", "DateNaissance", "Sexe") in
	(select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe" from 
	(select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", count(*) from "BREF"."Individu"
	group by "NomDeNaissance", "Prenom", "DateNaissance", "Sexe"
	having count(*) > 1)A
where ("NomDeNaissance", "Prenom", "DateNaissance", "Sexe") not in
	(select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe" from 
		(select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", count(*) from "BREF"."Individu"
		where "IdEluSenat" is null and "IdEluAssemblee" is null
		group by "NomDeNaissance", "Prenom", "DateNaissance", "Sexe"
		having count(*) > 1)B
		))	
order by "NomDeNaissance", "Prenom", "IdIndividu", "DateDebutMandat"


--traitement des 95 individus 

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0001443'
where "IdMandat" = 8556845;
delete from "BREF"."Individu" 
where "IdIndividu" = 'ASN_0000227';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0338003'
where "IdMandat" = 8556845;
delete from "BREF"."Individu" 
where "IdIndividu" = 'ASN_0721674';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0087325'
where "IdMandat" = 8688091;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_058614M';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_1177462'
where "IdMandat" in(8686277, 8686278);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_095008D';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0003250'
where "IdMandat" = 8557150;
delete from "BREF"."Individu" 
where "IdIndividu" = 'ASN_0719942';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0842677'
where "IdMandat" in (8687140, 8685699);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_059721T';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_1337872'
where "IdMandat" = 8557197;
delete from "BREF"."Individu" 
where "IdIndividu" = 'ASN_0719910';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0003099'
where "IdMandat" = 8627475;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_004098U';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0337007'
where "IdMandat" = 8686645;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_095010W';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0000323'
where "IdMandat" = 8686357;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_095014B';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0153343'
where "IdMandat" in (8687447, 8687448, 8687449);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_074013K';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0142740'
where "IdMandat" = 8611743;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_019782L';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0577041'
where "IdMandat" in (8687873, 8687874, 8687875);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_059526S';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0000371'
where "IdMandat" = 8686595;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_095016D';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0047239'
where "IdMandat" = 8687481;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_092016Q';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0001019'
where "IdMandat" = 8686310;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_095018F';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0158775'
where "IdMandat" = 8685846;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_058113U';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0774116'
where "IdMandat" in (8687061, 8685608);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_081010Y';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0005762'
where "IdMandat" = 8558250;
delete from "BREF"."Individu" 
where "IdIndividu" = 'ASN_0760658';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0163030'
where "IdMandat" = 8686672;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_004016A';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0848345'
where "IdMandat" = 8615574;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_019812Y';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0000267'
where "IdMandat" = 8686096;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_001035Q';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0168782'
where "IdMandat" in (8687771, 8687772);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_059533R';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0810079'
where "IdMandat" = 8685620;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_098031Q';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0002837'
where "IdMandat" = 8685675;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_089034S';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0160729'
where "IdMandat" in (8687222, 8687223);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_083026R';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0162924'
where "IdMandat" = 8686320;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_095022B';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0011673'
where "IdMandat" in (8605325, 8686103);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_092017R';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0000340'
where "IdMandat" = 8686447;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_095023C';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0053864'
where "IdMandat" = 8685601;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_097010F';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0000394'
where "IdMandat" in (8688219, 8686734);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_086021Y';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0646206'
where "IdMandat" = 8687290;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_092019T';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_1156034'
where "IdMandat" = 8686571;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_095027G';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0662718'
where "IdMandat" = 8685749;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_093006S';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0000288'
where "IdMandat" = 8686206;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_095029J';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0143929'
where "IdMandat" = 8685622;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_097001E';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0046473'
where "IdMandat" in (8686273, 8686274);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_002009S';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0374895'
where "IdMandat" = 8688146;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_059574B';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0000361'
where "IdMandat" = 8686548;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_095033E';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0000329'
where "IdMandat" in (8687909, 8687910, 8686400);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_083003J';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0797081'
where "IdMandat" = 8685471;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_0000455';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0000347'
where "IdMandat" = 8686482;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_002006P';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0870069'
where "IdMandat" = 8685750;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_019820Y';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0145969'
where "IdMandat" = 8610341;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_004017B';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0014727'
where "IdMandat" = 8686332;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_004072J';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0002724'
where "IdMandat" = 8686518;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_058816V';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0869795'
where "IdMandat" in (8687525, 8686040);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_059232F';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0324758'
where "IdMandat" = 8685921;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_092025R';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0001872'
where "IdMandat" = 8687459;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_000004D';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0575127'
where "IdMandat" = 8686369;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_004068N';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0019232'
where "IdMandat" in (8687339, 8687340);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_083038V';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0159536'
where "IdMandat" in (8687241, 8687242);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_089004L';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0000343'
where "IdMandat" = 8686459;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_098054X';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0659724'
where "IdMandat" = 8556983;
delete from "BREF"."Individu" 
where "IdIndividu" = 'ASN_0719664';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0153678'
where "IdMandat" in (8685976, 8687440, 8687441);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_081011A';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0184864'
where "IdMandat" = 8687297;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_092032Q';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0529637'
where "IdMandat" = 8558012;
delete from "BREF"."Individu" 
where "IdIndividu" = 'ASN_0721632';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0000207'
where "IdMandat" = 8610686;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_098025S';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0044518'
where "IdMandat" = 8688346;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_089033R';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0000366'
where "IdMandat" in (8688082, 8686577);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_086037H';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0000266'
where "IdMandat" = 8686083;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_002004M';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0336765'
where "IdMandat" = 8686341;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_001004H';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0017398'
where "IdMandat" = 8686578;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_003004R';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0041741'
where "IdMandat" = 8686379;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_019826F';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0002964'
where "IdMandat" in (8687013, 8687014);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_058914W';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0008740'
where "IdMandat" = 8685696;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_097002F';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0000373'
where "IdMandat" in (8688124, 8686610);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_000002B';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_1107519'
where "IdMandat" = 8686298;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_019768N';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0000286'
where "IdMandat" in (8686188, 8686189, 8686190);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_091002E';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0000354'
where "IdMandat" in (8688022, 8686514);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_086041D';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0166675'
where "IdMandat" = 8686408;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_059578F';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0000415'
where "IdMandat" in (8688320, 8686834);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_086042E';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0143153'
where "IdMandat" in (8687090, 8685637);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_088002E';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0336740'
where "IdMandat" = 8686350;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_095058P';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0000446'
where "IdMandat" = 8685858;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_0000639';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0141771'
where "IdMandat" = 8685666;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_019794Q';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0153051'
where "IdMandat" in (8687471, 85995, 87472);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_074042Q';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0144292'
where "IdMandat" in (8688353, 88348);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_080036F';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0064486'
where "IdMandat" = 8685565;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_019798U';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0001651'
where "IdMandat" = 8687015;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_058938F';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0000307'
where "IdMandat" in (8686286, 86287);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_077060F';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0000073'
where "IdMandat" = 8686435;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_095064M';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0003475'
where "IdMandat" = 8685520;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_089039X';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0001146'
where "IdMandat" = 8686660;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_095065N';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0084525'
where "IdMandat" in (8688127, 8686619);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_058662V';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0000375'
where "IdMandat" in (8688128, 8686620);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_093005R';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0157360'
where "IdMandat" in (8687316, 8687317, 8687318);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_081001X';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0000080'
where "IdMandat" = 8559617;
delete from "BREF"."Individu" 
where "IdIndividu" = 'EUR_0002219';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0336716'
where "IdMandat" in (8686353, 8687865, 8687866);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_059560U';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0525481'
where "IdMandat" = 8558022;
delete from "BREF"."Individu" 
where "IdIndividu" = 'ASN_0643089';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0000127'
where "IdMandat" in (8687188, 8685772);
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_089043T';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0158468'
where "IdMandat" = 8687279;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_098026T';

update "BREF"."Mandat"
set "Elu_IdIndividu" = 'RNE_0000328'
where "IdMandat" = 8686388;
delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_095066P';

-- autre

delete from "BREF"."Individu" 
where "IdIndividu" = 'SEN_000001A';

-- fin traitement des 95 individus 


--sur ces 288 couples, on enlève les homonymes contenu dans la table de référence homonyme issu du fichier R : plus de doublons!!
select i1."IdIndividu" as i1, i2."IdIndividu" as i2
from "BREF"."Individu" i1
join "BREF"."Individu" i2 on i1."IdIndividu" != i2."IdIndividu" 
and i1."NomDeNaissance" = i2."NomDeNaissance"
and i1."Prenom" = i2."Prenom"
and i1."DateNaissance" = i2."DateNaissance"
and i1."Sexe" = i2."Sexe"
where (i1."NomDeNaissance", i1."Prenom", i1."DateNaissance", i1."Sexe") in
	(select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe" from
	(select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", count(*) from "BREF"."Individu"
	group by "NomDeNaissance", "Prenom", "DateNaissance", "Sexe"
	having count(*) > 1
	)A)
and (i2."NomDeNaissance", i2."Prenom", i2."DateNaissance", i2."Sexe") in
	(select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe" from
	(select "NomDeNaissance", "Prenom", "DateNaissance", "Sexe", count(*) from "BREF"."Individu"
	group by "NomDeNaissance", "Prenom", "DateNaissance", "Sexe"
	having count(*) > 1
	)A)
and (i1."IdIndividu", i2."IdIndividu") not in 
	(select id1, id2 from "BREF".homonyme where id2 is not null)
and (i2."IdIndividu", i1."IdIndividu") not in 
	(select id1, id2 from "BREF".homonyme where id2 is not null)--188
and i1."IdIndividu" like 'RNE%'
--0



-- ****** Population commune RNEHisto ******

SELECT setval('"BREF".id_population_commune_seq', 941623);
ALTER TABLE "BREF"."PopulationCommune" ALTER COLUMN "IdPopulationCommune" SET DEFAULT
nextval('"BREF".id_population_commune_seq'::regclass);
select max("IdPopulationCommune") from "BREF"."PopulationCommune";

update "BREF"."PopulationCommune"
set "Population" = (6001+6762)/2
where "DateReference" = '2018-01-26'
and "Territoire_IdTerritoire" = 
(select "IdTerritoire" from "BREF"."Territoire" where "CodeTerritoire" = '22251');

insert into "BREF"."PopulationCommune" ("Population", "DateReference", "Territoire_IdTerritoire")
select 3469, '2016-01-28', "IdTerritoire" from "BREF"."Territoire" where "CodeTerritoire" = '22282';

update "BREF"."PopulationCommune"
set "Population" = (127+134)/2
where "DateReference" = '2012-02-05'
and "Territoire_IdTerritoire" = 
(select "IdTerritoire" from "BREF"."Territoire" where "CodeTerritoire" = '52465');

update "BREF"."PopulationCommune"
set "Population" = (41+72)/2
where "DateReference" = '2011-12-11'
and "Territoire_IdTerritoire" = 
(select "IdTerritoire" from "BREF"."Territoire" where "CodeTerritoire" = '66154');



-- ****** Nettoyage doublons mandats ******

CREATE TABLE "BREF"."nettoie"
(
    id_rne integer,
    date_debut_mandat date,
    date_fin_mandat date,
    date_debut_fonction date,
    date_fin_fonction date,
    libelle_mandat character varying(250)
);


CREATE OR REPLACE FUNCTION "BREF".nettoyage1datefinmandat() RETURNS integer AS $$
DECLARE
	mandats record;
	mandat record;
	i int;
	ex boolean;
	datem date;
BEGIN
    FOR mandats IN
		select id_rne, libelle_mandat, date_debut_mandat, count(*)
		from "saveBREF".rne_integration
		group by id_rne, libelle_mandat, date_debut_mandat
		having count(*)>1 --1808
	LOOP
		i=0;
		ex=false;
		FOR mandat IN
			select id_rne, date_debut_mandat, date_fin_mandat , date_debut_fonction, date_fin_fonction
			from "saveBREF".rne_integration
			where id_rne = mandats.id_rne
			and date_debut_mandat = mandats.date_debut_mandat
			and libelle_mandat = mandats.libelle_mandat
			order by date_fin_mandat desc
		LOOP
			if ex = true then
				raise notice 'exit %', ex;
				exit;
			end if;
			if i=0 then
				if mandat.date_fin_mandat is not null then
					ex := true;
					raise notice 'datefin null % % ', ex, mandats.id_rne;
					--exit;
				end if;
			else
				if mandat.date_fin_mandat is not null then
					raise notice 'insert %', mandats.id_rne;
					insert into "BREF".nettoie(id_rne, date_debut_mandat, date_fin_mandat, date_debut_fonction, date_fin_fonction, libelle_mandat) values (mandat.id_rne, mandat.date_debut_mandat, mandat.date_fin_mandat , mandat.date_debut_fonction, mandat.date_fin_fonction, mandats.libelle_mandat);
				else
					raise notice 'noinsert %', mandats.id_rne;
				end if;
			end if;
			i = i+1;
		end loop;
	end loop;
	return 1;
END;
$$ LANGUAGE plpgsql;

--select id_rne, date_debut_mandat, date_fin_mandat , date_debut_fonction, date_fin_fonction
--from "saveBREF".rne_integration
--where id_rne = 5687
--and date_debut_mandat = '2001-03-11'
--and libelle_mandat = 'CONSEILLER MUNICIPAL'
--order by date_fin_mandat desc
--select distinct "TypeTerritoire" from "BREF"."Territoire"

--delete from "BREF".nettoie 

select * from "BREF".nettoyage1datefinmandat()

select * from "BREF".nettoie order by id_rne--972

CREATE OR REPLACE FUNCTION "BREF".nettoyage2datefinmandat() RETURNS integer AS $$
DECLARE
	mandats record;
	fonctions record;
	id_individu varchar;
	id_mandat int;
	id_fonction int;
	new_id_mandat int;
	id_territoire_old_mandat varchar;
	id_territoire_new_mandat varchar;
	code_territoire_old_mandat varchar;
	code_territoire_new_mandat varchar;
	type_territoire_old_mandat varchar;
	type_territoire_new_mandat varchar;
BEGIN
	--pour tous les mandats de la table nettoie
    FOR mandats IN
		select id_rne, date_debut_mandat, date_fin_mandat, libelle_mandat from "BREF".nettoie order by id_rne
	loop	
		select "IdIndividu" into id_individu from "BREF"."Individu" where "IdEluRNEHisto" = mandats.id_rne;
		select "IdMandat" into id_mandat from "BREF"."Mandat" 
		join "BREF"."TypeMandat" on "TypeMandat"."IdTypeMandat" = "Mandat"."TypeDuMandat_IdTypeMandat"
		where "DateDebutMandat" = mandats.date_debut_mandat and "DateFinMandat" = mandats.date_fin_mandat 
		and "Elu_IdIndividu" = id_individu and "TypeMandat" = mandats.libelle_mandat;
		raise notice 'id_rne date_debut date_fin: % % %', mandats.id_rne, mandats.date_debut_mandat, mandats.date_fin_mandat;
		
		--recherche du nouveau mandat
		select "IdMandat" into new_id_mandat from "BREF"."Mandat" 
		where "DateDebutMandat" = mandats.date_debut_mandat and "Elu_IdIndividu" = id_individu and "DateFinMandat" is null
		and "TypeDuMandat_IdTypeMandat" = (select "TypeDuMandat_IdTypeMandat" from "BREF"."Mandat" 
										   where "IdMandat" = id_mandat);
		IF NOT FOUND THEN
			select "IdMandat" into new_id_mandat from "BREF"."Mandat" 
			where "DateDebutMandat" = mandats.date_debut_mandat and "Elu_IdIndividu" = id_individu and "IdMandat" != id_mandat
			and "TypeDuMandat_IdTypeMandat" = (select "TypeDuMandat_IdTypeMandat" from "BREF"."Mandat" 
										   	where "IdMandat" = id_mandat);
			raise notice 'help';
		end if;
		
		--s'il n'y a pas de nouveau mandat, on ne fait rien, on passe au mandat d'après
		if new_id_mandat is null then
				raise notice 'exit';
				
		--sinon traitement
		else
			select "Territoire_IdTerritoire" into id_territoire_old_mandat from "BREF"."Mandat" where "IdMandat" = id_mandat;
			select "Territoire_IdTerritoire" into id_territoire_new_mandat from "BREF"."Mandat" where "IdMandat" = new_id_mandat;
			select "TypeTerritoire" into type_territoire_old_mandat from "BREF"."Territoire" where "IdTerritoire" = id_territoire_old_mandat;
			select "TypeTerritoire" into type_territoire_new_mandat from "BREF"."Territoire" where "IdTerritoire" = id_territoire_new_mandat;
			
			--si l'ancien et le nouveau mandat n'ont pas le même territoire
			if id_territoire_old_mandat != id_territoire_new_mandat then
			
				--si c'est une commune : on ne fait rien
				if type_territoire_old_mandat = 'Commune' then
					raise notice 'alerte commune % % %', type_territoire_old_mandat, id_territoire_old_mandat, id_territoire_new_mandat;
					select "CodeTerritoire" into code_territoire_old_mandat from "BREF"."Territoire" where "IdTerritoire" = id_territoire_old_mandat;
					select "CodeTerritoire" into code_territoire_new_mandat from "BREF"."Territoire" where "IdTerritoire" = id_territoire_new_mandat;
					if left(code_territoire_old_mandat, 2) = left(code_territoire_new_mandat, 2) then
						raise notice 'même département % %', code_territoire_old_mandat, code_territoire_new_mandat;
						
						--réffectation des fonctions de l'ancien mandat sur le nouveau
						FOR fonctions IN
							select * from "BREF"."Fonction" where "IdMandat" = id_mandat
						loop
							raise notice 'a update idfonction idoldmandat id newmandat: % % %', fonctions."IdFonction", id_mandat, new_id_mandat;
							update "BREF"."Fonction" set "IdMandat" = new_id_mandat
							where "IdFonction" = fonctions."IdFonction";
						end loop;
					
						--suppression ancien mandat
						raise notice 'a idindividu idmandat: % %', id_individu, id_mandat;	
						delete from "BREF"."Mandat" where "IdMandat" = id_mandat;
					else
						raise notice 'pas même département % %', code_territoire_old_mandat, code_territoire_new_mandat;
					end if;
				end if;
				
				--si epci
				if type_territoire_old_mandat = 'EPCI' then
				
					--on rend inactif le plus vieux epci et actif le nouveau
					-- et on affecte le nouveau mandat à l'ancien epci s'il ne l'est pas
					if id_territoire_old_mandat < id_territoire_new_mandat then
						raise notice 'update idterritoire inactif: %', id_territoire_old_mandat;
						update "BREF"."Territoire" set "Actif" = false
						where "IdTerritoire" = id_territoire_old_mandat;
						raise notice 'update idterritoire actif: %', id_territoire_new_mandat;
						update "BREF"."Territoire" set "Actif" = true
						where "IdTerritoire" = id_territoire_new_mandat;
						raise notice 'update mandat oldepci : % %', new_id_mandat, id_territoire_old_mandat;
						update "BREF"."Mandat" set "Territoire_IdTerritoire" = id_territoire_old_mandat
						where "IdMandat" = new_id_mandat;
					else 
						raise notice 'update idterritoire inactif: %', id_territoire_new_mandat;
						update "BREF"."Territoire" set "Actif" = false
						where "IdTerritoire" = id_territoire_new_mandat;
						raise notice 'update idterritoire actif: %', id_territoire_old_mandat;
						update "BREF"."Territoire" set "Actif" = true
						where "IdTerritoire" = id_territoire_old_mandat;
					end if;
					
					--réffectation des fonctions de l'ancien mandat sur le nouveau
					FOR fonctions IN
						select * from "BREF"."Fonction" where "IdMandat" = id_mandat
					loop
						raise notice 'a update idfonction idoldmandat id newmandat: % % %', fonctions."IdFonction", id_mandat, new_id_mandat;
						update "BREF"."Fonction" set "IdMandat" = new_id_mandat
						where "IdFonction" = fonctions."IdFonction";
					end loop;
					
					--suppression ancien mandat
					raise notice 'a idindividu idmandat: % %', id_individu, id_mandat;	
					delete from "BREF"."Mandat" where "IdMandat" = id_mandat;
				end if;
			--si l'ancien et le nouveau mandat ont le même territoire
			else
				--réffectation des fonctions de l'ancien mandat sur le nouveau
				FOR fonctions IN
					select * from "BREF"."Fonction" where "IdMandat" = id_mandat
				loop
					raise notice 'a update idfonction idoldmandat id newmandat: % % %', fonctions."IdFonction", id_mandat, new_id_mandat;
					update "BREF"."Fonction" set "IdMandat" = new_id_mandat
					where "IdFonction" = fonctions."IdFonction";
				end loop;
			
				--suppression ancien mandat
				raise notice 'b idindividu idmandat: % %', id_individu, id_mandat;	
				delete from "BREF"."Mandat" where "IdMandat" = id_mandat;
			end if;
			
		end if;
	end loop;
	return 1;
END;
$$ LANGUAGE plpgsql;

select * from "BREF".nettoyage2datefinmandat()

--select * from "BREF"."Mandat" 
--full outer join "BREF"."Fonction" on "Fonction"."IdMandat" = "Mandat"."IdMandat"
---where "Elu_IdIndividu" = 'RNE_0464031'and "DateDebutMandat" = '2014-03-23'

--select * from "BREF"."Territoire" where "IdTerritoire" in ('200003176', '243300738')

SELECT *
    FROM "BREF"."Mandat"
    JOIN "BREF"."Individu"
        ON "Individu"."IdIndividu" = "Mandat"."Elu_IdIndividu"
    JOIN "BREF"."Territoire"
        ON "Mandat"."Territoire_IdTerritoire" = "Territoire"."IdTerritoire"
    JOIN "BREF"."TypeMandat"
        ON "Mandat"."TypeDuMandat_IdTypeMandat" = "TypeMandat"."IdTypeMandat"
    WHERE ("Elu_IdIndividu", "DateDebutMandat", "TypeMandat"."TypeMandat") IN
        (SELECT "ID universel", "Date debut mandat", "Libelle mandat"
            FROM "FlashRNE"."All")
    AND "DateFinMandat" IS NOT NULL;
--1366 -> 459



