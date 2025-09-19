-- Vérifie qu'aucune colonne n'est NULL (signe d'un décalage dans le CSV)
select *
from {{ ref('nbpla_pe_caf') }}
where col1 is null
    or col2 is null
    or col3 is null
    or col4 is null
    or col5 is null
    or col6 is null
    or col7 is null
    or col8 is null
    or col9 is null
    or col10 is null
    or col11 is null
    or col12 is null
    or col13 is null
    or col14 is null
    or col15 is null