terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.23.0"
    }
  }

  backend "s3" {
    bucket               = "iac-for-devops-pipelines-assignment-2-terraform-state"
    key                  = "terraform-state-deploy"
    workspace_key_prefix = "terraform-state-deploy-env"
    region               = "eu-west-1"
    encrypt              = true
    dynamodb_table       = "iac-for-devops-pipelines-assignment-2-terraform-lock"
  }
}

provider "aws" {
  region = "eu-west-1"

  default_tags {
    tags = {
      Environment = terraform.workspace
      Project     = var.project
      contact     = var.contact
      ManageBy    = "Terraform/setup"
    }
  }
}

locals {
  prefix = "${var.prefix}-${terraform.workspace}"
}

data "aws_region" "current" {}
