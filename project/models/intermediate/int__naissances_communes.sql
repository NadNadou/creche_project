SELECT
    geo,
    time_period,
    sum(obs_value) AS value
FROM {{ref('stg__naissance_communes_data')}}
WHERE time_period IN (2017,2018,2019,2022) 
    AND FREQ='A' AND obs_status='A'
    AND LEFT(geo, 2) IN ('75','77','78','91','92','93','94','95')
GROUP BY 1,2
