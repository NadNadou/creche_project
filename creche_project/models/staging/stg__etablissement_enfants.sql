{{ config(materialized='view') }}

select *
from {{ ref('etablissement_enfants') }}