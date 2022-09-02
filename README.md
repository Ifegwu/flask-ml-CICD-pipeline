[![Python application test with Github Actions](https://github.com/Ifegwu/flask-ml-CICD-pipeline/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/Ifegwu/flask-ml-CICD-pipeline/actions/workflows/main.yml)

# flask-ml-CICD-pipeline
Delivering a flask machine learning application with Azure cloud DevOps CI/CD pipeline

####
# Overview
####
This project shows how to build a Continuous Integration (CI) and Continuous Delivery (CD) pipeline with Azure Cloud and GitHub repository from scratch. Few actions to perform include:
  * Setting up a Github Action
  * Application code to perform lint, test, and installations.
  * Azure Pipeline integration to the project to enable CI/CD to Azure App Service
  
# Architectural Workflow Diagram
####

![CICD](https://user-images.githubusercontent.com/9282421/188189186-38ab2fa1-f631-49cb-86cc-f9d0b907c3d6.png)
####

# Status
####
[![Python application test with Github Actions](https://github.com/Ifegwu/flask-ml-CICD-pipeline/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/Ifegwu/flask-ml-CICD-pipeline/actions/workflows/main.yml)

Project Plan
####

SpreedSheet
####
Here is a [spreedsheet](https://docs.google.com/spreadsheets/d/1u1nSlc4LZyaczjHNPETdtgFpjrzZU6eWWhQxa-Ft8Xo/edit#gid=0) for the project management deliverables which contains weekly, quarterly, yearly plans.

# Trello Board
The [trello board](https://trello.com/b/YdVOTHFs/project-2-building-azure-ci-cd-pipeline) contains the project management progressions. The workflow is simplified in 3 stages based on:
* To Do,
* In Progress, and
* Done

# Continuous Integration
## Setting Up Azure Cloud Development Environment
####
I generate ssh-keys with ssh-keygen in Azure Cloud enviironment, and integrate it to Github. This will enable interraction between Github repos and Azure Cloud shell.


![project-cloned-into-azure-cloud-shell](https://user-images.githubusercontent.com/9282421/188196800-a60514f5-1f2d-47ca-a20f-234d7cdd937a.png)
![repo](https://user-images.githubusercontent.com/9282421/188197221-9d7e4da9-6acf-4d31-a9cd-4c0b89a2a492.png)

# Makefile
```
pip install --upgrade pip &&\
  	pip install -r requirements.txt
  
test:
    python -m pytest -vv test_hello.py

lint:
  	pylint --disable=R,C hello.py

all: install lint test
```
# requirements.txt
```
Flask==2.1.1
pandas==1.3.5
scikit-learn==1.0.2
importlib-metadata==4.11.3
virtualenv==20.14.1
argcomplete==2.0.0
joblib==1.1.0
pylint==2.13.7
pytest==7.1.2
locust
jinja2==3.0
```
# Virtual Environment
```
python3 -m venv ~/.myrepo
source ~/.myrepo/bin/activate
```
# Local install and test
####
```
(.myrepo) daniel [ ~/flask-ml-CICD-pipeline ]$ make all
```
![make-all3](https://user-images.githubusercontent.com/9282421/188201592-a9075cc7-9afb-45e0-8ce9-6c95ced28461.png)
![make-all4](https://user-images.githubusercontent.com/9282421/188201606-c7f0bf92-2b06-4095-901a-098fb27e778f.png)

# Configuring Github Actions
####
Github Actions enables performing CI/CD
```
name: Python application test with Github Actions

on: [push]

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2
    - name: Set up Python 3.7
      uses: actions/setup-python@v1
      with:
        python-version: 3.7
    - name: Install dependencies
      run: |
        make install
    - name: Lint with pylint
      run: |
        make lint
    - name: Test with pytest
      run: |
        make test
```
# CI: Github Action performing CI job
![github-action-build](https://user-images.githubusercontent.com/9282421/188202728-47c4a4ed-31d1-4f4c-8750-795135d133a7.png)

# Azure App Service deployment
```
(.myrepo) daniel [ ~/flask-ml-CICD-pipeline ]$  az webapp up -n flaslmlapp
```
![webapp-deployed](https://user-images.githubusercontent.com/9282421/188203795-05708617-51c3-47ba-a900-34ff619fa31e.png)

