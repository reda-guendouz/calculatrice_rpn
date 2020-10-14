#!/bin/bash

op=false

operandes=()
operateurs=()

for i in $*
do
	case $i in
		'+') operateurs+=( "$i" )
			op=true;;
		'-') operateurs+=( "$i" )
			op=true;;
		'x') operateurs+=( "*" )
			op=true;;
		'/') operateurs+=( "/" )
			op=true;;
		*)
			if [[ "$i" =~ ^[0-9]+$ ]] && [ "$op" = false ]
			then
				operandes+=( "$i" )
			else
				echo "ERROR: Mauvaise entree d'arguements"
				exit 1
			fi;;
	esac
done

nbOperandes=${#operandes[@]}
diffOpe=$(("$nbOperandes" - "${#operateurs[@]}"))

if [ "$nbOperandes" -lt "2" ]
then
	echo "ERROR: Il n'y a pas assez d'operandes"
	exit 2
elif [ "$diffOpe" -ne "1" ]
then
	echo "ERROR: Il n'y a pas assez d'operateurs"
	exit 3
fi

resultat=0
indiceOper=0
while (("$nbOperandes"!="1"))
do
	operateur=${operateurs[$indiceOper]}
	unset operateurs[$indiceOper]
	indiceOper=$(("$indiceOper" + "1"))

	nbOperandes=$(("$nbOperandes" - "1"))
	operande1=${operandes[$nbOperandes]}
	unset operandes[$nbOperandes]
	
	temp=$(("$nbOperandes" - "1"))
	operande2=${operandes[$temp]}
	resultat=$(("$operande1" "$operateur" "$operande2"))	
	echo $operande1 $operateur $operande2
	echo $resultat	
	operandes[$temp]="$resultat"
done

echo "Resultat obtenu : $resultat"
exit 0
