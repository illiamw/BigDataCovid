-- Escreva uma consulta que mostre quais analitos podem ser medidos em exames de ’hemograma’, em cada hospital.
select distinct "DE_ORIGEM", "DE_ANALITO"
from exames
WHERE ("DE_EXAME"= 'Hemograma')
order by "DE_ORIGEM",  "DE_ANALITO";

-- Compare os nomes dos analitos entre os diferentes hospitais, e execute um processo de atualização dos nomes, corrigindo e integrando as variantes e grafias ´obvias.
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

ALTER TABLE IF EXISTS public.examesEINSTEIN
    OWNER to postgres;


-- Carregamento arquivo CSV
COPY examesEINSTEIN("ID_PACIENTE",
    "ID_ATENDIMENTO",
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