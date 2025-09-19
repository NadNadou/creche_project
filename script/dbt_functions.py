import pandas as pd

def generate_schema_local(seed_path: str, output_file: str, seed_name: str):
    """
    Génère un fichier texte avec la structure schema.yml pour un seed DBT.
    Tu pourras ensuite copier/coller dans ton vrai schema.yml.
    """
    # Lecture du CSV
    df = pd.read_csv(seed_path)

    # Création du contenu YAML sous forme de string
    lines = []
    lines.append("version: 2\n")
    lines.append("seeds:\n")
    lines.append(f"  - name: {seed_name}\n")
    lines.append("    columns:\n")
    for col in df.columns:
        lines.append(f"      - name: {col}\n")
        lines.append(f"        description: \"Description de {col}\"\n")

    # Sauvegarde dans un fichier local
    with open(output_file, "w", encoding="utf-8") as f:
        f.writelines(lines)

    print(f"✅ Fichier de schema généré : {output_file}")

generate_schema_local(
    seed_path="../project/seeds/nbpla_pe_caf.csv",
    output_file="schema_generated.txt",
    seed_name="nbpla_pe_caf"
)


def detect_bad_lines(path: str, sep=";"):
    """
    Détecte les lignes d'un CSV qui n'ont pas le bon nombre de colonnes.
    Utile pour comprendre les erreurs de pandas lors du parsing.
    """
    bad_lines = []
    with open(path, encoding="utf-8") as f:
        # On lit la première ligne = header
        header = f.readline().strip().split(sep)
        nb_cols = len(header)

        # On scanne chaque ligne suivante
        for i, line in enumerate(f, start=2):  # start=2 car on a déjà lu la ligne 1
            cols = line.strip().split(sep)
            if len(cols) != nb_cols:
                bad_lines.append((i, len(cols), line.strip()))

    # Résultat
    if not bad_lines:
        print("✅ Toutes les lignes ont le bon nombre de colonnes.")
    else:
        print(f"⚠️ {len(bad_lines)} lignes problématiques trouvées :")
        for i, n, line in bad_lines[:10]:  # on affiche les 10 premières max
            print(f"  - Ligne {i} → {n} colonnes au lieu de {nb_cols}")
            print(f"    Contenu : {line[:120]}...")
    return bad_lines


# detect_bad_lines("../project/seeds/nbpla_pe_caf.csv", sep=",")

def clean_csv_interactive(path_in: str, path_out: str, sep=","):
    """
    Détecte les lignes avec un mauvais nombre de colonnes
    et propose de les supprimer interactivement.
    Sauvegarde ensuite un nouveau CSV propre.
    """
    with open(path_in, encoding="utf-8") as f:
        # Lire le header
        header = f.readline()
        nb_cols = len(header.strip().split(sep))

        good_lines = [header]  # on garde toujours l'en-tête
        bad_lines = []

        for i, line in enumerate(f, start=2):
            cols = line.strip().split(sep)
            if len(cols) == nb_cols:
                good_lines.append(line)
            else:
                bad_lines.append((i, len(cols), line))

    # Si tout est bon
    if not bad_lines:
        print("✅ Pas de lignes problématiques, rien à nettoyer.")
        return

    print(f"⚠️ {len(bad_lines)} lignes problématiques trouvées.")

    # Proposer suppression ligne par ligne
    for i, n, line in bad_lines:
        print(f"\nLigne {i} → {n} colonnes (au lieu de {nb_cols})")
        print(f"Contenu : {line[:120]}...")  # on affiche seulement le début
        choice = input("👉 Supprimer cette ligne ? (y/n): ").lower().strip()
        if choice == "n":
            good_lines.append(line)  # garder quand même

    # Sauvegarde du nouveau CSV
    with open(path_out, "w", encoding="utf-8") as f:
        f.writelines(good_lines)

    print(f"\n✅ Nouveau fichier sauvegardé : {path_out}")

# clean_csv_interactive("../project/seeds/nbpla_pe_caf.csv", "../data/clean/Tab23_clean.csv")

def clean_csv(path_in: str, path_out: str, sep=","):
    """
    Supprime toutes les lignes dont le nombre de colonnes est incorrect.
    Sauvegarde un nouveau CSV propre.
    """
    with open(path_in, encoding="utf-8") as f:
        # Lire le header
        header = f.readline()
        nb_cols = len(header.strip().split(sep))

        good_lines = [header]  # toujours garder l'en-tête
        bad_lines = []

        for i, line in enumerate(f, start=2):
            cols = line.strip().split(sep)
            if len(cols) == nb_cols:
                good_lines.append(line)
            else:
                bad_lines.append((i, len(cols), line.strip()))

    # Feedback utilisateur
    if bad_lines:
        print(f"⚠️ {len(bad_lines)} lignes supprimées (par ex. ligne {bad_lines[0][0]})")
    else:
        print("✅ Pas de lignes problématiques.")

    # Sauvegarde du fichier propre
    with open(path_out, "w", encoding="utf-8") as f:
        f.writelines(good_lines)

    print(f"✅ Nouveau fichier sauvegardé : {path_out}")

# clean_csv("../project/seeds/nbpla_pe_caf.csv", "../data/clean/nbpla_pe_caf.csv")


