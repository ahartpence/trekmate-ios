#!/bin/sh

echo "Stage: PRE-Xcode Build is activated .... "
#echo $(ls)

# Move to the place where the scripts are located.
# This is important because the position of the subsequently mentioned files depend of this origin.
#cd $CI_WORKSPACE/ci_scripts || exit 1

# Write a JSON File containing all the environment variables and secrets.
printf "{\"API_KEY\":\"%s\"\"}" "$API_KEY">> ../TrekMate/secrets.json
#cat ../TrekMate/secrets.json
echo "Wrote Secrets.json file."

echo "Stage: PRE-Xcode Build is DONE .... "

exit 0
