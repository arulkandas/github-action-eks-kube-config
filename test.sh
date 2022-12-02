#!/bin/sh

IN="yes;no"

for i in $(echo $IN | tr ";" "\n")
do
  echo $i 
done
