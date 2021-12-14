-- Escreva uma consulta que mostre quais analitos podem ser medidos em exames de ’hemograma’, em cada hospital.
select distinct "DE_ORIGEM", "DE_ANALITO"
from exames
WHERE ("DE_EXAME"= 'Hemograma')
order by "DE_ORIGEM",  "DE_ANALITO";

-- Compare os nomes dos analitos entre os diferentes hospitais, e execute um processo de atualização dos nomes, corrigindo e integrando as variantes e grafias ´obvias.
(
	(select distinct "DE_ANALITO"
	from exames
	WHERE ("DE_EXAME"= 'Hemograma')
	UNION ALL
	select distinct "DE_ANALITO"
	from examesbpsp
	WHERE (LOWER("DE_EXAME") Like '%hemograma%')
	order by "DE_ANALITO")

	UNION ALL

	(select distinct "DE_ANALITO"
	from exameseinstein
	WHERE (LOWER("DE_EXAME") Like '%hemograma%')
	UNION ALL
	select distinct "DE_ANALITO"
	from exameshc
	WHERE (LOWER("DE_EXAME") Like '%hemograma%')
	order by "DE_ANALITO")
)
UNION ALL

select distinct "DE_ANALITO"
from examesfl
WHERE (LOWER("DE_EXAME") Like '%hemograma%')
order by "DE_ANALITO";
