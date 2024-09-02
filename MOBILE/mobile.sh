#!/bin/bash

# Elenco degli URL dei repository da scaricare
repo_urls=(
   "https://github.com/skylot/jadx/releases/download/v1.5.0/jadx-1.5.0.zip",
   "https://github.com/pxb1988/dex2jar/releases/download/v2.4/dex-tools-v2.4.zip"
)

# Cartella di destinazione per il download dei repository
destination_folder="download"

# Creazione della cartella di destinazione se non esiste
mkdir -p "$destination_folder"

# Ciclo attraverso gli URL dei repository e li scarica
for url in "${repo_urls[@]}"; do
    repo_name=$(basename "$url" .git)
    repo_folder="$destination_folder/$repo_name"
    
    # Verifica se il repository è già stato clonato
    if [ -d "$repo_folder" ]; then
        echo "Il repository $repo_name esiste già. Aggiornamento..."
        cd "$repo_folder"
        git pull
        cd ..
    else
        echo "Clonazione del repository $repo_name..."
        git clone "$url" "$repo_folder"
    fi
done

echo "Download completato!"
