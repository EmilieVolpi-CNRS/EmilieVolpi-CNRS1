# BREF

This repository contains all SQL script that were played on BREF database from its creation, including creation, migration of data, constraints, cleanings, evolutions etc

Copyright 2020-2022 Emilie Volpi

BrefInit is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation. For source availability and license information see licence.txt

    Lab website: [http://lia.univ-avignon.fr/](https://agorantic.univ-avignon.fr/)
    GitHub repo: https://github.com/CompNet/Bref
    Contact: emilie.volpi@univ-avignon.fr


Description

This set of PostgreSQL scripts was written to create the PostgreSQL Database BRÉF (Base de données Révisée des Élu·es de France -- Revised Database of Elected Representatives in France), a data base containing a description of all types of representatives elected in France under the Fifth Republic. A csv file - BREF version 1 - was created with the BREFInit project. It is mainly based on the RNE (Répertoire National des Élus -- National Registry of Elected Representatives), the open data base of the French Parliament (including both the National Assembly and Senate), as well as the European Parliament website. This csv file was then migrated to PostgreSQL BREF database here.
Data

There are 2 branchs :
main branch : scripts used to created the production version of BREF, used here https://interface-bref.huma-num.fr/
dataset1 branch : same as main until script n°5 than specifica script to create the first dataset v2.2.0


Installation

You just need to install PostgreSQL or have access to a distant PostgreSQL database (with terminal or pgAdmin)
    

Use

Launch each PosgreSQl script in order
[mettre DOI de la v1.1.0)


Realease

V.2.1.1 : https://github.com/BrefAvignon/BREF/releases/tag/v.2.1.1
V.2.0.2 : https://github.com/BrefAvignon/BREF/releases/tag/v.2.0.2
V.2.0.0 : https://github.com/BrefAvignon/BREF/releases/tag/v.2.0.0


Changelog

   

References

    
