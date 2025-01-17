#!/bin/bash
   echo -e "\033[1;35m\033[1m\033[4m" # Enable ANSI escape codes
prompt="||gitstat||>>>"
tpmorp="<<<<<<<<<<<<<<<<<<<<<<<"
   
n() {
	echo "" 
}

BASHRC_FILE="$HOME/.bashrc"
WHICHGIT=$(which git)
GIT=$WHICHGIT
GIT_ALIAS=$(perl -nle 'print $1 if /^\s*[^#]/ && /alias\s+git=\s*['"'"'"]?(.+?)['"'"'"]?\s*$/' $BASHRC_FILE)

#Display current system git executable
n
echo "$prompt Git system: $WHICHGIT"
echo "$prompt Git alias: $GIT_ALIAS"
if [ -n "$GIT_ALIAS" ]; then
	       WHICHGIT="$(which $GIT_ALIAS)"
	       GIT=$GIT_ALIAS
   echo "$prompt Using Git executable: $WHICHGIT"
else
   echo "$prompt Notice: Git alias not found in $BASHRC_FILE" >&2
fi	

echo -e "\033[0m"
# Display current repository status
n
echo "$prompt Repository Status: $tpmorp"
$GIT status


# Display local and remote branches
n
echo "$prompt Branches: $tpmorp"
$GIT branch -a
n

# Display remotes
n
echo "$prompt Remotes: $tpmorp"
n
$GIT remote -v
n


# Display current credentials
n
echo "$prompt Credentials: $tpmorp"
n

#$GIT config --list | grep -E "user.name|user.email|credential.helper"
$GIT config --list | grep -E "user.name|credential.helper"

n

#Display github cli status
echo "$prompt GitHub status: $tpmorp"
n

gh status

n

#Check connection status
n
echo "$prompt Connection status: $tpmorp"
connection=$(curl -s ipinfo.io)
#ip=$(echo $connection | sed -E 's/^.*"ip": "([^"]*)".*$/\1/')
#org=$(echo $connection | sed -E 's/^.*"org": "([^"]*)".*$/\1/')
#hostname=$(echo $connection | sed -E 's/^.*"hostname": "([^"]*)".*$/\1/')
city=$(echo $connection | sed -E 's/^.*"city": "([^"]*)".*$/\1/')
region=$(echo $connection | sed -E 's/^.*"region": "([^"]*)".*$/\1/')
country=$(echo $connection | sed -E 's/^.*"country": "([^"]*)".*$/\1/')
loc=$(echo $connection | sed -E 's/^.*"loc": "([^"]*)".*$/\1/')
timezone=$(echo $connection | sed -E 's/^.*"timezone": "([^"]*)".*$/\1/')
echo "	$ip > $org > $hostname > $city > $region > $country > $timezone"
n
echo "$prompt Good luck!"
n


