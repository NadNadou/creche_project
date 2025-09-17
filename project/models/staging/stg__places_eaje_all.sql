select
        code_region,
        libelle_region,
        creches_collectives,
        creches_familiales,
        multi_accueil_collectif_familial,
        jardins_enfants,
        etab_et_services_gestion_parentale
from {{ref('places_eaje_all')}}