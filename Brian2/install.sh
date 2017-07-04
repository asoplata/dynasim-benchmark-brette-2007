#!/bin/bash

DATESTAMP=$(date +%F)

echo -e "\n-------------------------------------------\n"
echo "First, let's add the "brian-team" channel to your anaconda channels via the .condarc Run Command file:"
echo -e "\n"

if [ -f ~/.condarc ]; then
    echo "Backing up your ~/.condarc file to ~/.condarc_${DATESTAMP} ..."
    mv ~/.condarc ~/.condarc_${DATESTAMP}
fi

cp .condarc ~/.condarc

echo -e "\n-------------------------------------------\n"
echo -e "Then, let's create an environment named 'brian2-sim-env' that works for us:"
echo -e "Please hit yes at the prompt:"
echo -e "\n"

# # Must load anaconda specifically if on the SCC cluster:
# ...Except this isn't necessary in shell scripts???
# module load anaconda3

conda create -n brian2-sim-env python=3.5 brian2

