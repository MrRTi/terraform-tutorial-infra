terraform {
  required_version = ">= 0.12.2"

  backend "s3" {
    region         = "us-east-1"
    bucket         = "infra-study-test-tf-state"
    key            = "terraform.tfstate"
    dynamodb_table = "infra-study-test-tf-state-lock"
    profile        = ""
    role_arn       = ""
    encrypt        = "true"
  }
}
