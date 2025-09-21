WITH naissance AS (
    SELECT
        time_period AS annee,
        LEFT(geo, 2) AS code_departement,
        SUM(value) AS nb_naissances
    FROM {{ ref('int__naissances_communes') }}
    GROUP BY 1, 2
),

places AS (
    SELECT
        annee,
        code_departement,
        departement,
        SUM(nb_places_creches_collectives 
        + nb_etab_gestion_parentale 
        + nb_etab_creches_familiales) AS nb_places
    FROM {{ ref('int__places_drees_departements') }}
    GROUP BY 1, 2, 3
)

SELECT
    p.annee,
    p.code_departement,
    p.departement,
    n.nb_naissances,
    p.nb_places,
    ROUND(p.nb_places * 1.0 / NULLIF(n.nb_naissances, 0), 2) AS ratio_places_par_naissance
FROM places p
INNER JOIN naissance n
       ON p.code_departement = n.code_departement
      AND p.annee = n.annee