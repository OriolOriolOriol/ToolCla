#!/bin/bash

# Elenco degli URL dei repository da scaricare
repo_urls=(
    "https://github.com/dirkjanm/krbrelayx.git"
    "https://github.com/fortra/impacket.git"
    "https://github.com/sploutchy/Certipy.git"
    "https://github.com/dirkjanm/BloodHound.py.git"
    "https://github.com/dirkjanm/mitm6.git"
    "https://github.com/topotam/PetitPotam.git"
    "https://github.com/carlospolop/PEASS-ng.git" 
    "https://github.com/CravateRouge/bloodyAD.git"
    "https://github.com/dirkjanm/PKINITtools.git"
    "https://github.com/AlmondOffSec/PassTheCert/"  
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
