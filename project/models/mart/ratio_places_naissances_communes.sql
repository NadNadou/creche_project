WITH naissance AS (
    SELECT
        time_period AS annee,
        geo AS code_commune,
        SUM(value) AS nb_naissances
    FROM {{ ref('int__naissances_communes') }}
    GROUP BY 1, 2
),

places AS (
    SELECT
        date_reference AS annee,
        num_commune AS code_commune,
        nom_commune,
        SUM(value) AS nb_places
    FROM {{ ref('int__places_caf_communes') }}
    GROUP BY 1, 2,3
)

SELECT
    p.annee,
    p.code_commune,
    p.nom_commune,
    n.nb_naissances,
    p.nb_places,
    ROUND(p.nb_places * 1.0 / NULLIF(n.nb_naissances, 0), 2) AS ratio_places_par_naissance
FROM places p
INNER JOIN naissance n
    ON p.code_commune = n.code_commune
    AND p.annee = n.annee
