#!/bin/bash

# Chiedi all'utente di inserire l'username
read -p "+ Inserisci l'username: " user

# Chiedi all'utente di inserire la password
read -s -p "+ Inserisci la password: " pass
echo
pass=$(printf '%s\n' "$pass" | sed 's/\\/\\\\/g')
# Chiedi all'utente di inserire il dominio
read -p "+ Inserisci il dominio: " domain

# Chiedi all'utente di inserire l'indirizzo IP del domain controller
read -p "+ Inserisci l'indirizzo IP del domain controller: " dcIp

# Avvia Neo4j con un titolo
gnome-terminal --title="Neo4j" -- sudo neo4j console

echo 
# Attendi che l'utente prema Invio per continuare
read -p "+ Premi Invio per continuare quando neo4j is UP... +"

# Avvia BloodHound con un titolo
gnome-terminal --title="BloodHound" -- bloodhound


echo 
echo "cd /home/attacker/Desktop/BloodHound/BloodHound.py; ./bloodhound.py -c All -u \"$user\" -p \"$pass\" -d \"$domain\" -ns \"$dcIp\"";
echo "cd /home/attacker/Desktop/BloodHound/BloodHound.py;cp *.json /home/attacker/Desktop/BloodHound/result"

