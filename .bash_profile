# This goes inside ~/.bash_profile
 
. "$HOME/.bashrc"
 
if is_internal_network; then
    echo "On the BBC network; setting HTTP proxy env variables"
    export http_proxy="http://www-cache.reith.bbc.co.uk:80"
    export https_proxy="$http_proxy"
    export HTTP_PROXY="$http_proxy"
    export HTTPS_PROXY="$http_proxy"
    export ALL_PROXY="$http_proxy"
    export no_proxy=localhost,127.0.0.1
    export NO_PROXY=$no_proxy
 
    echo "Using ON Reith SSH config"
    cp ~/.ssh/on-reith-config ~/.ssh/config
else
    echo "NOT on the BBC network; skipping HTTP proxy env variables"
 
    echo "Using OFF Reith SSH config"
    cp ~/.ssh/off-reith-config ~/.ssh/config
fi

function title {
  printf "\033]0;%s\007" "$1"
}

alias ls="ls -CG"

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"
