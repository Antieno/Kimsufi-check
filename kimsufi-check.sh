#!/bin/bash

set -x

cd /opt/prod/script/kimsuficheck/

rm *.txt

wget https://www.kimsufi.com/fr/serveurs.xml -O kimsufi.txt

runmax=120

run=0

smsmax=5

countersms=0

while [[ -z $result ]] && (( $countersms < $smsmax )) && (( $run < $runmax )); #tant que la variable $result est vide et nombre sms envoyés sont inf ou égal au nombr de sms prédéfinis

	do 

		wget https://www.kimsufi.com/fr/serveurs.xml -O kimsufi_2.txt
		
		result=$(diff -q kimsufi.txt kimsufi_2.txt)
		
		if [[ -n $result ]] ; then #si la variable n'est pas vide
		
			curl -i -G "https://smsapi.free-mobile.fr/sendmsg?user=10113398&pass=AAm8ynqD0RF9m4&msg=Du changement sur la page Kimsufi, va vérifier Léon ! Fonce !!"
			
			countersms=$(( $countersms + 1 )) # on incrémente la variable avec +1
			
			unset result # suppression de la variable
			
		fi
		
		rm kimsufi_2.txt
		
		run=$(( $run + 1 ))
		
		sleep 30
		
	done
