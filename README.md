BrefConversion v2.2.0
===================
*Conversion of the BRÉF into a relational database*

* Copyright 2020-2022 Émilie Volpi

BrefConversion is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation. For source availability and license information see licence.txt

* Lab website: [https://agorantic.univ-avignon.fr/](https://agorantic.univ-avignon.fr/)
* GitHub repo: https://github.com/BrefAvignon/BrefConversion
* Contact: Émilie Volpi <emilie.volpi@univ-avignon.fr>

-----------------------------------------------------------------------

## Description
This set of `PostgreSQL` scripts was written to convert the BRÉF from a single table to a proper relational database. The BRÉF (Base de données Révisée des Élu·es de France -- Revised Database of Representatives Elected in France) contains a description of all types of representatives elected in France under the Fifth Republic. The first version of this database takes the form of a single table, available on [Zenodo](https://doi.org/10.5281/zenodo.13822771) and produced by the source code available in repository [BrefInit](https://github.com/BrefAvignon/BrefInit/). It is mainly based on the RNE (Répertoire National des Élus -- National Registry of Elected Representatives), the open data base of the French Parliament (including both the National Assembly and Senate), as well as the European Parliament website. The scripts from this `BrefConversion` repository were designed to initialize a proper relational database, implement additional constraints, migrate the data from the first version of the BRÉF, clean and correct certain errors. The resulting data are available online on [Zenodo](xxxxx).


## Data
The input data is the first version of the BRÉF, taking the form of a single `CSV` file . It should be imported in the `PostgreSQL` system, in schema `BREF` and table `rne_integration` so that the scripts can work.

There are 2 branchs :
* main branch : scripts used to created the production version of BREF, used here https://interface-bref.huma-num.fr/
* dataset1 branch : same as main until script n°5 than specifica script to create the first dataset v2.2.0


## Installation
You just need to install a `PostgreSQL` server, or have access to a distant PostgreSQL database through the terminal or `pgAdmin`.
    

## Use
Run each `PosgreSQl` script in the specified order. If you want to use another schema name, you should adapt the schema name `BREF` in all concerned scripts.


## Changelog
* 2.2.0 : Addition of extra constraints, translation of the field and table names in English. This is the version used for the datapaper.
* 2.1.0 : Additional adjustments aiming at preparing the database for the future integration of data coming from new alternative sources.
* 2.0.2 : Corrections of some issues regarding mandate duplicates, more specifically, mandates differing only by their end motive.
* 2.0.1 : Correction of some issues concerning the representatives' profession identified during the integration; creation of field `CodeTerritoire` for overseas territories.
* 2.0.0 : Creation of the database with proper relational structure, and migration of data from the `CSV` file into a `PostgreSQL` system.
   

## References
* **[LFM'20]** V. Labatut, N. Févrat & G. Marrel, *BRÉF – Base de données Révisée des Élu·es de France*, Technical Report, Avignon Université, 2020. [⟨hal-02886580⟩](https://hal.archives-ouvertes.fr/hal-02886580)
* **[F'24]** N. Févrat, *Le "mandat de trop" ? La réélection des parlementaires et des maires en France et les conditions de sa remise en cause*, PhD Thesis, Avignon Université, 2024. [⟨tel-04550896⟩](https://hal.archives-ouvertes.fr/tel-04550896)
* **[FLVM'24]** N. Févrat , V. Labatut, É. Volpi, G. Marrel, *A Dataset of the Representatives Elected in France During the Fifth Republic*, **in submission**, 2024.
