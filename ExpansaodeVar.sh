#!/usr/bin/env bash

read -p $'Digite um texto\n' texto
#texto=${texto^^} #Converte o texto para maiusculo, com expansão de var
#texto=${texto^}  #Converte a primeira letra para maiusculo
#texto=${texto,,}  #Converte o texto para minusculo
#texto=${texto,}  #Converte a primeira leta para minusculo


echo ${texto#teste}