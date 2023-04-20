## Configure mypc with aws account
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
