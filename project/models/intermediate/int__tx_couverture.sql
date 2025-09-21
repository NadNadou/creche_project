SELECT
    date_reference AS annee,
    numero_commune     AS code_commune,
    nom_commune,
    numero_epci        AS code_epci,
    nom_epci,
    numero_departement AS code_departement,
    nom_departement,
    taux_de_couv_eaje_psu,
    taux_de_couv_hors_eaje_psu,
    taux_de_couv_prescolarisation,
    taux_de_couv_assistante_maternelle,
    taux_de_couv_salariee_a_domicile,
    taux_de_couv_global
FROM {{ ref('stg__tx_couverture') }}
WHERE date_reference IN (2017,2018,2019,2022)
    AND code_departement IN ('75','77','78','91','92','93','94','95')