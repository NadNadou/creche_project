-- (a) Offre d’accueil formelle

-- Union de :

-- capacités EAJE (crèches, multi-accueils…) → depuis stg__etablissement_enfants

-- assistantes maternelles agréées → depuis stg__agrements_assistants_mater_dep

-- Agrégation par commune / département / région

-- Indicateur : nombre total de places d’accueil

WITH

CAPACITE_EAJE AS (
    SELECT
        *
        -- code_insee,
        -- type,
        -- COUNT(*) AS nb_etablissements
    FROM {{ ref('stg__etablissement_enfants') }}
    -- WHERE type IS NOT NULL and code_insee IS NOT NULL
    -- GROUP BY code_insee, type

),

ASSMAT AS (
    SELECT
         code_departement
        , departement
        , (COALESCE("2020", 0) + COALESCE("2021", 0) + COALESCE("2022", 0) + COALESCE("2023", 0) ) / 4.0 AS value
        , 'AssMat' AS type
    FROM {{ref('stg__agrements_assistants_mater_dep')}}
    WHERE code_region=11
)

-- OFFRE_GLOBAL AS (
--     SELECT 
--         *
--     FROM CAPACITE_EAJE

--     UNION ALL

--     SELECT
--         *
--     FROM ASSMAT
-- )

SELECT *
FROM CAPACITE_EAJE
