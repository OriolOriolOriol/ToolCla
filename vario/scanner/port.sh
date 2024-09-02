host=$1
green='\033[0;32m'
white='\033[0;37m'
echo "=========================================" 
echo "Scansione target: $host"
dt=$(date)
echo "Scansione iniziata alle: $dt"
echo "=========================================" 
while read port done 
do
    #tput setaf 1; echo "Scanning port $port..."
    #echo exit | telnet $host $port 2>/dev/null | grep "Connected"
    tput setaf 2
    (echo "" > /dev/tcp/$host/$port && echo "Port $port is open") && echo $port >> IP/IP_$host.txt
    tput sgr0
done 2>/dev/null < porte.txt
echo "-" * 50
dt=$(date)
echo "Scansione finita alle: $dt"
echo "-" * 50
