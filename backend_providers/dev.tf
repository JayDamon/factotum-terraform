bucket         = "terraform-state-factotum"
key            = "jaydamon/development/terraform.tfstate"
dynamodb_table = "terraform-state-locking"
encrypt        = true

region = "us-east-1"