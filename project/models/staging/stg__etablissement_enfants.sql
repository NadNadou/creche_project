select
    nom,
    type,
    adresse,
    code_postal,
    commune,
    code_insee,
    tel,
    gestion,
    gestionnaire,
    capacite,
    nb_accueil_fam,
    age_mini_mois,
    age_maxi_annee,
    handicap,
    geo_shape,
    geo_point_2d
from {{ ref('etablissement_enfants') }}