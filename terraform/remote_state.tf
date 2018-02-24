terraform {
  backend "s3" {
    bucket   = "testing-terraform-state"
    key      = "express-api"
    region   = "eu-west-2"
  }
}