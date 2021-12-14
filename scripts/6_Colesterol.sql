WITH M AS (SELECT "ID_PACIENTE", "DT_COLETA", "DE_ANALITO", Avg(REPLACE("DE_RESULTADO", ',','.')::DECIMAL)::DECIMAL(10,2) AS "AVG", "ID_ATENDIMENTO" from exames
WHERE ("DE_EXAME" LIKE '%Colesterol%')
AND "DE_RESULTADO" ~ '^[0-9\.\,]+$'
GROUP BY "ID_PACIENTE", "ID_ATENDIMENTO", "DT_COLETA", "DE_ANALITO", "DE_RESULTADO")

SELECT M."ID_PACIENTE", "DT_COLETA",
MAX((CASE  WHEN "DE_ANALITO"='HDL-Colesterol' OR "DE_ANALITO"='Hdl-Colesterol' THEN "AVG" ELSE NULL END)) AS "HDL",
MAX((CASE  WHEN "DE_ANALITO"='VLDL-Colesterol' OR "DE_ANALITO"='V-Colesterol' THEN "AVG" ELSE NULL END)) AS "VLDL",
MAX((CASE  WHEN "DE_ANALITO"='LDL Colesterol' THEN "AVG" ELSE NULL END)) AS "LDL",
MAX((CASE  WHEN "DE_ANALITO"='Colesterol não-HDL, soro' THEN "AVG" ELSE NULL END)) AS "Não HDL",
MAX((CASE  WHEN "DE_ANALITO"='Colesterol total' THEN "AVG" ELSE NULL END)) AS "TOTAL",
desfechos."DE_DESFECHO"
FROM M 
INNER JOIN desfechos ON desfechos."ID_ATENDIMENTO" = M."ID_ATENDIMENTO"
GROUP BY M."ID_PACIENTE", M."ID_ATENDIMENTO", "DT_COLETA", desfechos."DE_DESFECHO";