#!/bin/bash
printf "Konclude started \n waiting for its log ..." ;
app/KoncludeLinux realization -i aux/onto.functionalsyntax.owl | sed $'s/[^[:print:]\t]//g' ;
echo "Konclude finished" ;
echo "****************************************************************" ;
