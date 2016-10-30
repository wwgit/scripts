#!/bin/bash

#It reads from a string and split it into array using given separator
#input1: string to be split
#input2: separator
#output: an array retrieved from output of awk program
splitStrNewFormat(){

  local array=;
  array=`echo "$1"|awk -F "$2" 'END{for(i=1;i<=NF;i++){print $i}}'`;
  
  #Not to use double quota for format concern,directly output value can 
  #ajust its format into something like 'm=a cond=listen int=30 dur=30m',
  #instead of the following format which we don't want:
  #m=a
  #cond=listen
  #int=30
  #dur=30m
  echo $array;

}