# aws-string_replacer_api

This repo includes code to create a simple string replacer and its Infrastructure code to deploy it as a Lambda Function using a Docker image

Project consists of 2 folders:

**1. app**

Includes Python code and Dockerfile to build the Docker image that will be used in Lambda function

**2. infrastructure**

This Terraform configuration creates an AWS ECR repository, builds and pushes a Docker image to the repository, and then deploys an AWS Lambda function using the Docker image from the ECR repository.

Resources Created

**1. AWS ECR Repository:**

- A new Elastic Container Registry (ECR) repository is created with the name provided in the var.stack variable.
- The repository has image scanning disabled (scan_on_push = false).

**2. Docker Build and Push:**

- A null_resource is used to run local commands that:
  - Log in to the ECR repository.
  - Build a Docker image from the ../app directory
  - Push the image to the ECR repository with the latest tag.

**3. AWS Lambda Function:**

- An AWS Lambda function is created using the Docker image fetched from the ECR repository.
- The Lambda function uses the name provided in var.function_name.
- Lambda function URL is enabled, and the function is deployed using the container image.

_Usage_

1. Ensure that your AWS credentials are set up and authenticated.
2. Run terraform init to initialize the Terraform project.
3. Run terraform apply to create the resources.
4. A Lambda function with a URL will be deployed using the Docker image from ECR.
5. Terraform will output the Lambda function's URL at the end

**Example request**

Lambda function will accept input as a GET parameter and will output the result as a JSON object

```
curl "<HOSTNAME>/?input=We really like the new security features of Google"
```

Output:

```
{
"replaced_text": "We really like the new security features of Google©",
"original_text": "We really like the new security features of Google"
}
```
