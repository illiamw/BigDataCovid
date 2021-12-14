-- Escreva um comando em SQL que crie o histograma tri-dimensional equi-largura de distribuição de exames (da tabela ExamLabs), tendo por dimensões:

-- OBS: A Base de Dados COVID Hospital Sírio-Libanês, trata-se de apenas um hospital, logo não aplica-se a terceira dimensão "DE_Hospital"


--- Teste de contagem

SELECT  
COUNT(*) FILTER (WHERE LOWER("DE_ORIGEM") LIKE '%hosp%')   AS "Hospital",
COUNT(*) FILTER (WHERE LOWER("DE_ORIGEM") LIKE '%lab%')   AS "Laboratório",
COUNT(*) FILTER (WHERE LOWER("DE_ORIGEM") LIKE '%atend%')   AS "Hospital",
COUNT(*) FILTER (WHERE LOWER("DE_ORIGEM") LIKE '%intern%' OR LOWER("DE_ORIGEM") LIKE '%pronto%')   AS "Atendimento",
COUNT(*) FILTER (	WHERE (LOWER("DE_ORIGEM") NOT LIKE '%hosp%'
				 	AND
					LOWER("DE_ORIGEM") NOT LIKE '%lab%'
				 	AND
					LOWER("DE_ORIGEM") NOT LIKE '%atend%'
					AND
					LOWER("DE_ORIGEM") NOT LIKE '%intern%'
				 	AND
					LOWER("DE_ORIGEM") NOT LIKE '%pronto%'
					)
				)   AS "Outros"
FROM exames;

-- Consulta Histograma Bi-dimensional "DE_ORIGEM"x"DE_EXAME"

WITH DIMENSOES AS (SELECT
id,
(CASE
	WHEN LOWER("DE_ORIGEM") LIKE '%hosp%'   THEN 'Hospital'
	WHEN LOWER("DE_ORIGEM") LIKE '%lab%'   THEN 'Laboratório'
	WHEN LOWER("DE_ORIGEM") LIKE '%atend%'  THEN 'Hospital'
	WHEN LOWER("DE_ORIGEM") LIKE '%intern%' OR LOWER("DE_ORIGEM") LIKE '%pronto%'   THEN 'Atendimento'
	ELSE 'Outros'
END) as OrigemCol,
(CASE
		WHEN LOWER("DE_EXAME") LIKE '%hemogr%'   THEN 'Hemograma'
		WHEN LOWER("DE_EXAME") LIKE '%colest%'   THEN 'Colesterol'
		WHEN 
			LOWER("DE_EXAME") LIKE '%covid%' 
			OR LOWER("DE_EXAME") LIKE '%pcr%' 
			OR LOWER("DE_EXAME") LIKE '%igm%'
			OR LOWER("DE_EXAME") LIKE '%igg%'THEN 'Covid'
		ELSE 'Outros'
	END) as ExamesCol
FROM exames)

SELECT 
	DIMENSOES.OrigemCol,
	DIMENSOES.ExamesCol,	
	Count(*) Contagem
	FROM DIMENSOES
	GROUP BY DIMENSOES.OrigemCol, DIMENSOES.ExamesCol
	ORDER BY DIMENSOES.OrigemCol, DIMENSOES.ExamesCol;

	




