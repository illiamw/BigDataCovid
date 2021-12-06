-- EXECICIO 1
-- Limpeza e analise das bases
-- PACIENTES 
SELECT COUNT(*)
FROM pacientes;
-- Coluna = IC_SEXO-----------------------------
SELECT DISTINCT "IC_SEXO"
FROM pacientes;
-- NENHUMA  INCONSISTÊNCIA

-- Coluna = AA_NASCIMENTO-----------------------

SELECT DISTINCT "AA_NASCIMENTO"
FROM pacientes
ORDER BY "AA_NASCIMENTO";

-- INCONSISTÊNCIA: Valores não numericos(AAAA e YYYY)
SELECT COUNT("AA_NASCIMENTO")
FROM pacientes
WHERE "AA_NASCIMENTO" = 'AAAA' OR "AA_NASCIMENTO" = 'YYYY';
-- Solução: Visto que temos 14673 observações, e apenas 225 dados faltantes
-- aproximadamente 1,53% dos registros substituiremos pela média
SELECT AVG(CAST("AA_NASCIMENTO" AS INTEGER)) AS mean
FROM pacientes
WHERE "AA_NASCIMENTO" != 'AAAA' AND "AA_NASCIMENTO" != 'YYYY';

-- Média de 1977,5 ~ 1978, update com a média
UPDATE pacientes
SET "AA_NASCIMENTO" = 1978
WHERE "AA_NASCIMENTO" = 'AAAA' OR "AA_NASCIMENTO" = 'YYYY';

SELECT DISTINCT "AA_NASCIMENTO"
FROM pacientes
ORDER BY "AA_NASCIMENTO";
-- NENHUMA INCONSISTENCIA, e Alteração de tabela

ALTER TABLE pacientes 
ALTER COLUMN "AA_NASCIMENTO" TYPE INT
USING "AA_NASCIMENTO"::integer;

-- Coluna = CD_PAIS-----------------------

SELECT DISTINCT "CD_PAIS"
FROM pacientes;
-- NENHUMA INCOSISTENCIA

-- Coluna = CD_UF-----------------------

SELECT DISTINCT "CD_UF"
FROM pacientes;
-- NENHUMA INCOSISTENCIA, considerando UU como indefinido , não é possivel determinar substituto

-- Coluna = CD_MUNICIPIO-----------------------

SELECT DISTINCT "CD_MUNICIPIO"
FROM pacientes;
-- NENHUMA INCOSISTENCIA, considerando MMMM como indefinido , não é possivel determinar substituto

-- Coluna = CD_CEPREDUZIDO-----------------------

SELECT DISTINCT "CD_CEPREDUZIDO"
FROM pacientes;
-- NENHUMA INCOSISTENCIA, considerando CCCC como indefinido , não é possivel determinar substituto

--DESFECHO

-- Coluna = DT_ATENDIMENTO-----------------------------
SELECT DISTINCT "DT_ATENDIMENTO"
FROM desfechos
ORDER BY "DT_ATENDIMENTO";
-- NENHUMA  INCONSISTÊNCIA

-- Coluna = DE_TIPO_ATENDIMENTO-----------------------------
SELECT DISTINCT "DE_TIPO_ATENDIMENTO"
FROM desfechos
ORDER BY "DE_TIPO_ATENDIMENTO";
-- NENHUMA  INCONSISTÊNCIA

-- Coluna = ID_CLINICA-----------------------------
SELECT DISTINCT "ID_CLINICA"
FROM desfechos
ORDER BY "ID_CLINICA";
-- NENHUMA  INCONSISTÊNCIA

-- Coluna = DE_CLINICA-----------------------------
SELECT DISTINCT "DE_CLINICA"
FROM desfechos
ORDER BY "DE_CLINICA";
-- NENHUMA  INCONSISTÊNCIA

-- Coluna = DT_DESFECHO-----------------------------
SELECT DISTINCT "DT_DESFECHO"
FROM desfechos
ORDER BY "DT_DESFECHO";
-- INCONSISTENCIA: Valores nulos
SELECT "DE_DESFECHO"
FROM desfechos
WHERE "DT_DESFECHO" ISNULL;

SELECT COUNT(*)
FROM desfechos
WHERE "DE_DESFECHO" LIKE '%Óbito%';

SELECT COUNT(*)
FROM desfechos
WHERE "DT_DESFECHO" ISNULL;

-- Todos os valores nulos em DT_DESFECHO corresponde a óbito

-- Coluna = DE_DESFECHO-----------------------------
SELECT DISTINCT "DE_DESFECHO"
FROM desfechos
ORDER BY "DE_DESFECHO";
-- NENHUMA  INCONSISTÊNCIA

-- EXAMES

-- Coluna = DT_COLETA-----------------------------
SELECT DISTINCT "DT_COLETA"
FROM exames
ORDER BY "DT_COLETA";
-- NENHUMA  INCONSISTÊNCIA

-- Coluna = DE_ORIGEM-----------------------------
SELECT DISTINCT "DE_ORIGEM"
FROM exames
ORDER BY "DE_ORIGEM";
-- NENHUMA  INCONSISTÊNCIA

-- Coluna = DE_EXAME-----------------------------
SELECT DISTINCT "DE_EXAME"
FROM exames
ORDER BY "DE_EXAME";
-- NENHUMA  INCONSISTÊNCIA

-- Coluna = DE_ANALITO-----------------------------
SELECT DISTINCT "DE_ANALITO"
FROM exames
ORDER BY "DE_ANALITO";
-- NENHUMA  INCONSISTÊNCIA

-- Coluna = DE_RESULTADO-----------------------------
SELECT DISTINCT "DE_RESULTADO"
FROM exames
ORDER BY "DE_RESULTADO";
-- INCONSISTÊNCIA: valores sem tipo claro e escalas indefinidas
-- Inicialmente é necessário um estudo sobre o domínio desse atributo juntamente com a coluna CD_UNIDADE

-- Coluna = CD_UNIDADE-----------------------------
SELECT DISTINCT "CD_UNIDADE"
FROM exames
ORDER BY "CD_UNIDADE";
-- Necessario analise sobre o domínio em conjunto DE_RESULTADO, DE_VALOR_REFERENCIA e CD_UNIDADE

-- Coluna = DE_VALOR_REFERENCIA-----------------------------
SELECT DISTINCT "DE_VALOR_REFERENCIA"
FROM exames
ORDER BY "DE_VALOR_REFERENCIA";
-- Necessario analise sobre o domínio em conjunto DE_RESULTADO, DE_VALOR_REFERENCIA e CD_UNIDADE





