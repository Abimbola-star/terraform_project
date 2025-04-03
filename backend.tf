terraform {
  backend "s3" {
    bucket = "qq-wk7-terraformdockerproj"
    key    = "docker/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
  }
}

