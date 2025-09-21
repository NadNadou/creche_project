SELECT
    date_reference,
    num_commune,
    nom_commune,
    sum(places_offertes_ensemble) as value
FROM {{ref('stg__nbpla_pe_caf')}}
WHERE
    date_reference IN (2017,2018,2019,2022)
    AND LEFT(num_commune, 2) IN ('75','77','78','91','92','93','94','95') 
GROUP BY 1,2,3