# Input variable definitions
variable "environment" {
  description = "Which environment this is being instantiated in."
  type        = string
  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Must be either dev, test or prod"
  }
}

variable "application_name" {
  description = "Name of the application utilising resource."
  type        = string
}

variable "raw_s3_files" {
  description = <<EOT

Data structure
---------------
A list of dictionaries, where each dictionary has the following attributes:

REQUIRED
---------
- name:                 : Friendly name used through Terraform for instantiation and cross-referencing of resources,
                          only relates to resource naming within the module.
- source_folder         : Which folder where the {source_file} lives.
- source_file           : The path under {source_folder} corresponding to the file to upload.
- destination_key       : Key in S3 bucket to upload to.
- destination_bucket    : The S3 bucket to upload the {source_file} to.

OPTIONAL
---------
- template_input        : A dictionary of variable input for the template file needed for instantiation (leave blank if no template required)
EOT
  type = list(
    object({
      name               = string,
      source_folder      = string,
      source_file        = string,
      destination_key    = string,
      destination_bucket = string,
      template_input     = optional(map(string), {})
    })
  )
}