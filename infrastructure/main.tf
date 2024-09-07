resource "aws_ecr_repository" "fugro" {
  name = var.stack

  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "null_resource" "docker_build_and_push" {
  triggers = {
    file_hash = md5(file("${path.module}/../app/lambda_function.py"))
  }
  provisioner "local-exec" {
    command = <<EOT
      cleaned_repository_url=$(echo ${aws_ecr_repository.fugro.repository_url} | sed 's/\/fugro$//')
      aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin $cleaned_repository_url
      docker build --platform linux/amd64 -t ${aws_ecr_repository.fugro.repository_url}:latest ../app
      docker push ${aws_ecr_repository.fugro.repository_url}:latest
    EOT
  }

  depends_on = [aws_ecr_repository.fugro]
}

module "lambda_function_container_image" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = var.function_name
  description   = "Fugro Lambda function"

  create_package             = false
  create_lambda_function_url = true

  image_uri    = "${aws_ecr_repository.fugro.repository_url}:latest"
  package_type = "Image"

  depends_on = [null_resource.docker_build_and_push]
}