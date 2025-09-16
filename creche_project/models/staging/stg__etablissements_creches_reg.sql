{{ config(materialized='view') }}

select *
from {{ ref('etablissements_creches_reg') }}