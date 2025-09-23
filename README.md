## Contexte

En France, l’accès aux places en crèche est un enjeu majeur pour de nombreux parents.
L’objectif de ce projet est d’explorer les données publiques sur les crèches afin de :
  - Centraliser les informations brutes disponibles.
  - Mettre en place un pipeline de collecte et de traitement.
  - Fournir des visualisations claires permettant d’analyser l’évolution et la répartition des crèches.

En France, plusieurs types de structures accueillent les jeunes enfants :

  - Crèches collectives : accueil en groupe, dans des locaux adaptés, avec un personnel qualifié.
  - Crèches familiales : accueil au domicile d’assistantes maternelles agréées, encadrées par une crèche.
  - Crèches parentales : gérées par une association de parents qui participent à la garde, avec un petit effectif (≤ 20 enfants).
  - Jardins d’enfants : accueillent des enfants de 2 à 6 ans, non scolarisés ou scolarisés à temps partiel.
  - Multi-accueils : combinent différents types d’accueil (régulier ou occasionnel) pour les moins de 4 ans.
  - Micro-crèches : petites structures collectives pour les moins de 6 ans, limitées à 10 enfants simultanément.

Ce projet a été motivé par un événement récent : la fermeture soudaine de plusieurs crèches en France, qui a laissé de nombreux parents sans solution de garde à une semaine de la rentrée. Cet épisode m’a poussé à explorer les données publiques afin de mieux comprendre l’offre d’accueil en crèches, ses disparités territoriales et son évolution au fil du temps.

## Périmètre de l'anlyse

  - Zone étudiée : île-de-France
  - Maille géographique : communale  
  - Focus : département présentant le plus haut ratio PLACES DISPONIBLES / NAISSANCES  
  - Période couverte : 2017 - 2022  

## Sources de données

Le projet s’appuie sur plusieurs jeux de données publiques provenant d’organismes officiels : 

- **DREES** (data.drees.solidarites-sante.gouv.fr) -  (Direction de la Recherche, des Études, de l’Évaluation et des Statistiques) : données sur les établissements d’accueil du jeune enfant
  - Tableau 23 : Nombre d’établissements de crèches collectives (2015–2023, par département)  
  - Tableau 24 : Nombre d’établissements de crèches familiales (2010–2023, par département)  
  - Tableau 27 : Nombre d’établissements et services à gestion parentale (2015–2023, par département)  
  - Tableau 28 : Nombre de places en crèches collectives (2015–2023, par département)  
  - Tableau 29 : Nombre de places en crèches familiales (2010–2023, par département)  
  - Tableau 32 : Nombre de places en établissements/services à gestion parentale (2015–2023, par département)  
  - Tableau 33 : Nombre d’agréments d’assistants maternels en cours de validité (2010–2023, par département)  

- **INSEE** (insee.fr) - (Institut National de la Statistique et des Études Économiques) : statistiques annuelles des naissances
  - DS_ETAT_CIVIL_NAIS_COMMUNES_data : Statistiques annuelles des naissances en France  

- **CAFdata** (data.caf.fr) - (Caisses d’Allocations Familiales) : indicateurs sur l’offre d’accueil et le taux de couverture
  - tx_couverture : Taux de couverture d’accueil du jeune enfant  
  - nbpla_pe_caf : Offre d’accueil formel pour les enfants de moins de 3 ans  

- **Data.gouv.fr**  Plateforme française d’Open Data, utilisée pour les référentiels géographiques (communes, départements).  
  - communes.json : Ensemble des communes de France  
  - departements.json : Ensemble des départements de France  


## Pipeline / Architecture

  - Extraction : récupération des fichiers bruts depuis la plateforme Open Data. Les fichiers de la DREES, initialement au format XLSX, ont été convertis en CSV à l’aide d’un script Python afin d’harmoniser les formats et faciliter leur intégration
  - Transformation : intégration et préparation des données dans DuckDB via dbt, avec nettoyage, uniformisation des formats et gestion des valeurs manquantes
  - Chargement : stockage dans un format structuré (CSV exploitable).
  - Visualisation : production de cartes intéractives par année avec Folium pour visualiser la répartiton géographique des crèches. 
## Stack

Stack principale :
  - dbt-core : transfromation de la donnée
  - dbt-duckdb : exécution locale avec DuckDB
  - DuckDB : base de données analytique
  - Python (scripts annexes) :
    - pandas + openpyxl → conversion des fichiers XLSX de la DREES en CSV
    - requests → téléchargement automatique depuis Open Data
    - folium → visualisation géographique (cartes interactives des crèches par département/commune)

## Limites & améliorations possibles

  - Possibilité d'enrichir l'analyse avec plus de données
  - Le pipeline actuel est exécuté en local -> deploiement possible via Airflow pour extraire les données via API et les mettre à jour chaque année
  - Ajout d'une base de données (BigQuery par exemple) pour des requêtes plus avancées
  - Développement d'un dashboard intéractif (Streamlit, Power BI) pour rendre l'analyse accessible

## Exécution du projet

    git clone https://github.com/NadNadou/creche_project.git
    cd creche_project

Créer un environnenet virtuel et installer les dépendances

    pip install -r requirements.txt

## Auteur

Projet réalisé par Nadia A. - Data Engineer passionnée par la donnée et la programmation informatique


