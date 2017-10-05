#!/usr/bin/env bash

# perms on key files
chmod 400 /ops/picker-devops.pem
chmod 600 /ops/picker-devops.pub

# not sure why all this is necessary, but it fails without it
ssh-keyscan github.com >> /home/ubuntu/.ssh/known_hosts
eval `ssh-agent`
ssh-agent bash -c \
'ssh-add /ops/picker-devops.pem; git clone git@github.com:sloanahrens/picker_demo.git /ops/picker_demo'