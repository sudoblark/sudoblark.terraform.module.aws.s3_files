/*
  All of the S3 files are templated, the difference is without input vars we simply get the content verbatim -
  this allows flexibility, as we can handle both templated and non-templated input with the same resource(s).
*/

locals {
  actual_s3_files = flatten([
    for file in var.raw_s3_files : {
      name : file.name,
      destination_bucket : file.destination_bucket,
      destination_key : file.destination_key,
      content : templatefile("${file.source_folder}/${file.source_file}", try(file.template_input, {}))
      path : "${file.source_folder}/${file.source_file}"
    }
  ])
}

resource "aws_s3_object" "uploaded_files" {
  for_each = { for file in local.actual_s3_files : file.name => file }

  bucket  = each.value["destination_bucket"]
  key     = each.value["destination_key"]
  content = each.value["content"]

  etag = filemd5(each.value["path"])
}