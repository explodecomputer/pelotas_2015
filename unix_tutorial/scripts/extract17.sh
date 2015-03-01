#!/bin/bash


# This is a comment, it will not be executed by the script
# Use comments to annotate scripts so that you remember what everything means!


##################################
# This script will extract the   #
# first 5 SNPs on chromosome 17  #
# from snpdata.txt               #
##################################


# First we will move to the directory with the data
cd ~/pelotas_2015/unix_tutorial/data/

# Next we will execute our command
# 1. Extract all lines beginning with "17 "
# 2. Keep just the first 5 lines
# 3. Keep just the second column
# 4. Save to a new file
grep "^17 " snpdata.txt | head -n 5 | cut -d " " -f 2 > extract17_from_script.txt
