select
    code_region,
    libelle_region,
    Y2015,
    Y2016,
    Y2017,
    Y2018,
    Y2019,
    Y2020,
    Y2021,
    Y2022,
    Y2023
from {{ref('etablissements_creches_reg')}}