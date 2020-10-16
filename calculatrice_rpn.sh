#!/bin/bash

#variable qui permet de verifier si on entre les bons arguements
op=false 

#tableaux qui stock les operandes et operateurs
operandes=() 
operateurs=()

#parcours des arguments et stockage dans les tableaux
for i in $*
do
	case $i in
		'+') operateurs[${#operateurs[@]}]='+'
			op=true;;
		'-') operateurs[${#operateurs[@]}]='-'
			op=true;;
		'x') operateurs[${#operateurs[@]}]='*'
			op=true;;
		'/') operateurs[${#operateurs[@]}]='/'
			op=true;;
		*)
			if [[ "$i" =~ ^[0-9]+$ ]] && [ "$op" = false ]
			then
				operandes[${#operandes[@]}]="$i"
			else
				echo "ERROR: Mauvaise entree d'arguements"  #Erreur si on entre un operateurs apres un operandes ou si on entre un mauvais argument
				exit 1
			fi;;
	esac
done

#Test si on a le bon nombre d'argument
nbOperandes=${#operandes[@]}
diffOpe=$(($nbOperandes - ${#operateurs[@]}))

if [ "$nbOperandes" -lt "2" ]
then
	echo "ERROR: Il n'y a pas assez d'operandes"
	exit 2
elif [ "$diffOpe" -ne "1" ]
then
	echo "ERROR: Il n'y a pas assez d'operateurs"
	exit 3
fi


#On passe au calcul avec un systeme de pile grâce a nos deux tableaux
resultat=0
indiceOper=0
while (("$nbOperandes"!="1"))
do
	operateur=${operateurs[$indiceOper]}
	unset operateurs[$indiceOper]
	indiceOper=$(($indiceOper + 1))

	nbOperandes=$(($nbOperandes - 1))
	operande1=${operandes[$nbOperandes]}
	unset operandes[$nbOperandes]
	
	temp=$(($nbOperandes - 1))
	operande2=${operandes[$temp]}
	resultat=$(($operande1 $operateur $operande2))	
	operandes[$temp]="$resultat"
done

#On renvoie le resultat
echo "Resultat obtenu : $resultat"
exit 0
