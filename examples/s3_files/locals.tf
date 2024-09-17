locals {
  raw_s3_files = [
    {
      name : "plain",
      source_folder : "${path.module}/files/",
      source_file : "plain.json",
      destination_bucket : "asset-bucket",
      destination_key : "plain-file.json"
    },
    {
      name : "templated",
      source_folder : "${path.module}/files/",
      source_file : "templated.json",
      template_input : {
        string_input : "Hello World!",
        number_input : "42",
        list_input : jsonencode([
          "All work and no play makes Jack a dull boy.",
          "All work and no play makes Jack a dull boy.",
          "All work and no play makes Jack a dull boy.",
          "All work and no play makes Jack a dull boy.",
          "All work and no play makes Jack a dull boy."
        ])
      },
      destination_bucket : "asset-bucket",
      destination_key : "templated-file.json"
    }
  ]
}