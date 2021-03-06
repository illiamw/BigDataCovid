-- Considerando exames de Covid, substitua os valores do atributo ‘De Resultado’ que tenham valores num´ericos para ‘Positivo’ e ‘negativo’ considerando o atributo ‘CD ValorReferencia’ SELECT COUNT(*) as PositivosPorIdade
--verificando identificadores de covid
SELECT DISTINCT "DE_ANALITO", "DE_RESULTADO", "DE_VALOR_REFERENCIA"
	FROM exames
	WHERE(LOWER("DE_ANALITO") LIKE '%ovid' OR LOWER("DE_ANALITO") LIKE '%oron%')
	order by "DE_ANALITO"

-- Compreendendo a associação dos analitos e seus exames de covid
SELECT DISTINCT "DE_EXAME",  "DE_ANALITO", "DE_VALOR_REFERENCIA", "DE_RESULTADO"
	FROM exames
	WHERE ("DE_ANALITO" LIKE '%Covid 19%' OR "DE_ANALITO" LIKE '%Coronavírus%')
	order by "DE_ANALITO"
	
-- Verificando valores de referencia para covid
SELECT DISTINCT "DE_VALOR_REFERENCIA"
	FROM exames
	WHERE ("DE_ANALITO" LIKE '%Covid 19%' OR "DE_ANALITO" LIKE '%Coronavírus%')
	AND
	LOWER("DE_VALOR_REFERENCIA") NOT LIKE '%inferior%'
	
-- verificando valores dos resultado com valor de referencia 'inferior a X'

SELECT DISTINCT "DE_RESULTADO"
	FROM exames
	WHERE ("DE_ANALITO" LIKE '%Covid 19%' OR "DE_ANALITO" LIKE '%Coronavírus%')
	AND
	LOWER("DE_VALOR_REFERENCIA") LIKE '%inferior%'
	order by "DE_RESULTADO" DESC;
	
-- verificando valores dos resultado na forma indice

SELECT DISTINCT "DE_RESULTADO"
	FROM exames
	WHERE (
		(("DE_ANALITO" LIKE '%Covid 19%' OR "DE_ANALITO" LIKE '%Coronavírus%')
		AND
		LOWER("DE_VALOR_REFERENCIA") LIKE '%inferior%')
		AND
			("DE_RESULTADO" NOT LIKE '%sup%'
			AND
			 "DE_RESULTADO" NOT LIKE '%REA%'
			AND
			 "DE_RESULTADO" NOT LIKE '%N%')
	)
		
		order by "DE_RESULTADO" DESC;
	
-- Teste da manipulação dos volores ante de realizar o update	
SELECT id, "DE_VALOR_REFERENCIA","DE_RESULTADO",
	TO_NUMBER(SUBSTRING( "DE_VALOR_REFERENCIA", 11, 14) , '99D9') AS valor,
	(CASE
			WHEN TO_NUMBER(SUBSTRING( "DE_VALOR_REFERENCIA", 11, 14) , '99D9')::numeric  > TO_NUMBER( "DE_RESULTADO", '99999D9999')::numeric  THEN 'Negativo'
			ELSE 'Positivo'
		END) as replacevalor
		FROM exames
		WHERE (
			(("DE_ANALITO" LIKE '%Covid 19%' OR "DE_ANALITO" LIKE '%Coronavírus%')
			AND
			LOWER("DE_VALOR_REFERENCIA") LIKE '%inferior%')
			AND
				("DE_RESULTADO" NOT LIKE '%sup%'
				AND
				 "DE_RESULTADO" NOT LIKE '%REA%'
				AND
				 "DE_RESULTADO" NOT LIKE '%N%')
	)
		
		order by "DE_RESULTADO" DESC;
		 

-- Updade dos valores  para ‘Positivo’ e ‘Negativo’ considerando o atributo ‘DE_VALOR_REFERENCIA’
	
UPDATE  exames
	SET "DE_RESULTADO" = subquery.replacevalor
	FROM (
		SELECT id,
		TO_NUMBER(SUBSTRING( "DE_VALOR_REFERENCIA", 11, 14) , '99D9') AS valor,
		(CASE
			WHEN TO_NUMBER(SUBSTRING( "DE_VALOR_REFERENCIA", 11, 14) , '99D9')::numeric  > TO_NUMBER( "DE_RESULTADO", '99999D9999')::numeric  THEN 'Negativo'
			ELSE 'Positivo'
		END) as replacevalor
		FROM exames
		WHERE (
			(("DE_ANALITO" LIKE '%Covid 19%' OR "DE_ANALITO" LIKE '%Coronavírus%')
			AND
			LOWER("DE_VALOR_REFERENCIA") LIKE '%inferior%')
			AND
				("DE_RESULTADO" NOT LIKE '%sup%'
				AND
				 "DE_RESULTADO" NOT LIKE '%REA%'
				AND
				 "DE_RESULTADO" NOT LIKE '%N%')
		)

	)AS subquery
	WHERE exames.id = subquery.id;
	

	