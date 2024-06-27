#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'  # Bright Yellow
NC='\033[0m' # No Color

# Temporary file to store the correct code
CODE_FILE="/tmp/verification_code.txt"

# Generate a new 6-digit verification code if the file doesn't exist
if [ ! -f "$CODE_FILE" ]; then
    CORRECT_CODE=$(printf "%06d" $((RANDOM % 1000000)))
    echo "$CORRECT_CODE" > "$CODE_FILE"
else
    CORRECT_CODE=$(cat "$CODE_FILE")
fi

# Function to display a big title
display_title() {
    echo -e "${YELLOW}███████╗██████╗ ███████╗███╗   ██╗██╗██╗  ██╗${NC}"
    echo -e "${YELLOW}██╔════╝██╔══██╗██╔════╝████╗  ██║██║██║ ██╔╝${NC}"
    echo -e "${YELLOW}███████╗██████╔╝█████╗  ██╔██╗ ██║██║█████╔╝ ${NC}"
    echo -e "${YELLOW}╚════██║██╔═══╝ ██╔══╝  ██║╚██╗██║██║██╔═██╗ ${NC}"
    echo -e "${YELLOW}███████║██║     ███████╗██║ ╚████║██║██║  ██╗${NC}"
    echo -e "${YELLOW}╚══════╝╚═╝     ╚══════╝╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝${NC}"
}

# Display the big title
display_title

# Display the additional messages
echo -e "${GREEN}Don't forget to follow my Instagram account ahu_orphan${NC}"
echo -e "${GREEN}This tool was designed by orphan From a team Lulzsec Black${NC}"

# Prompt user to enter the phone number
read -p "Enter the phone number: " PHONE_NUMBER

# Function to simulate verifying the code with an external service
# In a real-world scenario, replace this function with actual API calls
verify_code() {
    local code=$1
    if [[ "$code" == "$CORRECT_CODE" ]]; then
        return 0
    else
        return 1
    fi
}

# Brute force attempt to guess the 6-digit verification code
for i in $(seq -w 000000 999999); do
    if verify_code "$i"; then
        echo -e "${GREEN}Verification code guessed successfully for phone number $PHONE_NUMBER: $i${NC}"
        [ -f "$CODE_FILE" ] && rm "$CODE_FILE"  # Remove the file if it exists
        exit 0
    else
        echo -e "${RED}Trying code: $i${NC}"  # Display the current attempt in red
    fi
    sleep 0.1  # Add a 0.1 second delay between attempts
done

echo -e "${RED}Failed to guess the verification code for phone number $PHONE_NUMBER.${NC}"
