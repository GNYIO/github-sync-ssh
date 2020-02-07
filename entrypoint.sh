#!/bin/sh -l

set -e

if [[ ! -z "$SSH_PRIVATE_KEY" ]]; then
  echo "Saving SSH_PRIVATE_KEY"

  mkdir -p /root/.ssh
  echo "$SSH_PRIVATE_KEY" > /root/.ssh/id_rsa
  chmod 600 /root/.ssh/id_rsa

  # Github action changes $HOME to /github at runtime
  # therefore we always copy the SSH key to $HOME (aka. ~)
  mkdir -p ~/.ssh
  cp /root/.ssh/* ~/.ssh/ 2> /dev/null || true 
fi

sh -c "/github-sync.sh $*"