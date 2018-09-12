#!/bin/bash

. ~/.env

PROMPT_COMMAND=__prompt_command

endcap[0]="⚀"
endcap[1]="⚁"
endcap[2]="⚂"
endcap[3]="⚃"
endcap[4]="⚄"
endcap[5]="⚅"

size=${#endcap[@]}

# Checks if network location is set to BBC On Network
function is_internal_network {
    [ "BBC On Network" = "$(/usr/sbin/scselect 2>&1 | grep '^ \*' | sed 's/.*(\(.*\))/\1/')" ]
}

function __prompt_command() {
	local EXIT="$?"
	PS1=""

	local RCol='\[\e[0m\]'

	local Red='\[\e[0;31m\]'
	local Gre='\[\e[0;32m\]'
	local BYel='\[\e[1;33m\]'
	local BBlu='\[\e[1;34m\]'
	local Pur='\[\e[0;35m\]'
	local Cya='\[\e[0;36m\]'

	if [ $EXIT != 0 ]; then
		PS1+="${Red}✖${RCol} "
	else
		PS1+="${Gre}✓${RCol} "
	fi

	endcapindex=$(($RANDOM % $size))

	if [ "BBC On Network" = "$(/usr/sbin/scselect 2>&1 | grep '^ \*' | sed 's/.*(\(.*\))/\1/')" ]; then 
		PS1+="[ ${Cya}PROXY ON${RCol} ]"
	else
		PS1+="[ ${Gre}PROXY OFF${RCol} ]"
	fi

	PS1+="\$(parse_git_branch) \u @ ${Cya}\w${RCol} [\t]\n${endcap[$endcapindex]} "
}

function parse_git_branch {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/' 
}

CERT_DIR="${HOME}/.cert"
CERT_FILE='cert.p12'
CERT_PEM_FILE='cert.pem'

export BASE_JAVA_OPTS="
-Djavax.net.ssl.keyStore=${CERT_DIR}/${CERT_FILE}
-Djavax.net.ssl.keyStorePassword=${CERT_PASS}
-Djavax.net.ssl.keyStoreType=PKCS12
"

# Maven
export PLATFORM_JAVA_OPTS=$BASE_JAVA_OPTS
export MAVEN_OPTS="-Xms256m -Xmx512m ${PLATFORM_JAVA_OPTS}"
