#!/usr/bin/env bash
#
# v. 1.0
#
# Stats on Coronavirus in Finland
# Utilizes https://github.com/HS-Datadesk/koronavirus-avoindata

# Check for Homebrew, install if necessary
if test ! $(which brew)
 then
 echo "Installing Homebrew first..."
 ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Check for jq package, install if necessary
if test ! $(which jq)
then
  echo "Updating Homebrew..."
  brew update
  echo "Installing jq..."
  brew install jq
fi

# Download and save the JSON
curl -s 'https://w3qa5ydb4l.execute-api.eu-west-1.amazonaws.com/prod/finnishCoronaData/v2' > coronaData.json
echo -e "---------------------------------"
printf "Coronavirus in Finland "; date +"%d.%m.%Y";
echo -e "---------------------------------"
echo -e "Infections:";
cat coronaData.json | jq ".confirmed" |  grep -o -E "\"id\":.+" | awk -F\: '{print $2}' | sed -e $'s/,//g' | sed 's/^[[:space:]]*//' | sed 's/"//g' | wc -l | sed 's/^[[:space:]]*//'
echo -e "---------------------------------\nDeaths:";
cat coronaData.json | jq ".deaths" |  grep -o -E "\"id\":.+" | awk -F\: '{print $2}' | sed -e $'s/,//g' | sed 's/^[[:space:]]*//' | sed 's/"//g' | wc -l | sed 's/^[[:space:]]*//'
echo -e "---------------------------------"