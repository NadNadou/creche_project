{{ config(materialized='view') }}

select *
from {{ ref('places_etab_agrees_cat_dep') }}