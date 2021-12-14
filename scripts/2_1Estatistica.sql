-- EXECICIO 2 - 1
-- Sumarização Estatistica 

-- PACIENTES ----------------------------------

-- AA_NASCIMENTO

SELECT COUNT(*),
MIN("AA_NASCIMENTO"),
MAX("AA_NASCIMENTO"), 
AVG("AA_NASCIMENTO") AS mean,
PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY "AA_NASCIMENTO") AS median,
ROUND(STDDEV("AA_NASCIMENTO"), 2) AS std
FROM pacientes;

SELECT DISTINCT "AA_NASCIMENTO"
FROM pacientes
ORDER BY "AA_NASCIMENTO";

SELECT COUNT(*)
FROM pacientes
WHERE "AA_NASCIMENTO" ISNULL;


-- EXAMES ----------------------------------

SELECT COUNT(*),
MIN("DT_COLETA"),
MAX("DT_COLETA")
FROM exames;

-- Desfechos ----------------------------------

SELECT COUNT(*),
MIN("DT_DESFECHO"),
MAX("DT_DESFECHO")
FROM desfechos;

