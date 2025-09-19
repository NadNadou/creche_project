import pandas as pd

def transformer_fichier(path_in: str, path_out: str):
    """
    Lis un CSV wide (colonnes années), le transforme en long format,
    renomme les colonnes, remplace les valeurs vides par 0,
    et l'exporte propre pour DBT seeds.
    """
    # Lecture du fichier brut
    df = pd.read_csv(path_in, sep=";")

    # Transformation wide → long
    df = df.melt(
        id_vars=["Code région", "Code département", "Département"],
        var_name="annee",
        value_name="valeur"
    )

    # Nettoyage des valeurs (supprimer espaces insécables, espaces classiques)
    df["valeur"] = (
        df["valeur"]
        .astype(str)                # convertir en string
        .str.replace("\u202f", "")  # enlever espaces insécables
        .str.replace(" ", "")       # enlever espaces normaux
        .replace("nan", "0")        # remplacer 'nan' string par 0
        .astype(float)              # convertir en float
        .fillna(0)                  # valeurs manquantes -> 0
        .astype(int)                # si tu veux vraiment des entiers
    )

    # Renommage des colonnes en snake_case
    df = df.rename(columns={
        "Code région": "code_region",
        "Code département": "code_departement",
        "Département": "departement",
        "annee": "annee",
        "valeur": "valeur"
    })

    # Export CSV pour DBT
    df.to_csv(path_out, index=False)

    print(f"✅ Fichier transformé et sauvegardé : {path_out}")

    
transformer_fichier("../data/raw/Tab23.csv", "../project/seeds/tab23_dees.csv")
transformer_fichier("../data/raw/Tab24.csv", "../project/seeds/tab24_dees.csv")
transformer_fichier("../data/raw/Tab27.csv", "../project/seeds/tab27_dees.csv")
transformer_fichier("../data/raw/Tab28.csv", "../project/seeds/tab28_dees.csv")
transformer_fichier("../data/raw/Tab32.csv", "../project/seeds/tab32_dees.csv")
transformer_fichier("../data/raw/Tab33.csv", "../project/seeds/tab33_dees.csv")


