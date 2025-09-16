{{ config(materialized='view') }}

select *
from {{ ref('tx_couverture') }}