SELECT
    code_region,
    code_departement,
    departement,
    annee,
    valeur
FROM {{ref('tab28_dees')}}