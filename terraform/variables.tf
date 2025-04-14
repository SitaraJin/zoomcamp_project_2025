variable "credentials" {
  description = "My Credentials"
  default     = "/key.json"
}

variable "project" {
  description = "Project"
  default     = "zoomcamp-project-456515"
}

variable "region" {
  description = "Region"
  default     = "asia-east2"
}

variable "location" {
  description = "Project Location"
  default     = "asia-east2"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  default     = "zoomcamp-project-456515"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default     = "zoomcamp_project"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}
