# Problèmatique : de nos jours, obtenir une place en crèche relève souvent du miracle.
# Mais existe-t-il des endroits en France où il est réellement plus facile d’en obtenir une ?

## 🎯 Contexte
Trouver une place en crèche relève souvent du miracle.  
Ce projet explore les inégalités territoriales en croisant données publiques (INSEE, CAF, DREES).

## 🛠️ Stack
- Python (ingestion, nettoyage)
- BigQuery
- dbt
- Airflow (orchestration)
- Looker Studio / Streamlit (visualisation)

## 📂 Arborescence
- `/data` : jeux de données (raw + processed)
- `/scripts` : ingestion et nettoyage
- `/dags` : DAGs Airflow
- `/dbt` : modèles de transformation
- `/docs` : schémas et documentation

## 🚀 Objectif
Créer une cartographie interactive identifiant les zones où il est plus facile (ou non) d’obtenir une place en crèche.
