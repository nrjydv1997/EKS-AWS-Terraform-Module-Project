terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.7.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = var.region
}

/*
backend "s3" {
  bucket       = "<bucket-name>"
  region       = var.region
  key          = "terraform.tfstate"
  use_lockfile = true
  encrypt      = true
}
*/