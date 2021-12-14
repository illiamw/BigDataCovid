-- Escreva uma consulta que mostre quais analitos podem ser medidos em exames de ’hemograma’, em cada hospital.
select distinct "DE_ORIGEM", "DE_ANALITO"
from exames
WHERE ("DE_EXAME"= 'Hemograma')
order by "DE_ORIGEM",  "DE_ANALITO";

-- Compare os nomes dos analitos entre os diferentes hospitais, e execute um processo de atualização dos nomes, corrigindo e integrando as variantes e grafias ´obvias.
(
	(select distinct "DE_ANALITO", 'HSL'
	from exames
	WHERE ("DE_EXAME"= 'Hemograma')
	UNION ALL
	select distinct "DE_ANALITO", 'BPSP'
	from examesbpsp
	WHERE (LOWER("DE_EXAME") Like '%hemograma%')
	order by "DE_ANALITO")

	UNION ALL

	(select distinct "DE_ANALITO", 'EINSTEIN'
	from exameseinstein
	WHERE (LOWER("DE_EXAME") Like '%hemograma%')
	UNION ALL
	select distinct "DE_ANALITO" , 'HC'
	from exameshc
	WHERE (LOWER("DE_EXAME") Like '%hemograma%')
	order by "DE_ANALITO")
)
UNION ALL

select distinct "DE_ANALITO", 'FL'
from examesfl
WHERE (LOWER("DE_EXAME") Like '%hemograma%')
order by "DE_ANALITO";

-- Updates com integração entre analitos do tipo Hemograma
UPDATE  examesbpsp
	SET "DE_ANALITO" = subquery.replacevalor
	FROM (
		SELECT id,
			"DE_ANALITO" AS valor,
			(CASE
				WHEN "DE_ANALITO"  = 'Basofilos'  THEN 'Basófilos'
				WHEN "DE_ANALITO"  = 'Basofilos (%)'  THEN 'Basófilos (%)'
				WHEN "DE_ANALITO"  = 'Concentracao de Hemoglobina Corpuscular'  THEN 'Concentração de Hemoglobina Corpuscular'
				WHEN "DE_ANALITO"  = 'Eosinofilos'  THEN 'Eosinófilos'
				WHEN "DE_ANALITO"  = 'Eosinofilos (%)'  THEN 'Eosinófilos (%)'
				WHEN "DE_ANALITO"  = 'Eritrocitos'  THEN 'Eritrócitos'
				WHEN "DE_ANALITO"  = 'Fracao Imatura de Plaquetas'  THEN 'Fração Imatura de Plaquetas'
				WHEN "DE_ANALITO"  = 'Hematocrito'  THEN 'Hematócrito'
				WHEN "DE_ANALITO"  = 'Hemoglobina Corpuscular Media'  THEN 'Hemoglobina Corpuscular Média'
				WHEN "DE_ANALITO"  = 'Indice de Green & King'  THEN 'Índice de Green & King'
				WHEN "DE_ANALITO"  = 'Leucocitos'  THEN 'Leucócitos'
				WHEN "DE_ANALITO"  = 'Linfocitos'  THEN 'Linfócitos'
				WHEN "DE_ANALITO"  = 'Linfocitos (%)'  THEN 'Linfócitos (%)'
				WHEN "DE_ANALITO"  = 'Metamielocitos'  THEN 'Metamielócitos'
				WHEN "DE_ANALITO"  = 'Metamielocitos (%)'  THEN 'Metamielócitos (%)'
				WHEN "DE_ANALITO"  = 'Mielocitos'  THEN 'Mielócitos'
				WHEN "DE_ANALITO"  = 'Mielocitos (%)'  THEN 'Mielócitos (%)'
				WHEN "DE_ANALITO"  = 'Monocitos'  THEN 'Monócitos'
				WHEN "DE_ANALITO"  = 'Monocitos (%)'  THEN 'Monócitos (%)'
				WHEN "DE_ANALITO"  = 'Morfologia, Serie Branca'  THEN 'Morfologia, Série Branca'
				WHEN "DE_ANALITO"  = 'Morfologia, Serie Vermelha'  THEN 'Morfologia, Série Vermelha'
				WHEN "DE_ANALITO"  = 'Neutrofilos'  THEN 'Neutrófilos'
				WHEN "DE_ANALITO"  = 'Neutrofilos (%)'  THEN 'Neutrófilos (%)'
				WHEN "DE_ANALITO"  = 'Plasmocitos'  THEN 'Plasmócitos'
				WHEN "DE_ANALITO"  = 'Plasmocitos (%)'  THEN 'Plasmócitos (%)'
				WHEN "DE_ANALITO"  = 'Promielocitos'  THEN 'Promielócitos'
				WHEN "DE_ANALITO"  = 'Promielocitos (%)'  THEN 'Promielócitos (%)'
				WHEN "DE_ANALITO"  = 'Tricoleucocitos'  THEN 'Tricoleucócitos'
				WHEN "DE_ANALITO"  = 'Volume plaquetário médio'  THEN 'Volume plaquetario medio'
			END) as replacevalor
			FROM examesbpsp
			WHERE (LOWER("DE_EXAME") Like '%hemograma%')

	)AS subquery
	WHERE examesbpsp.id = subquery.id;

UPDATE  exameseinstein
	SET "DE_ANALITO" = subquery.replacevalor
	FROM (
		SELECT id,
			"DE_ANALITO" AS valor,
			(CASE
				WHEN "DE_ANALITO"  = 'Basófilos #'  THEN 'Basófilos (%)'
			 	WHEN "DE_ANALITO"  = 'Bastonestes'  THEN 'Bastonetes'
			 	WHEN "DE_ANALITO"  = 'Bastonetes #'  THEN 'Bastonetes (%)'
			 	WHEN "DE_ANALITO"  = 'Eosinófilos  #'  THEN 'Eosinófilos (%)'
			 	WHEN "DE_ANALITO"  = 'Leucócitos #'  THEN 'Leucócitos (%)'
			 	WHEN "DE_ANALITO"  = 'Linfócitos #'  THEN 'Linfócitos (%)'
			 	WHEN "DE_ANALITO"  = 'Metamielócitos #'  THEN 'Metamielócitos (%)'
			 	WHEN "DE_ANALITO"  = 'Mieloblastos #'  THEN 'Mieloblastos (%)'
			 	WHEN "DE_ANALITO"  = 'Mielócitos #'  THEN 'Mielócitos (%)'
			 	WHEN "DE_ANALITO"  = 'Monócitos #'  THEN 'Monócitos (%)'
			 	WHEN "DE_ANALITO"  = 'Neutrófilos  #'  THEN 'Neutrófilos (%)'
			 	WHEN "DE_ANALITO"  = 'Promielócitos #'  THEN 'Promielócitos (%)'
			 	WHEN "DE_ANALITO"  = 'Segmentados #'  THEN 'Segmentados (%)'
			END) as replacevalor
			FROM exameseinstein
			WHERE (LOWER("DE_EXAME") Like '%hemograma%')

	)AS subquery
	WHERE exameseinstein.id = subquery.id;
	
UPDATE  exames
	SET "DE_ANALITO" = subquery.replacevalor
	FROM (
		SELECT id,
			"DE_ANALITO" AS valor,
			(CASE
			 	WHEN "DE_ANALITO"  = 'Morfologia, SB'  THEN 'Morfologia, Série Branca'
			 	WHEN "DE_ANALITO"  = 'Morfologia, SVE'  THEN 'Morfologia, Série Vermelha'
			END) as replacevalor
			FROM exames
			WHERE (LOWER("DE_EXAME") Like '%hemograma%')

	)AS subquery
	WHERE exames.id = subquery.id;

-- verificando 

(
	(select distinct "DE_ANALITO"
	from exames
	WHERE ("DE_EXAME"= 'Hemograma')
	UNION
	select distinct "DE_ANALITO"
	from examesbpsp
	WHERE (LOWER("DE_EXAME") Like '%hemograma%')
	order by "DE_ANALITO")

	UNION

	(select distinct "DE_ANALITO"
	from exameseinstein
	WHERE (LOWER("DE_EXAME") Like '%hemograma%')
	UNION
	select distinct "DE_ANALITO" 
	from exameshc
	WHERE (LOWER("DE_EXAME") Like '%hemograma%')
	order by "DE_ANALITO")
)
UNION 

select distinct "DE_ANALITO"
from examesfl
WHERE (LOWER("DE_EXAME") Like '%hemograma%')
order by "DE_ANALITO";