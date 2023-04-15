# DOCUMENTATION FOR DEPLOY APP WITH HELM ON EKS AND ACCESS APP FROM INTERNET:
_______________________________________________________________________________
## (configure mypc with aws account)
* brew install awscli
* cat .aws/credentials
* vim .aws/credentials #then put awsaccount iam user credentials accses and secret keys
* brew install terraform
* brew install helm
* brew install kubectl
* terraform init
* terraform plan 
* terraform apply
## Creating or updating a kubeconfig file for an Amazon EKS cluster (configure mypc with eks cluster)
* aws eks update-kubeconfig --region <region code> --name <cluster name>
* kubectl get svc
## Case1: if helm chart was from locally helm chart code files(my helm module^_^):
 * helm install <ReleaseName> /<helm files dir path> #ex: helm install  sabrinpython  /Users/abougadallas/Downloads/
  eks/myapp

 * kubectl get all
 * or
 * kubectl get pods   
 * kubectl get svc #(to take the end point(external ip for loadbalancer) to release) and hit
 * kubectl get deployments
## Case2: if helm chart was from online repo:
 * helm create <folder name>
 * cd <folder name>
 * helm repo add <reponame>  <  repo url ex: https://baranarda.github.io/python-app-helm/>
 * helm repo list
 * helm install <reponame>/<ReleaseName>
 * helm list
 * kubectl get svc #(to take the end point(external ip for loadbalancer) to release)
 ## after install release if i custumiz our helm files for this installed releas(more than 1releas from 1chart):
   * 1- helm repo update
   * 2- helm install <New ReleaseName> ./<dir name for helm files> 
   * 3-helm list
 * kubectl get all  #check Release(deployment)
 * or
 * kubectl get pods   
 * kubectl get svc #(to take the end point(external ip for loadbalancer) to release) to hit
 * kubectl get deployments
## Case3: if helm chart was from locally dockerfile customised with old locally helm chart code files(my helm module^_^):
* name in chart.yaml file is name of locally dir the helm files
* customise:in values.yaml shuold specify the <dockerhub username ex: sabrin9696>/<image name :ex python-docker> ex:
   * |image:
   * | repository: sabrin9696/python-docker 
   * | pullPolicy: IfNotPresent
   * | # Overrides the image tag whose default is the chart appVersion.
   * | tag: "latest"

 * mkdir <name ex:flask>
 * cd flask
 * vim dockerfile  #then copy the docker file to her
 * cat dockerfile
 * vim app.py  #ex: in app.py write thes then :wq     
 * __________________________________________
  * from flask import Flask                 
  * app = Flask(__name__)                   
                                          
  * @app.route('/')                         
  * def hello_geek():                       
    * return '<h1>Hello from Sabrina</h2>'  
                                             
                                            
  * if __name__ == "__main__":              
    * app.run(debug=True)                   
* __________________________________________
  * vim requirements.txt  #i write the dir name this example is: <flask>
  * docker build --tag <my dockerhub username ex: sabrin9696>/<image name :ex python-docker> .
  * docker images
  * docker run -d -p <loadbalancer port from value.yaml ex: 80>:<containerPort from value.yaml ex: 5000> <image name: python-docker> 
  * docker ps -a
  * docker push <my dockerhub username : sabrin9696>/<image name: python-docker>   #push to dockerhub
  * helm install <ReleaseName> /<helm files dir path> #ex: helm install  sabrinpython  /Users/abougadallas/Downloads/
  eks/myapp

  * kubectl get all
  * or
  * kubectl get pods   
  * kubectl get svc #(to take the end point(external ip for loadbalancer) to release) and hit
  * kubectl get deployments
## done
* ______________________________________________________________________________________________________________
## For any questions feel free to connect with me on: www.linkedin.com/in/sabrin-jadallah


