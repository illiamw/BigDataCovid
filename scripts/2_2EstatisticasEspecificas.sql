-- EXECICIO 2 - 2
--  Qual a quantidade de pacientes presente na base de dados?
-- Quantos s˜ao homens e quantos s˜ao mulheres?
SELECT COUNT(*) FROM pacientes;
SELECT "IC_SEXO", COUNT(*) AS NUM FROM pacientes GROUP BY "IC_SEXO";
-- Qual ´e faixa et´aria dos pacientes homens e mulheres?
SELECT ( (2021-MIN("AA_NASCIMENTO")) - (2021-MAX("AA_NASCIMENTO"))) AS amplitude,
(2021-MIN("AA_NASCIMENTO")) AS velho,
(2021-MAX("AA_NASCIMENTO")) AS novo
FROM pacientes WHERE "IC_SEXO" = 'M';
SELECT ( (2021-MIN("AA_NASCIMENTO")) - (2021-MAX("AA_NASCIMENTO"))) AS amplitude,
(2021-MIN("AA_NASCIMENTO")) AS velho,
(2021-MAX("AA_NASCIMENTO")) AS novo
FROM pacientes WHERE "IC_SEXO" = 'F';
--  Qual a distribui¸c˜ao dos quartis dentro de cada faixa?
SELECT
(2021 - MAX("AA_NASCIMENTO")) AS minimo,
(2021 - PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY "AA_NASCIMENTO")) AS Q1,
(2021 - PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY "AA_NASCIMENTO")) AS Q2Median,
(2021 - PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY "AA_NASCIMENTO")) AS Q3,
(2021 - MIN("AA_NASCIMENTO")) AS maximo
FROM pacientes;
--  Qual a distribui¸c˜ao em cada gˆenero por d´ecada de vida?

SELECT 
COUNT(*) FILTER (WHERE "AA_NASCIMENTO" <= 2020 AND "AA_NASCIMENTO" > (2010))   AS "1-10",
COUNT(*) FILTER (WHERE "AA_NASCIMENTO" <= 2010 AND "AA_NASCIMENTO" > (2000))   AS "10-20",
COUNT(*) FILTER (WHERE "AA_NASCIMENTO" <= 2000 AND "AA_NASCIMENTO" > (1990))   AS "20-30",
COUNT(*) FILTER (WHERE "AA_NASCIMENTO" <= 1990 AND "AA_NASCIMENTO" > (1980))   AS "30-40",
COUNT(*) FILTER (WHERE "AA_NASCIMENTO" <= 1980 AND "AA_NASCIMENTO" > (1970))   AS "40-50",
COUNT(*) FILTER (WHERE "AA_NASCIMENTO" <= 1970 AND "AA_NASCIMENTO" > (1960))   AS "50-60",
COUNT(*) FILTER (WHERE "AA_NASCIMENTO" <= 1960 AND "AA_NASCIMENTO" > (1950))   AS "60-70",
COUNT(*) FILTER (WHERE "AA_NASCIMENTO" <= 1950 AND "AA_NASCIMENTO" > (1940))   AS "70-80",
COUNT(*) FILTER (WHERE "AA_NASCIMENTO" <= 1940 AND "AA_NASCIMENTO" > (1930))   AS "80-90"
FROM pacientes;

-- Qual a maior quantidade de exames solicitados para um ´unico
-- paciente ?


SELECT "ID_PACIENTE",
	COUNT(*) OVER(Partition by "ID_PACIENTE") Qtd
FROM exames
Order by Qtd DESC;

SELECT "ID_PACIENTE",
	COUNT(*) AS NUM FROM exames GROUP BY "ID_PACIENTE"
Order by NUM DESC;

--  Qual ´e a m´edia de exames pedidos para homens e para mulheres?

SELECT "IC_SEXO", AVG(subquery.countexames)
FROM(
SELECT "ID_PACIENTE", 
COUNT(*) OVER(PARTITION BY "ID_PACIENTE") AS countexames
FROM exames
) AS subquery
INNER JOIN pacientes ON subquery."ID_PACIENTE" = pacientes."ID_PACIENTE"
GROUP BY "IC_SEXO"

--  Quantos exames de Coronav´ırus (2019-nCoV) foram solicitados?
-- Quantos deles apresentam resultado positivo?

SELECT *
FROM exames
WHERE "DE_EXAME" LIKE '%COVID%' 
ORDER BY "DE_EXAME";

SELECT DISTINCT "DE_ANALITO"
FROM exames
WHERE "DE_RESULTADO" LIKE '%DET%' 
ORDER BY "DE_ANALITO";

SELECT DISTINCT "DE_ANALITO"
FROM exames 
WHERE ("DE_ANALITO" LIKE '%Covid%' OR "DE_ANALITO" LIKE '%Coro%')
ORDER BY "DE_ANALITO";

SELECT DISTINCT "DE_RESULTADO"
FROM exames
WHERE 	"DE_ANALITO" = 'Covid 19, Anti-Spike Neutralizantes' OR
		"DE_ANALITO" = 'Covid 19, Anticorpos IgA' OR
		"DE_ANALITO" = 'Covid 19, Anticorpos IgG, Quimioluminescência' OR
		"DE_ANALITO" = 'Covid 19, Anticorpos IgG, teste rápido' OR
		"DE_ANALITO" = 'Covid 19, Anticorpos Totais, Eletroquimiolumi' OR
		"DE_ANALITO" = 'Covid 19, Detecção por PCR%' OR
		"DE_ANALITO" = 'Covid 19, Sorologia - Conclusão' OR
		"DE_ANALITO" = 'Covid 19, Anticorpos IgG' 
ORDER BY "DE_RESULTADO" DESC;

SELECT DISTINCT "DE_ANALITO"
FROM exames
WHERE "DE_RESULTADO" LIKE '%POSI%'
ORDER BY "DE_ANALITO";

SELECT *
FROM exames
WHERE "DE_RESULTADO" LIKE '%POSI%'
ORDER BY "DE_ANALITO";


SELECT *
FROM exames
WHERE "DE_ANALITO" = 'Covid 19, Anticorpos IgA'
ORDER BY "DE_RESULTADO";






