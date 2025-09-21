WITH tab23 AS (
    SELECT
        annee,
        code_departement,
        departement,
        SUM(valeur) AS nb_etab_creches_collectives
    FROM {{ ref('stg__tab23_dees') }}
    WHERE code_region=11
        AND annee IN (2017,2018,2019,2022)
    GROUP BY 1, 2, 3
),

tab24 AS (
    SELECT
        annee,
        code_departement,
        departement,
        SUM(valeur) AS nb_etab_creches_familiales
    FROM {{ ref('stg__tab24_dees') }}
    WHERE code_region=11
        AND annee IN (2017,2018,2019,2022)
    GROUP BY 1, 2, 3
),

tab27 AS (
    SELECT
        annee,
        code_departement,
        departement,
        SUM(valeur) AS nb_etab_gestion_parentale
    FROM {{ ref('stg__tab27_dees') }}
    WHERE code_region=11
        AND annee IN (2017,2018,2019,2022)
    GROUP BY 1, 2, 3
),

tab28 AS (
    SELECT
        annee,
        code_departement,
        departement,
        SUM(valeur) AS nb_places_creches_collectives
    FROM {{ ref('stg__tab28_dees') }}
    WHERE code_region=11
        AND annee IN (2017,2018,2019,2022)
    GROUP BY 1, 2, 3
),

tab32 AS (
    SELECT
        annee,
        code_departement,
        departement,
        SUM(valeur) AS nb_agrements_assistants_maternels
    FROM {{ ref('stg__tab32_dees') }}
    WHERE code_region=11
        AND annee IN (2017,2018,2019,2022)
    GROUP BY 1, 2, 3
),

tab33 AS (
    SELECT
        annee,
        code_departement,
        departement,
        SUM(valeur) AS nb_places_gestion_parentale
    FROM {{ ref('stg__tab33_dees') }}
    WHERE code_region=11
        AND annee IN (2017,2018,2019,2022)
    GROUP BY 1, 2, 3
)

SELECT
    COALESCE(t23.annee, t24.annee, t27.annee, t28.annee, t32.annee, t33.annee) AS annee,
    COALESCE(t23.code_departement, t24.code_departement, t27.code_departement, t28.code_departement, t32.code_departement, t33.code_departement) AS code_departement,
    COALESCE(t23.departement, t24.departement, t27.departement, t28.departement, t32.departement, t33.departement) AS departement,
    t23.nb_etab_creches_collectives,
    t24.nb_etab_creches_familiales,
    t27.nb_etab_gestion_parentale,
    t28.nb_places_creches_collectives,
    t32.nb_agrements_assistants_maternels,
    t33.nb_places_gestion_parentale
FROM tab23 t23
INNER JOIN tab24 t24 USING (annee, code_departement,departement)
INNER JOIN tab27 t27 USING (annee, code_departement, departement)
INNER JOIN tab28 t28 USING (annee, code_departement, departement)
INNER JOIN tab32 t32 USING (annee, code_departement, departement)
INNER JOIN tab33 t33 USING (annee, code_departement, departement)
