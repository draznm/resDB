#!/bin/bash

######
# This script compiles and runs the code. You need to specify IP addresses of your servers and clients.
# The script expects three arguments and stores results in a "results" folder. Ensure the folder exists before running.
######

# Arguments
i=8   # Number of replicas
cli=2 # Number of clients
name="test"
runs=1
bsize=100 # Batch Size

# Server and Client Node IPs
SNODES=(
    "10.138.0.48"
    "10.138.0.30"
    "10.138.0.29"
    "10.138.0.47"
    "10.138.0.43"
    "10.138.0.4"
    "10.138.0.55"
    "10.138.0.39"
)

CNODES=(
    "10.138.0.34"
    "10.138.0.16"
)

# Ensure that requested nodes are within array bounds
if [[ $i -gt ${#SNODES[@]} || $cli -gt ${#CNODES[@]} ]]; then
    echo "Error: Requested number of nodes exceeds available nodes."
    exit 1
fi

# Remove old configuration files if they exist
rm -f ifconfig.txt hostnames.py

# Create `ifconfig.txt` with IP addresses of servers and clients
{
    for ((count = 0; count < i; count++)); do
        echo "${SNODES[count]}"
    done
    for ((count = 0; count < cli; count++)); do
        echo "${CNODES[count]}"
    done
} > ifconfig.txt

# Create `hostnames.py`
{
    echo "hostip = ["
    for ((count = 0; count < i; count++)); do
        echo "    \"${SNODES[count]}\","
    done
    for ((count = 0; count < cli; count++)); do
        echo "    \"${CNODES[count]}\","
    done
    echo "]"

    echo "hostmach = ["
    for ((count = 0; count < i; count++)); do
        echo "    \"${SNODES[count]}\","
    done
    for ((count = 0; count < cli; count++)); do
        echo "    \"${CNODES[count]}\","
    done
    echo "]"
} > hostnames.py

# Compile the Code
# Uncomment if compilation is needed
# make clean; make -j8

# Copy necessary files to the scripts directory
cp run* ifconfig.txt config.h hostnames.py scripts/

# Change directory to scripts
cd scripts || { echo "Error: Failed to enter scripts directory"; exit 1; }

echo "Setup completed successfully."