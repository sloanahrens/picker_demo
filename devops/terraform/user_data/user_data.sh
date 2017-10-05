#!/bin/bash -v
test -e /usr/bin/python || (apt -y update && apt install -y python-minimal)
