#!/usr/bin/env bash

cd /srv/picker_demo
pip install virtualenv
virtualenv venv
source venv/bin/activate && pip install -r requirements.txt