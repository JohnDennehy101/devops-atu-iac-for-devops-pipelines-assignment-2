variable "project" {
  description = "Project name"
  default     = "iac-for-devops-pipelines-assignment-2"
}

variable "tf_state_bucket" {
  description = "S3 bucket name in AWS for storing Terraform state"
  default     = "iac-for-devops-pipelines-assignment-2-terraform-state"
}

variable "tf_state_lock_table" {
  description = "Dynamo DB table name for Terraform state locking"
  default     = "iac-for-devops-pipelines-assignment-2-terraform-lock"
}

variable "contact" {
  description = "Contact email for created resources (useful if team environment)"
  default     = "L00196611@atu.ie"
}
