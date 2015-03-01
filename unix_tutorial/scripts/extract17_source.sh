#!/bin/bash


##################################
# This time we will see how      #
# we can call variables that     #
# are stored in a different file #
##################################


# The path to the current working directory is stored 
# in a variable called ${workdir} in the config file
# We can import that variable by telling this script 
# to run the config script before going on to do other
# commands:
source ../../config

# Now if we will see that this script has a new variable
# called ${workdir}. Let's tell the script to print it out:

echo ${workdir}

# Use the ${workdir} variable to navigate to the data folder

cd ${workdir}/unix_tutorial/data/




# The chromosome number can be specified in a variable:
chromosome="17"

# The number of rows to keep
number_of_rows="5"

# Next we will execute our command using the variables defined above
# Notice that we are substituting the number 17 with the variable defined above.
# We can "call" the variable by writing it like this ${chromosome}
# We are also substituting the number 5 with a variable

grep "^${chromosome} " snpdata.txt | head -n ${number_of_rows} | cut -d " " -f 2 > extract${chromosome}_from_script_source.txt
