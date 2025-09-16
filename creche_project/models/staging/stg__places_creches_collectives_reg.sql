{{ config(materialized='view') }}

select *
from {{ ref('places_creches_collectives_reg') }}