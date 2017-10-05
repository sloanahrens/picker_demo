#!/bin/bash
export APP_DEBUG="{{app_debug}}"
export HOME={{project_path}}
source $HOME/venv/bin/activate
cd $HOME/picker
exec uwsgi --ini $HOME/uwsgi.ini
