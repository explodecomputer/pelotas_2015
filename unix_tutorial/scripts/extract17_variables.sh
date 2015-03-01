#!/bin/bash


#############################
# This time we will see how #
# variables can be used in  #
# our scripts               #
#############################


# Navigate to the data directory
cd ~/pelotas_2015/unix_tutorial/data/


# The chromosome number can be specified in a variable:
chromosome="17"

# The number of rows to keep
number_of_rows="5"

# Next we will execute our command using the variables defined above
# Notice that we are substituting the number 17 with the variable defined above.
# We can "call" the variable by writing it like this ${chromosome}
# We are also substituting the number 5 with a variable

grep "^${chromosome} " snpdata.txt | head -n ${number_of_rows} | cut -d " " -f 2 > extract${chromosome}_from_script_variable.txt
