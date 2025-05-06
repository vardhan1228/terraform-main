# Primary region provider
provider "aws" {
  alias  = "primary"
  region = "us-east-1"
}

# Secondary region provider
provider "aws" {
  alias  = "secondary"
  region = "us-west-2"
}
