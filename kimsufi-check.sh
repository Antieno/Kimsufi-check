#!/bin/bash

set -x

cd /yourscriptdirectory/

rm *.txt

wget https://www.kimsufi.com/fr/serveurs.xml -O kimsufi.txt

runmax=120

run=0

smsmax=5

countersms=0

while [[ -z $result ]] && (( $countersms < $smsmax )) && (( $run < $runmax ));

	do 

		wget https://www.kimsufi.com/fr/serveurs.xml -O kimsufi_2.txt
		
		result=$(diff -q kimsufi.txt kimsufi_2.txt)
		
		if [[ -n $result ]] ; then 
		
			curl -i -G "https://smsapi.free-mobile.fr/sendmsg?user=00000000&pass=xxxxxxxxxx&msg=yourtext" #send sms with Free operator
			
			countersms=$(( $countersms + 1 )) 
			
			unset result 
			
		fi
		
		rm kimsufi_2.txt
		
		run=$(( $run + 1 ))
		
		sleep 30
		
	done
