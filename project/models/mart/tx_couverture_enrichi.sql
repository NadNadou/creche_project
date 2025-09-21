WITH naissance AS (
    SELECT
        time_period AS annee,
        geo AS code_commune,
        SUM(value) AS nb_naissances
    FROM {{ ref('int__naissances_communes') }}
    WHERE LEFT(code_commune,2) IN ('75','77','78','91','92','93','94','95')
    GROUP BY 1, 2
)

SELECT
    t.annee,
    t.code_commune,
    t.nom_commune,
    t.code_epci,
    t.nom_epci,
    t.code_departement,
    t.nom_departement,
    n.nb_naissances,
    t.taux_de_couv_eaje_psu,
    t.taux_de_couv_hors_eaje_psu,
    t.taux_de_couv_prescolarisation,
    t.taux_de_couv_assistante_maternelle,
    t.taux_de_couv_salariee_a_domicile,
    t.taux_de_couv_global,
    ROUND(t.taux_de_couv_global * n.nb_naissances / 100.0, 0) AS nb_enfants_couverts_estime
FROM {{ ref('int__tx_couverture') }} t
LEFT JOIN naissance n
       ON t.annee = n.annee
      AND t.code_commune = n.code_commune
