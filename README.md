BrefConversion v2.2.0
===================
*Conversion of the BRÉF into a relational database*

* Copyright 2020-2024 Émilie Volpi

BrefConversion is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation. For source availability and license information see licence.txt

* Lab website: [https://agorantic.univ-avignon.fr/](https://agorantic.univ-avignon.fr/)
* GitHub repo: https://github.com/BrefAvignon/BrefConversion
* Contact: Émilie Volpi <emilie.volpi@univ-avignon.fr>

-----------------------------------------------------------------------

## Description
This set of `PostgreSQL` scripts was written to convert the BRÉF from a single table to a proper relational database. The BRÉF (Base de données Révisée des Élu·es de France -- Revised Database of Representatives Elected in France) contains a description of all types of representatives elected in France under the Fifth Republic. 

<p align="center">
  <img src="./logo_bref.svg" width="30%">
</p>

The first version of this database takes the form of a single table, available on [Zenodo](https://doi.org/10.5281/zenodo.13822771) and produced by the source code available in repository [BrefInit](https://github.com/BrefAvignon/BrefInit/). It is mainly based on the RNE (Répertoire National des Élus -- National Registry of Elected Representatives), the open data base of the French Parliament (including both the National Assembly and Senate), as well as the European Parliament website. The scripts from this `BrefConversion` repository were designed to initialize a proper relational database, implement additional constraints, migrate the data from the first version of the BRÉF, clean and correct certain errors. The resulting data are available online on [Zenodo](https://doi.org/10.5281/zenodo.13834830).


## Data
The input data is the first version of the BRÉF, taking the form of a single `CSV` file . It should be imported in the `PostgreSQL` system, in schema `BREF` and table `rne_integration` so that the scripts can work.


## Installation
The scripts require to install a [`PostgreSQL`](https://www.postgresql.org/) server, or have access to a distant `PostgreSQL` database through the terminal or [`pgAdmin`](https://www.pgadmin.org/). They were tested on version 11 of `PostgreSQL`.


## Use
Run each `PosgreSQl` script in the specified order. If you want to use another schema name, you should adapt the schema name `BREF` in all concerned scripts.
1. File `1-structure_creation_2.0.0.sql` initializes the database and creates the tables.
2. File `2-data_insertion_2.0.0.sql` populates the empty dataset with the data from BRÉF v1, resulting in BRÉF v2.0.0.
3. File `3-cleaning_integration_2.0.1.sql` corrects some issues and adds field `CodeTerritoire` for overseas territories, resulting in BRÉF v2.0.1.
4. File `4-additional_corrections_2.0.2.sql` corrects issues regarding mandate differing only by their end motive.
5. File `5-additional_corrections_2.0.2.sql` extra corrections, resulting in BRÉF v2.0.2.
6. File `6-additional_corrections_v2.1.0.sql` prepares the database for the future integration of data coming from new alternative sources, resulting in BRÉF v2.1.0.
=======
This set of `PostgreSQL` scripts was written to convert the BRÉF from a single table to a proper relational database. The BRÉF (Base de données Révisée des Élu·es de France -- Revised Database of Representatives Elected in France) contains a description of all types of representatives elected in France under the Fifth Republic. The first version of this database takes the form of a single table, available on [Zenodo](https://doi.org/10.5281/zenodo.13822771) and produced by the source code available in repository [BrefInit](https://github.com/BrefAvignon/BrefInit/). It is mainly based on the RNE (Répertoire National des Élus -- National Registry of Elected Representatives), the open data base of the French Parliament (including both the National Assembly and Senate), as well as the European Parliament website. The scripts from this `BrefConversion` repository were designed to initialize a proper relational database, implement additional constraints, migrate the data from the first version of the BRÉF, clean and correct certain errors. The resulting data are available online on [Zenodo](https://doi.org/10.5281/zenodo.13834830).


## Data
The input data is the first version of the BRÉF, taking the form of a single `CSV` file . It should be imported in the `PostgreSQL` system, in schema `BREF` and table `rne_integration` so that the scripts can work.


## Installation
The scripts require to install a [`PostgreSQL`](https://www.postgresql.org/) server, or have access to a distant `PostgreSQL` database through the terminal or [`pgAdmin`](https://www.pgadmin.org/). They were tested on version 11 of `PostgreSQL`.


## Use
Run each `PosgreSQl` script in the specified order. If you want to use another schema name, you should adapt the schema name `BREF` in all concerned scripts.
1. File `1-structure_creation_2.0.0.sql` initializes the database and creates the tables.
2. File `2-data_insertion_2.0.0.sql` populates the empty dataset with the data from BRÉF v1, resulting in BRÉF v2.0.0.
3. File `3-cleaning_integration_2.0.1.sql` corrects some issues and adds field `CodeTerritoire` for overseas territories, resulting in BRÉF v2.0.1.
4. File `4-additional_corrections_2.0.2.sql` corrects issues regarding mandate differing only by their end motive.
5. File `5-additional_corrections_2.0.2.sql` extra corrections, resulting in BRÉF v2.0.2.
6. File `6-additional_corrections_v2.1.0.sql` prepares the database for the future integration of data coming from new alternative sources, resulting in BRÉF v2.1.0.
7. File `7-additional_constraints_2.2.0.sql` adds a few additional constraints.
8. File `8-translation_completion_2.2.0.sql` translates table and field names to English, resulting in BRÉF v2.2.0 (version presented in the datapaper).
9. File `9-renaming_2.2.1.sql` rename wrong fields names that were gived back by the datapaper'review, resulting in BRÉF v2.2.1
10. File `10-cleaning_political_nuance_2.2.2.sql` clean spaces (with trim) in field PolitcalNuanceName, resulting in BRÉF v2.2.0 (version presented in the datapaper v2).

## Changelog
* 2.2.2 : Database with proper field without spaces
* 2.2.1 : Database with proper names
* 2.2.0 : Addition of extra constraints, translation of the field and table names in English. This is the version used for the datapaper.
* 2.1.0 : Additional adjustments aiming at preparing the database for the future integration of data coming from new alternative sources.
* 2.0.2 : Corrections of some issues regarding mandate duplicates, more specifically, mandates differing only by their end motive.
* 2.0.1 : Correction of some issues concerning the representatives' profession identified during the integration; creation of field `CodeTerritoire` for overseas territories.
* 2.0.0 : Creation of the database with proper relational structure, and migration of data from the `CSV` file into a `PostgreSQL` system.

## References
* **[LFM'20]** V. Labatut, N. Févrat & G. Marrel, *BRÉF – Base de données Révisée des Élu·es de France*, Technical Report, Avignon Université, 2020. [⟨hal-02886580⟩](https://hal.archives-ouvertes.fr/hal-02886580)
* **[F'24]** N. Févrat, *Le "mandat de trop" ? La réélection des parlementaires et des maires en France et les conditions de sa remise en cause*, PhD Thesis, Avignon Université, 2024. [⟨tel-04550896⟩](https://hal.archives-ouvertes.fr/tel-04550896)
* **[FLVM'24]** N. Févrat , V. Labatut, É. Volpi, G. Marrel, *A Dataset of the Representatives Elected in France During the Fifth Republic*, **in submission**, 2024.
