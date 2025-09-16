{{ config(materialized='view') }}

select 
   *
from {{ ref('agrements_assistants_mater_dep') }}