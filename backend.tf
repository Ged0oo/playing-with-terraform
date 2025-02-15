terraform {
  backend "s3" {
    bucket         = "testing-bucket-1562001"
    key            = "terraform.tfstate"
    region         = "us-east-1"
  }
}
