select
    date_reference,
    numero_commune,
    nom_commune,
    numero_epci,
    nom_epci,
    numero_departement,
    nom_departement,
    taux_de_couv_eaje_psu,
    taux_de_couv_hors_eaje_psu,
    taux_de_couv_prescolarisation,
    taux_de_couv_assistante_maternelle,
    taux_de_couv_salariee_a_domicile,
    taux_de_couv_global
from {{ref('tx_couverture')}}