#!/bin/bash    

PAGES=$(pdfinfo kanji.pdf | grep "Pages" | awk '{print $NF}')                   ### Extract number of paages in card file                                                                           
REVERSE=$(( PAGES / 2 ))
OUTPUT=pagelist.tex     
NUM=0
arr=()                                                                          ### construct the pagelist array
for ((i=1; i<=$REVERSE; i++)); do
    NUM=$i
	arr+=("$NUM" )
    NUM=$(( REVERSE + i))
    arr+=("$NUM" )
done
PAGELIST=$(echo ${arr[@]} | sed 's/\s/, /g')                                    ### format for pdfpages
REORDERED="\includepdf[pages={${PAGELIST}}, delta=0 0, offset=0 0]{kanji.pdf}"  ### assemble full line of LaTeX code 
echo $REORDERED > $OUTPUT                                                       ### export as pagelist.tex

xelatex kanji-two-sided.tex                                                      ### compile reordered flashcard pages





