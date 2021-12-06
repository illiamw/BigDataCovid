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
    "ID_PACIENTE" character(32) ,
    "ID_ATENDIMENTO" character(32) ,
    "DT_COLETA" date,
    "DE_ORIGEM" text ,
    "DE_EXAME" text ,
    "DE_ANALITO" text ,
    "DE_RESULTADO" text ,
    "CD_UNIDADE" text ,
    "DE_VALOR_REFERENCIA" text ,
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
COPY exames FROM 'C:/Program Files/PostgreSQL/14/data/base/HSL_Junho2021/HSL_Exames_4.csv' DELIMITER '|' CSV HEADER;




