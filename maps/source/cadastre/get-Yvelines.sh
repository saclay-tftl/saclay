#!/bin/bash
# http://archives.yvelines.fr/Cadastre/620/AD078CA_620_000000005_P
[ -z "$1" ] && { echo "need url"; exit; }
URL=$1
TMP=$(mktemp -d)
echo -e "using $TMP\n"
cd $TMP
for group in {0..3}; do for i in {0..30}; do for j in {0..20} ; do echo -ne "\r$group:$i.$j    " ; [ ! -f "5-$i-$j.jpg" ] && wget -q $URL/TileGroup$group/5-$i-$j.jpg; done ; done; done
convert `for f in {0..19}; do echo \( $(ls 5-*-$f.jpg| sort -t -  --version-sort) +append \) ; done` -background none   -append out.pdf
thunar out.pdf
