#!/bin/bash

#Gecko_Log
#Create by Kaskae
#Description: Simple log analisis tool for security studies



clear
echo "\e[32m"

cat << "EOF"
   ██████╗ ███████╗ ██████╗ ██╗  ██╗ ██████╗     ██╗      ██████╗  ██████╗
  ██╔════╝ ██╔════╝██╔════╝ ██║ ██╔╝██╔═══██╗    ██║     ██╔═══██╗██╔════╝
  ██║  ███╗█████╗  ██║      █████╔╝ ██║   ██║    ██║     ██║   ██║██║  ███╗
  ██║   ██║██╔══╝  ██║      ██╔═██╗ ██║   ██║    ██║     ██║   ██║██║   ██║
  ╚██████╔╝███████╗╚██████  ██║  ██╗╚██████╔╝    ███████╗╚██████╔╝╚██████╔╝
   ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝ ╚═════╝     ╚══════╝ ╚═════╝  ╚═════╝
EOF

echo "\e[0m"
echo
echo "Gecko Log — Web Log Analysis Framework"
echo "Author: Gabriel França | Version: v0.1-beta"
echo
echo "--------------------------------------------"
echo


echo "Entre com o nome do arquivo que deseja analisar: "

read arquivo

if [ -f "$arquivo" ]; then


	IP=$( cut -d " " -f 1 "$arquivo" | sort | uniq -c | sort -nr | head -n 1 )
	ONLYIP=$(echo "$IP" | awk '{print $2}')
	ONLYACCESS=$(echo "$IP" | awk '{print $1}')
	Horario=$( cat "$arquivo" | grep "$ONLYIP" |  cut -d [ -f 2 | cut -d - -f 1 )
	Dir=$( cat "$arquivo" | grep "$ONLYIP" | grep 200 | awk '{print $7}' | grep -vE '^/[0-9]+$' | sort | uniq -c | sort -nr )
	HorarioInicio=$( echo "$Horario" | head -n 1 )
	HorarioFinal=$( echo "$Horario" | tail -n 1 )

	echo "========================[ SUMMARY ]========================"
	echo
	echo "Target IP      :  $ONLYIP  "
	echo
	echo "Total Request  :  $ONLYACCESS  "
	echo
	echo "Time Range     :  $HorarioInicio  ->  $HorarioFinal "
	echo
	echo "======================[ DIRECTORIES ]======================"
	echo
	echo "$Dir" | awk '{ printf " [ %3s ] %s\n", $1, $2 }'


else
	echo "O seguinte arquivo não foi encontrado: $arquivo "
fi


