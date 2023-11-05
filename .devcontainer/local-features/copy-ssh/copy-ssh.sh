#!/bin/bash -i

# Copies localhost's ~/.ssh directory into the container
if [ "$SYNC_LOCALHOST_SSH" = "true" ] && [ -d "/usr/local/share/ssh-localhost" ]; then
    mkdir -p $HOME/.ssh
    sudo cp -r /usr/local/share/ssh-localhost/* $HOME/.ssh
fi