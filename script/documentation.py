import os

# Chemin vers le dossier dbt/seeds (à adapter si besoin)
seeds_path = "./project/seeds"

print(f"📁 Fichiers dans {seeds_path} :\n")

# Parcours récursif des fichiers
for root, dirs, files in os.walk(seeds_path):
    for file in files:
        if file.endswith(".csv"):
            full_path = os.path.join(root, file)
            relative_path = os.path.relpath(full_path, start=os.getcwd())
            size_kb = os.path.getsize(full_path) / 1024
            print(f"- {relative_path} ({size_kb:.1f} KB)")