#!/usr/bin/python

import sys
import json
import subprocess
import os

# stack names should be unique
REGION = 'us-east-2'

def main(argv):

    stack = argv[0]
    repo_branch = argv[1]

    with open('credentials.csv', 'r') as f:
        aws_access_key, aws_secret_key = (s.strip() for s in f.read().split('\n')[1].split(',')[2:4])
        
    print("Repo branch: " + repo_branch)

    # run packer command(s) async
    command = "packer build -var-file=packer/aws/vars/{region}/{stack}/web-app.json -var 'region={region}' -var 'stack={stack}' -var 'repo_branch={repo_branch}' -var 'mode=portal' -var 'aws_access_key={aws_access_key}' -var 'aws_secret_key={aws_secret_key}' packer/aws/web-app.json".format(
        region=REGION, 
        stack=stack, 
        repo_branch=repo_branch,
        aws_access_key=aws_access_key,
        aws_secret_key=aws_secret_key
    )
    app_proc = subprocess.Popen([command], shell=True)
    if app_proc.poll() is None:
        app_proc.wait()
    if app_proc.poll() == 0:
        print('app: ' + str(app_proc.poll()))
    else:
        raise Exception('App Build Failed!')

    # get packer AMIs
    with open('packer-manifest-{region}-{stack}-app.json'.format(region=region, stack=stack), 'r') as f:
        json_dict = json.loads(f.read())
        app_ami = {b['packer_run_uuid'] : b['artifact_id'] for b in json_dict['builds']}[json_dict['last_run_uuid']].split(':')[1]
    print("App AMI: " + app_ami)


    print("Deploying Images...")

    # run terraform (not async)
    command = "terraform plan -var 'app_ami={app_ami}' -var-file=terraform/.varfiles/{region}-{stack}.tfvars -state=terraform/.statefiles/{region}-{stack}.tfstate terraform".format(region=region, stack=stack, app_ami=app_ami)
    if subprocess.call(command, shell=True) != 0:
        raise Exception('Image Deploy Failed!')

if __name__ == "__main__":
   main(sys.argv[1:])