# sudoblark.terraform.module.aws.s3_files
Terraform module to upload N number of (optionally templated) local files to S3 with distinct keys. - repo managed by sudoblark.terraform.github

## Developer documentation
The below documentation is intended to assist a developer with interacting with the Terraform module in order to add,
remove or update functionality.

### Pre-requisites
* terraform_docs

```sh
brew install terraform_docs
```

* tfenv
```sh
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bash_profile
```

* Virtual environment with pre-commit installed

```sh
python3 -m venv venv
source venv/bin/activate
pip install pre-commit
```
### Pre-commit hooks
This repository utilises pre-commit in order to ensure a base level of quality on every commit. The hooks
may be installed as follows:

```sh
source venv/bin/activate
pip install pre-commit
pre-commit install
pre-commit run --all-files
```

# Module documentation
The below documentation is intended to assist users in utilising the module, the main thing to note is the
[data structure](#data-structure) section which outlines the interface by which users are expected to interact with
the module itself, and the [examples](#examples) section which has examples of how to utilise the module.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.61.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.67.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_object.uploaded_files](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | Name of the application utilising resource. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Which environment this is being instantiated in. | `string` | n/a | yes |
| <a name="input_raw_s3_files"></a> [raw\_s3\_files](#input\_raw\_s3\_files) | Data structure<br>---------------<br>A list of dictionaries, where each dictionary has the following attributes:<br><br>REQUIRED<br>---------<br>- name:                 : Friendly name used through Terraform for instantiation and cross-referencing of resources,<br>                          only relates to resource naming within the module.<br>- source\_folder         : Which folder where the {source\_file} lives.<br>- source\_file           : The path under {source\_folder} corresponding to the file to upload.<br>- destination\_key       : Key in S3 bucket to upload to.<br>- destination\_bucket    : The S3 bucket to upload the {source\_file} to.<br><br>OPTIONAL<br>---------<br>- template\_input        : A dictionary of variable input for the template file needed for instantiation (leave blank if no template required) | <pre>list(<br>    object({<br>      name               = string,<br>      source_folder      = string,<br>      source_file        = string,<br>      destination_key    = string,<br>      destination_bucket = string,<br>      template_input     = optional(map(string), {})<br>    })<br>  )</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Data structure
```
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
```
## Examples
See `examples` folder for an example setup.
