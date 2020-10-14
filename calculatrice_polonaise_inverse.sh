#!/bin/bash

# code d'erreur : 1 un des parametres n'est pas un nombre ni un des opérants suivant : + - x /
#				  2 il y a trop d'arguments opérants apr rapport aux arguments de type nombre
pile=()

for var in $*
do
	case $var in
		'+') signe='+';;
		'-') signe='-';;
		'x') signe='x';;
		'/') signe='/';;
		*)  re='^[0-9]+$'
			if  ! [[ $yournumber =~ $re ]] ; then
				pile[${#pile[@]}]=$var
				signe=false
			else
				echo "error: une variable n'est ni nombre ni signe"
				exit 1
			fi;;
	esac

	if [ $signe != false ]; then
		if [ ${#pile[@]} -gt 1 ]; then
			if [ $signe == 'x' ]; then
				pile[0]=$((${pile[0]}*${pile[1]}))
			else
				pile[0]=$((${pile[0]}$signe${pile[1]}))
			fi
			for i in `seq 1 $((${#pile[@]}-1))`
			do
				pile[$i]=${pile[$(($i+1))]}
			done
			unset pile[$((${#pile[@]}-1))]
		else
			echo "error : trop d'opérants / pas assez de nombre"
			exit 2
		fi
	fi
done

echo ${pile[0]}
