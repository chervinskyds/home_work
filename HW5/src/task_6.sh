#!/bin/bash
read -p "Введіть речення: " sentence
echo "$sentence" | awk '{for (i=NF; i>0; i--) printf $i" "; print ""}'
