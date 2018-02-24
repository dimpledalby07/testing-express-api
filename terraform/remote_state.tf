terraform {
  backend "s3" {
    bucket   = "expressapi-terraform-state"
    key      = "express-api"
  }
}