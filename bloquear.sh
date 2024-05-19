#!/bin/bash
#Bloqueia a tela com o programa i3-lock, o diferencial do Script é que ele tira prit da tela atual
#e usa a mesma, mas borrada, como proteção de tela, dando um ar mais elagante ao pc.

i="i.png"
blur="blur.png"

cd /tmp/
#Verifica se a imagem ja existe, se existe, apaga ela e a 
#versão processada(se a imagem existir, significa que o programa ja rodou antes
[[ -e $i ]] && rm $i $blur ||  true  

#tira print e salva como i.png na pasta /tmp
magick import -window root -quiet $i 
#transforma a imagem em uma borrada
magick ./$i -blur 0x3 $blur

#chama o bloqueio de tela com a blur
i3lock -k  --show-failed-attempts -i ./$blur

