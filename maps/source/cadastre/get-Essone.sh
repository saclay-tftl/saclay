#!/bin/bash
[ -z "$1" ] && { echo "need url"; exit; }
URL=$1
TMP=$(mktemp -d)
echo -e "using $TMP\n"
cd $TMP
for i in {0..159}; do echo -en '\r'$i ; wget -q $URL$i.jpg?845135=624857; done
rename "s/^4_//" *
rename 's/.jpg.*/.jpg/' *
{ echo "<head><link rel="stylesheet" href=reset.css></head><body>"; for i in {0..9}; do echo "<div style='width:8292px;padding:0px;margin:0px;'>"; for j in {1..16}; do echo "<img style='display:block;float:left' src='$(( $i*16 + $j -1)).jpg'>"; done ; echo -e "\n</div>" ; done  ; echo "</body>" ; } > index.html
chromium index.html
