#!/bin/bash

# Function to display script usage
usage() {
    echo "Usage: $0 [-d directory1 directory2 ...] -t threshold_in_percentage"
    echo "Options:"
    echo "  -d    Directories to check (space-separated)"
    echo "  -t    Threshold in percentage (required)"
    exit 1
}

# Parse command line options
while getopts "d:t:" opt; do
    case $opt in
        d)
            directories+=("$OPTARG")
            ;;
        t)
            threshold=$OPTARG
            ;;
        \?)
            usage
            ;;
    esac
done

# Check if threshold is provided
if [ -z "$threshold" ]; then
    echo "Threshold value is required."
    usage
fi

# Check if no directories were provided
if [ ${#directories[@]} -eq 0 ]; then
    echo "No directories specified."
    usage
fi

# Iterate over each provided directory
for dir in "${directories[@]}"; do
    # Get disk usage percentage of the directory
    usage_percentage=$(df -h --output=pcent "$dir" | tail -n 1 | tr -d '[:space:]%')

    # Check if disk usage exceeds the threshold
    if [ $usage_percentage -gt $threshold ]; then
        echo "Alert: Disk usage of $dir is $usage_percentage%, exceeding threshold of $threshold%."
    fi
done

