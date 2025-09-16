import pandas as pd
import os
import unicodedata
import csv

# --- Normalisation des noms de colonnes ---
def normalize_column(colname):
    """Supprime les accents et espaces, met en snake_case"""
    colname = ''.join(
        c for c in unicodedata.normalize('NFD', colname)
        if unicodedata.category(c) != 'Mn'
    )
    return colname.strip().lower().replace(" ", "_")

# --- Exploration rapide ---
def file_exploration(path, sheet_name=None):
    try:
        if path.endswith(".xlsx"):
            df = pd.read_excel(path, sheet_name=sheet_name)
        else:
            df = pd.read_csv(path, sep=",", encoding="utf-8")

        print(f"\nExploration de : {path} | Feuille : {sheet_name}")
        print("Colonnes disponibles :", list(df.columns))
        print("\nTypes de données :\n", df.dtypes)
        print("\nExemple de données :\n", df.head())
    except Exception as e:
        print(f"⚠️ Erreur avec {path}: {e}")

# --- Nettoyage générique ---
def clean_df(df):
    # Supprimer espaces insécables
    df = df.replace("\u202f", "", regex=True)
    # Normaliser les colonnes
    df.columns = [normalize_column(c) for c in df.columns]
    return df

# --- Export des feuilles Excel vers seeds/ ---
def export_sheets_to_seeds(xlsx_path, output_folder="dbt/seeds"):
    """
    Exporte chaque feuille Excel en CSV distinct dans dbt/seeds,
    uniquement si le nom commence par 'stg_'.
    """
    try:
        sheets = pd.ExcelFile(xlsx_path).sheet_names
        print(f"📑 Feuilles trouvées : {sheets}")

        for sheet in sheets:
            df = pd.read_excel(xlsx_path, sheet_name=sheet)
            df = clean_df(df)

            filename = normalize_column(sheet)
            output_path = os.path.join(output_folder, f"{sheet}.csv")
            df.to_csv(
                output_path,
                sep=",",
                index=False,
                encoding="utf-8",
                quoting=csv.QUOTE_NONE,
                escapechar="\\"
            )
            print(f"✅ Exporté : {output_path}")
    except Exception as e:
        print(f"⚠️ Erreur lors de l'export des feuilles : {e}")


# Exemple d’utilisation
export_sheets_to_seeds("data/raw/offre accueil_selection.xlsx", "dbt/seeds")
