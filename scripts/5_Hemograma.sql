select distinct "DE_ANALITO" from exames
WHERE ("DE_EXAME"= 'Hemograma')
GROUP BY "DE_ANALITO";