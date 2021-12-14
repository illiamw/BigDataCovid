-- Escreva um comando em SQL que crie o histograma tri-dimensional equi-largura de distribuição de exames (da tabela ExamLabs), tendo por dimensões:

SELECT
(CASE
	WHEN LOWER(hospitaisExames."DE_ORIGEM") LIKE '%hosp%'   THEN 'Hospital'
	WHEN LOWER(hospitaisExames."DE_ORIGEM") LIKE '%lab%'   THEN 'Laboratório'
	WHEN LOWER(hospitaisExames."DE_ORIGEM") LIKE '%atend%'  THEN 'Hospital'
	WHEN LOWER(hospitaisExames."DE_ORIGEM") LIKE '%intern%' OR LOWER(hospitaisExames."DE_ORIGEM") LIKE '%pronto%'   THEN 'Atendimento'
	ELSE 'Outros'
END) as OrigemCol,
(CASE
		WHEN LOWER(hospitaisExames."DE_EXAME") LIKE '%hemogr%'   THEN 'Hemograma'
		WHEN LOWER(hospitaisExames."DE_EXAME") LIKE '%colest%'   THEN 'Colesterol'
		WHEN 
			LOWER(hospitaisExames."DE_EXAME") LIKE '%covid%' 
			OR LOWER(hospitaisExames."DE_EXAME") LIKE '%pcr%' 
			OR LOWER(hospitaisExames."DE_EXAME") LIKE '%igm%'
			OR LOWER(hospitaisExames."DE_EXAME") LIKE '%igg%'THEN 'Covid'
		ELSE 'Outros'
	END) as ExamesCol,
	hospitaisExames."DE_HOSPITAL" as HospitaisCol
	FROM ((select "DE_EXAME", "DE_ORIGEM", 'HSL' as "DE_HOSPITAL"
			from exames
			UNION ALL
			select "DE_EXAME", "DE_ORIGEM", 'BPSP' as "DE_HOSPITAL"
			from examesbpsp)

			UNION ALL

			(select "DE_EXAME", "DE_ORIGEM", 'EINSTEIN' as "DE_HOSPITAL"
			from exameseinstein
			UNION ALL
			select "DE_EXAME", "DE_ORIGEM" , 'HC' as "DE_HOSPITAL"
			from exameshc)
		UNION ALL

		select "DE_EXAME", "DE_ORIGEM", 'FL' as "DE_HOSPITAL"
		from examesfl) as hospitaisExames

		

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
(CASE
	WHEN LOWER(hospitaisExames."DE_ORIGEM") LIKE '%hosp%'   THEN 'Hospital'
	WHEN LOWER(hospitaisExames."DE_ORIGEM") LIKE '%lab%'   THEN 'Laboratório'
	WHEN LOWER(hospitaisExames."DE_ORIGEM") LIKE '%atend%'  THEN 'Hospital'
	WHEN LOWER(hospitaisExames."DE_ORIGEM") LIKE '%intern%' OR LOWER(hospitaisExames."DE_ORIGEM") LIKE '%pronto%'   THEN 'Atendimento'
	ELSE 'Outros'
END) as OrigemCol,
(CASE
		WHEN LOWER(hospitaisExames."DE_EXAME") LIKE '%hemogr%'   THEN 'Hemograma'
		WHEN LOWER(hospitaisExames."DE_EXAME") LIKE '%colest%'   THEN 'Colesterol'
		WHEN 
			LOWER(hospitaisExames."DE_EXAME") LIKE '%covid%' 
			OR LOWER(hospitaisExames."DE_EXAME") LIKE '%pcr%' 
			OR LOWER(hospitaisExames."DE_EXAME") LIKE '%igm%'
			OR LOWER(hospitaisExames."DE_EXAME") LIKE '%igg%'THEN 'Covid'
		ELSE 'Outros'
	END) as ExamesCol,
	hospitaisExames."DE_HOSPITAL" as HospitaisCol
	FROM ((select "DE_EXAME", "DE_ORIGEM", 'HSL' as "DE_HOSPITAL"
			from exames
			UNION ALL
			select "DE_EXAME", "DE_ORIGEM", 'BPSP' as "DE_HOSPITAL"
			from examesbpsp)

			UNION ALL

			(select "DE_EXAME", "DE_ORIGEM", 'EINSTEIN' as "DE_HOSPITAL"
			from exameseinstein
			UNION ALL
			select "DE_EXAME", "DE_ORIGEM" , 'HC' as "DE_HOSPITAL"
			from exameshc)
		UNION ALL

		select "DE_EXAME", "DE_ORIGEM", 'FL' as "DE_HOSPITAL"
		from examesfl) as hospitaisExames)

SELECT 
	DIMENSOES.HospitaisCol,
	DIMENSOES.OrigemCol,
	DIMENSOES.ExamesCol,	
	Count(*) Contagem
	FROM DIMENSOES
	GROUP BY DIMENSOES.HospitaisCol,DIMENSOES.OrigemCol, DIMENSOES.ExamesCol
	ORDER BY DIMENSOES.HospitaisCol,DIMENSOES.OrigemCol, DIMENSOES.ExamesCol;






