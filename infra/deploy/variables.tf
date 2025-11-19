variable "prefix" {
  description = "Prefix for resources in AWS"
  default     = "iac-2"
}

variable "project" {
  description = "Project name"
  default     = "iac-for-devops-pipelines-assignment-2"
}

variable "contact" {
  description = "Contact email for created resources (useful if team environment)"
  default     = "L00196611@atu.ie"
}

variable "ecr_primary_image" {
  description = "ECR repo path that contains image with static site"
}
