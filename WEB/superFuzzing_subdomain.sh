#!/bin/bash

# Elenco dei domini da verificare
domains=(
    "www.acmilan.com"
)

# Funzione per stampare testo in verde
print_green() {
    echo -e "\033[0;32m$1\033[0m"
}

# Funzione per stampare testo in giallo
print_yellow() {
    echo -e "\033[0;33m$1\033[0m"
}

# Funzione per stampare testo in bianco
print_white() {
    echo -e "\033[0;37m$1\033[0m"
}

# Loop attraverso ogni dominio
for domain in "${domains[@]}"; do
    print_yellow "Esecuzione di wfuzz per il dominio: FUZZ.$domain"
    # Comando wfuzz con filtro per escludere i codici di stato 302, 400, 403, 404, 421
    wfuzz_command="wfuzz -H \"Host: FUZZ.$domain\" --hc 302,400,403,404,421 -t 50 -c -z file,\"/usr/share/seclists/Discovery/Web-Content/raft-small-words-lowercase.txt\" https://$domain/"
    eval $wfuzz_command | grep -E '^[0-9]+:.*[[:space:]](200|201|202|204|301|304)[[:space:]]' >> "$domain.txt"
    print_white ""  # Linea vuota in bianco per separare gli output dei vari domini
done
