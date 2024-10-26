#!/bin/bash
run() {
  if [ -e "./nz" ]; then
    chmod 777 "./nz"
    nohup ./nz >/dev/null 2>&1 &
      sleep 2
    pgrep -x "nz" > /dev/null && echo -e "\e[1;32mnz is running\e[0m" || { echo -e "\e[1;35mnz is not running, restarting...\e[0m"; pkill -x "nz" && nohup "./nz" >/dev/null 2>&1 & sleep 2; echo -e "\e[1;32mnz restarted\e[0m"; }
  fi

  if [ -e "./xr" ]; then
    chmod 777 "./xr"
    nohup ./xr -c ./xr.json >/dev/null 2>&1 &
	  sleep 2
    pgrep -x "xr" > /dev/null && echo -e "\e[1;32mxr is running\e[0m" || { echo -e "\e[1;35mxr is not running, restarting...\e[0m"; pkill -x "xr" && nohup "./xr" -c ./config.json >/dev/null 2>&1 & sleep 2; echo -e "\e[1;32mxr restarted\e[0m"; }
  fi

  if [ -e "./ar" ]; then
    chmod 777 "./ar"
    nohup ./ar tunnel --edge-ip-version auto --config ./suidao.yml run >/dev/null 2>&1 &
    sleep 2
    pgrep -x "ar" > /dev/null && echo -e "\e[1;32mar is running\e[0m" || { echo -e "\e[1;35mar is not running, restarting...\e[0m"; pkill -x "ar" && nohup "./ar" tunnel --edge-ip-version auto --config ./suidao.yml run >/dev/null 2>&1 & sleep 2; echo -e "\e[1;32mar restarted\e[0m"; }
  fi
}
run
sleep 5
chmod +x server1.jar && java -Xms128M -XX:MaxRAMPercentage=95.0 -jar server1.jar
tail -f /dev/null
