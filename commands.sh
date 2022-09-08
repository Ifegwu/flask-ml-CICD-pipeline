git clone git@github.com:udacity/nd082-Azure-Cloud-DevOps-Starter-Code.git
cd nd082-Azure-Cloud-DevOps-Starter-Code/C2-AgileDevelopmentwithAzure/project/starter_files/flask-sklearn
make setup
source ~/.myrepo/bin/activate
cd flask-sklearn
make all
az webapp up -n flaskmlapp