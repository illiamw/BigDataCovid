-- Carregamento de tabelas
--  PACIENTES

--  Tabela:
-- Table: public.pacientes

DROP TABLE IF EXISTS public.pacientes CASCADE;

CREATE TABLE IF NOT EXISTS public.pacientes
(
    "ID_PACIENTE" character(32)  PRIMARY KEY,
    "IC_SEXO" character(1) ,
    "AA_NASCIMENTO" character(4) ,
    "CD_PAIS" character(2) ,
    "CD_UF" character(2) ,
    "CD_MUNICIPIO" text ,
    "CD_CEPREDUZIDO" character(5) 
)

TABLESPACE pg_default;

/* -- ALTER TABLE IF EXISTS public.pacientes
--     OWNER to postgres; */

-- Carregamentoarquivo CSV
COPY pacientes FROM 'C:/Program Files/PostgreSQL/14/data/base/HSL_Junho2021/HSL_Pacientes_4.csv' DELIMITER ',' CSV HEADER;

--  DESFECHOS

DROP TABLE IF EXISTS public.desfechos CASCADE;

CREATE TABLE IF NOT EXISTS public.desfechos
(
    "ID_PACIENTE" character(32) ,
    "ID_ATENDIMENTO" text  NOT NULL,
    "DT_ATENDIMENTO" date,
    "DE_TIPO_ATENDIMENTO" text ,
    "ID_CLINICA" integer,
    "DE_CLINICA" text ,
    "DT_DESFECHO" date,
    "DE_DESFECHO" text ,
    CONSTRAINT desfecho_pkey PRIMARY KEY ("ID_ATENDIMENTO"),
    CONSTRAINT "ID_PACIENTE" FOREIGN KEY ("ID_PACIENTE")
        REFERENCES public.pacientes ("ID_PACIENTE") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.desfechos
    OWNER to postgres;


-- Carregamento arquivo CSV
COPY desfechos FROM 'C:/Program Files/PostgreSQL/14/data/base/HSL_Junho2021/HSL_Desfechos_4.csv' DELIMITER '|' CSV HEADER;


--  EXAMES

-- Table: public.exames

DROP TABLE IF EXISTS public.exames CASCADE;

CREATE TABLE IF NOT EXISTS public.exames
(
	id SERIAL,
    "ID_PACIENTE" character(32) ,
    "ID_ATENDIMENTO" character(32) ,
    "DT_COLETA" date,
    "DE_ORIGEM" text ,
    "DE_EXAME" text ,
    "DE_ANALITO" text ,
    "DE_RESULTADO" text ,
    "CD_UNIDADE" text ,
    "DE_VALOR_REFERENCIA" text ,
	PRIMARY KEY (id),
    CONSTRAINT "ID_PACIENTE" FOREIGN KEY ("ID_PACIENTE")
        REFERENCES public.pacientes ("ID_PACIENTE") MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.exames
    OWNER to postgres;


-- Carregamento arquivo CSV
COPY exames("ID_PACIENTE",
    "ID_ATENDIMENTO",
    "DT_COLETA",
    "DE_ORIGEM",
    "DE_EXAME",
    "DE_ANALITO" ,
    "DE_RESULTADO" ,
    "CD_UNIDADE",
    "DE_VALOR_REFERENCIA") FROM 'C:/Program Files/PostgreSQL/14/data/base/HSL_Junho2021/HSL_Exames_4.csv' DELIMITER '|' CSV HEADER;


-- Questao 5 -- Compare os nomes dos analitos entre os diferentes hospitais, e execute um processo de atualização dos nomes, corrigindo e integrando as variantes e grafias ´obvias.
DROP TABLE IF EXISTS public.examesBPSP CASCADE;

CREATE TABLE IF NOT EXISTS public.examesBPSP
(
	id SERIAL,
    "ID_PACIENTE" character(32) ,
    "ID_ATENDIMENTO" character(32) ,
    "DT_COLETA" date,
    "DE_ORIGEM" text ,
    "DE_EXAME" text ,
    "DE_ANALITO" text ,
    "DE_RESULTADO" text ,
    "CD_UNIDADE" text ,
    "DE_VALOR_REFERENCIA" text ,
	PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.examesBPSP
    OWNER to postgres;


-- Carregamento arquivo CSV
COPY examesBPSP("ID_PACIENTE",
    "ID_ATENDIMENTO",
    "DT_COLETA",
    "DE_ORIGEM",
    "DE_EXAME",
    "DE_ANALITO" ,
    "DE_RESULTADO" ,
    "CD_UNIDADE",
    "DE_VALOR_REFERENCIA") FROM 'C:/Program Files/PostgreSQL/14/data/base/HSL_Junho2021/bpsp_exames.csv' DELIMITER '|' CSV HEADER;
	
DROP TABLE IF EXISTS public.examesEINSTEIN CASCADE;

CREATE TABLE IF NOT EXISTS public.examesEINSTEIN
(
	id SERIAL,
    "ID_PACIENTE" text ,
    "DT_COLETA" date,
    "DE_ORIGEM" text ,
    "DE_EXAME" text ,
    "DE_ANALITO" text ,
    "DE_RESULTADO" text ,
    "CD_UNIDADE" text ,
    "DE_VALOR_REFERENCIA" text ,
	PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.examesEINSTEIN
    OWNER to postgres;


-- Carregamento arquivo CSV
COPY examesEINSTEIN("ID_PACIENTE",
    "DT_COLETA",
    "DE_ORIGEM",
    "DE_EXAME",
    "DE_ANALITO" ,
    "DE_RESULTADO" ,
    "CD_UNIDADE",
    "DE_VALOR_REFERENCIA") FROM 'C:/Program Files/PostgreSQL/14/data/base/HSL_Junho2021/EINSTEIN_Exames_2.csv' DELIMITER '|' CSV HEADER;
	
DROP TABLE IF EXISTS public.examesHC CASCADE;

CREATE TABLE IF NOT EXISTS public.examesHC
(
	id SERIAL,
    "ID_PACIENTE" text ,
    "ID_ATENDIMENTO" character(32) ,
    "DT_COLETA" date,
    "DE_ORIGEM" text ,
    "DE_EXAME" text ,
    "DE_ANALITO" text ,
    "DE_RESULTADO" text ,
    "CD_UNIDADE" text ,
    "DE_VALOR_REFERENCIA" text ,
	PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.examesHC
    OWNER to postgres;


-- Carregamento arquivo CSV
COPY examesHC("ID_PACIENTE",
    "ID_ATENDIMENTO",
    "DT_COLETA",
    "DE_ORIGEM",
    "DE_EXAME",
    "DE_ANALITO" ,
    "DE_RESULTADO" ,
    "CD_UNIDADE",
    "DE_VALOR_REFERENCIA") FROM 'C:/Program Files/PostgreSQL/14/data/base/HSL_Junho2021/HC_EXAMES_1.csv' DELIMITER '|' CSV HEADER;
	
DROP TABLE IF EXISTS public.examesFL CASCADE;

CREATE TABLE IF NOT EXISTS public.examesFL
(
	id SERIAL,
    "ID_PACIENTE" text ,
    "ID_ATENDIMENTO" character(32) ,
    "DT_COLETA" date,
    "DE_ORIGEM" text ,
    "DE_EXAME" text ,
    "DE_ANALITO" text ,
    "DE_RESULTADO" text ,
    "CD_UNIDADE" text ,
    "DE_VALOR_REFERENCIA" text ,
	PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.examesFL
    OWNER to postgres;


-- Carregamento arquivo CSV
COPY examesFL("ID_PACIENTE",
    "ID_ATENDIMENTO",
    "DT_COLETA",
    "DE_ORIGEM",
    "DE_EXAME",
    "DE_ANALITO" ,
    "DE_RESULTADO" ,
    "CD_UNIDADE",
    "DE_VALOR_REFERENCIA") FROM 'C:/Program Files/PostgreSQL/14/data/base/HSL_Junho2021/GrupoFleury_Exames_4.csv' DELIMITER '|' CSV HEADER;

