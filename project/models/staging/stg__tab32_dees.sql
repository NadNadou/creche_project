SELECT
    code_region,
    code_departement,
    departement,
    annee,
    valeur
FROM {{ref('tab32_dees')}}