SELECT
    EC_MEASURE AS ec_measure,
    FREQ AS freq,
    GEO AS geo,
    GEO_OBJECT AS geo_object,
    OBS_STATUS AS obs_status,
    TIME_PERIOD AS time_period,
    OBS_VALUE AS obs_value
FROM {{ref('naissance_communes_data')}}