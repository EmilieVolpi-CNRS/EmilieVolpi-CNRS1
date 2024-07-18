CREATE DATABASE bref WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'French_France.1252';
CREATE SCHEMA "BREF";

--sequences
CREATE SEQUENCE "BREF".id_fonction_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE "BREF".id_inclusion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE "BREF".id_mandat_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE "BREF".id_nuance_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE "BREF".id_population_commune_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE "BREF".id_profession_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;	
CREATE SEQUENCE "BREF".id_typefonction_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE SEQUENCE "BREF".id_typemandat_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
	
-- tables

CREATE TABLE "BREF"."Territoire"(
	"IdTerritoire" character varying,
    "NomTerritoire" character varying(250),
    "TypeTerritoire" character varying(250) NOT NULL,
    "CodeTerritoire" character varying,
    "DateLiee" date,
    "Actif" boolean
);

-- Table: Inclusion
CREATE TABLE "BREF"."Inclusion"(
	"IdInclusion" integer DEFAULT nextval('"BREF".id_inclusion_seq'::regclass) NOT NULL,
    "TerritoireInclu_IdTerritoire" character varying NOT NULL,
    "TerritoireIncluant_IdTerritoire" character varying NOT NULL,
    "DateDebutInclusion" date,
    "DateFinInclusion" date
);

-- Table: Individu
CREATE TABLE "BREF"."Individu"(
    "IdIndividu" character varying NOT NULL,
    "IdEluRNEHisto" integer,
    "IdEluSenat" character varying,
    "IdEluAssemblee" character varying,
    "NomDeNaissance" character varying(250),
    "NomMarital1" character varying(250),
    "NomMarital2" character varying(250),
    "Prenom" character varying(250),
    "Sexe" character(1),
    "DateNaissance" date,
    "DateDeces" date,
    "Nationalite" character varying,
    "IdEurope" character varying,
    "CommuneNaissance" character varying,
    "DepartementNaissance" character varying,
    "PaysNaissance" character varying
);

-- Table: Mandat
CREATE TABLE "BREF"."Mandat"(
    "IdMandat" integer DEFAULT nextval('"BREF".id_mandat_seq'::regclass) NOT NULL,
    "TypeDuMandat_IdTypeMandat" integer NOT NULL,
    "DateDebutMandat" date NOT NULL,
    "DateFinMandat" date,
    "MotifFinMandat" character varying(250),
    "Elu_IdIndividu" character varying NOT NULL,
    "NomDUsageIndividu" character varying(250) NOT NULL,
    "Territoire_IdTerritoire" character varying NOT NULL,
    "IdNuancePolitique" integer,
    "IdProfession" integer,
    "Sources" character varying,
    "CorrectionsDate" boolean,
    "CorrectionsAutres" boolean
);

-- Table: Fonction
CREATE TABLE "BREF"."Fonction"(
	"IdFonction" integer DEFAULT nextval('"newBREF".id_fonction_seq'::regclass) NOT NULL,
    "DateDebutFonction" date,
    "DateFinFonction" date,
    "MotifFinFonction" character varying(250),
    "TypeDeFonction_IdTypeFonction" integer NOT NULL,
    "IdMandat" integer
);

-- Table: NuancePolitique
CREATE TABLE "BREF"."NuancePolitique"(
    "IdNuancePolitique" integer DEFAULT nextval('"BREF".id_nuance_seq'::regclass) NOT NULL,
    "NuancePolitique" character(25)
);

-- Table: PopulationCommune
CREATE TABLE "BREF"."PopulationCommune"(
    "IdPopulationCommune" integer DEFAULT nextval('"BREF".id_population_commune_seq'::regclass) NOT NULL,
    "Population" integer NOT NULL,
    "DateReference" date NOT NULL,
    "Territoire_IdTerritoire" character varying NOT NULL
);

-- Table: Profession
CREATE TABLE "BREF"."Profession"(
    "CodeProfession" integer DEFAULT nextval('"BREF".id_profession_seq'::regclass) NOT NULL,
    "LibelleProfession" character varying(250) NOT NULL
);

-- Table: TypeFonction
CREATE TABLE "BREF"."TypeFonction"(
    "IdTypeFonction" integer DEFAULT nextval('"newBREF".id_typefonction_seq'::regclass) NOT NULL,
    "TypeFonction" character varying(250) NOT NULL
);

-- Table: TypeMandat
CREATE TABLE "BREF"."TypeMandat"(
    "IdTypeMandat" integer DEFAULT nextval('"newBREF".id_typemandat_seq'::regclass) NOT NULL,
    "TypeMandat" character varying(250) NOT NULL
);


