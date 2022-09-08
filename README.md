[![Python application test with Github Actions](https://github.com/Ifegwu/flask-ml-CICD-pipeline/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/Ifegwu/flask-ml-CICD-pipeline/actions/workflows/main.yml)

# flask-ml-CICD-pipeline
Building a CI/CD pipeline With Azure Cloud and Github repository

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

### Status
####
[![Python application test with Github Actions](https://github.com/Ifegwu/flask-ml-CICD-pipeline/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/Ifegwu/flask-ml-CICD-pipeline/actions/workflows/main.yml)

Project Plan
####

SpreedSheet
####
Here is a [spreedsheet](https://docs.google.com/spreadsheets/d/1u1nSlc4LZyaczjHNPETdtgFpjrzZU6eWWhQxa-Ft8Xo/edit#gid=0) link for the project management deliverables which contains weekly, quarterly, yearly plans.

# Trello Board
Her is a [trello board](https://trello.com/b/YdVOTHFs/project-2-building-azure-ci-cd-pipeline) link which contains the project management progressions of this project. The workflow is simplified in 3 stages based on:
* To Do,
* In Progress, and
* Done

# Continuous Integration
## Setting Up Azure Cloud Development Environment
####
To prepare the Azure cloud shell, we have to first generate ssh-keys with ssh-keygen in Azure Cloud enviironment, and integrate it to Github. This will enable interraction between Github repos and Azure Cloud shell.


![project-cloned-into-azure-cloud-shell](https://user-images.githubusercontent.com/9282421/188196800-a60514f5-1f2d-47ca-a20f-234d7cdd937a.png)
![repo](https://user-images.githubusercontent.com/9282421/188197221-9d7e4da9-6acf-4d31-a9cd-4c0b89a2a492.png)

### Makefile
```
pip install --upgrade pip &&\
  	pip install -r requirements.txt
  
test:
    python -m pytest -vv test_hello.py

lint:
  	pylint --disable=R,C hello.py

all: install lint test
```
### requirements.txt
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
### Virtual Environment
```
python3 -m venv ~/.myrepo
source ~/.myrepo/bin/activate
```
### Local install and test
####
```
(.myrepo) daniel [ ~/flask-ml-CICD-pipeline ]$ make all
```
![make-all3](https://user-images.githubusercontent.com/9282421/188201592-a9075cc7-9afb-45e0-8ce9-6c95ced28461.png)
![make-all4](https://user-images.githubusercontent.com/9282421/188201606-c7f0bf92-2b06-4095-901a-098fb27e778f.png)

### Making a local Machine Learning prediction
####
#### First: running the webserver
```
(.myrepo) daniel [ ~/flask-ml-CICD-pipeline ]$ python appy
```
![local-runs](https://user-images.githubusercontent.com/9282421/188450751-84fac183-f7c7-4d56-878c-df663fb0612b.png)

#### Second: make prediction
```
(.myrepo) daniel [ ~/flask-ml-CICD-pipeline ]$ ./make_prediction.sh
```
![local-prediction](https://user-images.githubusercontent.com/9282421/188451336-2267dd3c-ba03-48b5-a17d-047b68bc11a4.png)


### Configuring Github Actions
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
### CI: Github Action performing CI job
![github-action-build](https://user-images.githubusercontent.com/9282421/188202728-47c4a4ed-31d1-4f4c-8750-795135d133a7.png)

### Azure App Service deployment
####
```
(.myrepo) daniel [ ~/flask-ml-CICD-pipeline ]$  az webapp up -n flaslmlapp
```
![webapp-deployed](https://user-images.githubusercontent.com/9282421/188203795-05708617-51c3-47ba-a900-34ff619fa31e.png)

### On running above command, you can visit the app url to confirm if the app is up and running.
Here is the url link for this app service: https://flaskmlapp.azurewebsites.net/
![sklearn-prediction-home](https://user-images.githubusercontent.com/9282421/188204914-cb824f67-1400-4009-a336-e77eee5e4daf.png)

#### Proof of App service deployment as shown in Azure App Service Portal
![azure-app-service](https://user-images.githubusercontent.com/9282421/189181810-29d9e07e-d493-4a69-8cae-c4f6b714bce0.png)

### Showing logs of your running webapp via Azure Cloud shell
```
(.myrepo) daniel [ ~/flask-ml-CICD-pipeline ]$ az webapp log tail
```
![az-webapp-log-tail](https://user-images.githubusercontent.com/9282421/188206177-1bb74210-777a-44e1-af80-efb7a42d4fdf.png)

### Calling the remote webapp via API for Machine Learning prediction
```
(.myrepo) (base) daniel [ ~/flask-ml-CICD-pipeline ]$ ./make_predict_azure_app.sh 
```
![ml-api-predition](https://user-images.githubusercontent.com/9282421/188452370-5c5700ad-3add-40f3-972a-266113dde9a7.png)

### Performance validation of the webapp can be performed via a load test using locust. You can replace '<yourappname>' in the provided configuration and call locust:
In using the parameters above, locust will use 20 users with a spawn rate of 5 users per second and run for 20 seconds:

 ```
 (.myrepo) daniel [ ~/flask-ml-CICD-pipeline ]$ locust -f locustfile.py --headless -u 20 -r 5 -t 20s
 ```
 ![locustfile](https://user-images.githubusercontent.com/9282421/188207007-80e1747c-dd60-4163-b56a-929b217e37c8.png)
 
####
### Setting up CI/CD using Azure Pipeline
####
* Visit Azure DevOps Organisations, create a new project called Flask-ML-CICD
* Ensure new service connection is setup via Azure Resource Manager and Pipeline
* Goto organizations setting > new service connection (under pipeline) > Azure Resource Manager
* Select Pipeline and create a new one
* Create the GitHub Integration
* Configure python to Linux Web app on Azure
* Set up the continuous delivery workflow

![CICD-using-Azure-Pipelines](https://user-images.githubusercontent.com/9282421/188208285-9b6478bc-e089-41c5-be0d-6a1c0b20e44a.png)
![jobs-in-run](https://user-images.githubusercontent.com/9282421/188208319-6ce7de2e-117a-49c5-a80c-a26aa535d0b1.png)

From now on every change to your code will trigger the CI/CD pipeline and update your webapp as shown in image below:

![cicdjobs](https://user-images.githubusercontent.com/9282421/188209235-baee3dae-944c-4bce-9530-7abd98fe5f91.png)

### Final pull and push to update both local and github repo
####
![final-pull](https://user-images.githubusercontent.com/9282421/188456672-6e9acf02-37d9-42f0-91ed-b91c0c11c111.png)
![uptodate](https://user-images.githubusercontent.com/9282421/188456687-fb81406c-99a9-4e3e-80b0-d9b7ad020f41.png)


# Improvements
#### 
Future enhancement of this app include:
* Designing a good user interface for this app

# Demo Video
####
### The demo vidoe for this app can be found [here](https://youtu.be/9T4JRTRwnU0)

### Status
[![Python application test with Github Actions](https://github.com/Ifegwu/flask-ml-CICD-pipeline/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/Ifegwu/flask-ml-CICD-pipeline/actions/workflows/main.yml)

