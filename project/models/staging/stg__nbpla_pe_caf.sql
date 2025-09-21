SELECT
    date_reference,
    num_commune,
    nom_commune,
    numero_EPCI,
    nom_EPCI,
    numero_departement,
    nom_departement,
    places_EAJE_PSU,
    places_hors_EAJE_PSU,
    places_EAJE_ensemble,
    places_prescolarisation,
    places_assistante_maternelle,
    places_salariee_domicile,
    places_accueil_individuel_ensemble,
    places_offertes_ensemble
FROM {{ref('nbpla_pe_caf')}}