terraform {
  backend "s3" {
    bucket = "eks-helm9"
    key    = "terraform.tfstate"
    region = "us-east-1"
    # namodb_table = "lock"
  }  
}