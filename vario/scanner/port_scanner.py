import sys,os,time
import socket
from datetime import datetime


IP=["10.245.61.42","10.245.61.10","10.245.61.74","10.245.61.75","10.245.61.76","10.245.61.106","10.245.61.107","10.245.61.138","10.245.61.170","10.244.37.38"]

print(f"[+] Numero target da analizzare: {len(IP)} [+]")
print("\n")
for target in IP:
    #print("-" * 50)
    #print("Scansione Target: " + target)
    #start=datetime.now()
    #print("Scansione iniziata alle: " + str(start))
    #print("-" * 50)
    try:    
            command0=f"chmod +x /home/kali/Desktop/scanner/port.sh"
            os.system(command0)
            command= f'gnome-terminal -q --tab -e "bash /home/kali/Desktop/scanner/port.sh {target}"'
            os.system(f"{command}")
            
            #print("-" * 50)
            #end=datetime.now()
            #print("Scansione finita alle: " + str(end))
            #print("-" * 50)
    except KeyboardInterrupt:
        print("\nUscita dal programma!")
        sys.exit()
    except socket.gaierror:
        print("\nHostname non puo essere risolto. Controlla di essere connesso in VPN")
        sys.exit()
    except socket.error:
        print("\nLa macchina di questo IP non risponde!!!")
        sys.exit()
    
x=input("[+] Quando finite le scansioni premere un tasto a caso: [+]")
print("Creazione commandi nmap in corso...")
for target in IP:
    list_port=[]
    with open (f"IP/IP_{target}.txt") as nmap_scan:
            lines=nmap_scan.readlines()
            for line in lines:
                line=line.replace("\n","")
                list_port.append(line)
    port_nmap=""
    last_item=list_port[-1]
    for port in list_port:
        if port == last_item:
            port_nmap += port
        else:
            port_nmap += port + "," 
        command=f"sudo nmap -sT -sC -sV -Pn -n -vvv -p {port_nmap} {target}"
    print(command)
    print("\n")
    print("=" * 50)
    
