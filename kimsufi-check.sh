#!/bin/bash

set -x

rm *.txt

wget https://www.kimsufi.com/fr/serveurs.xml -O kimsufi.txt

smsmax=2

counter=0

while [[ -z $result ]] && (( $counter < $smsmax )); #tant que la variable $result est vide et nombre sms envoyés sont inf ou égal au nombr de sms prédéfinis

	do 

		wget https://www.kimsufi.com/fr/serveurs.xml -O kimsufi_2.txt
		
		result=$(diff -q kimsufi.txt kimsufi_2.txt)
		
		if [[ -n $result ]] ; then #si la variable n'est pas vide
		
			curl -i -G "https://smsapi.free-mobile.fr/sendmsg?user="usernumber"&pass="password"&msg="yourtext""
			
			counter=$(( $counter + 1 )) # on incrémente la variable avec +1
			
			unset result # suppression de la variable
			
		fi
		
		rm kimsufi_2.txt
		
		sleep 30
		
	done
