# Define the CodeStar Connection
resource "aws_codestarconnections_connection" "example" {
  name          = "cloudforce"  # Name for your CodeStar connection
  provider_type = "GitHub"            # Provider type for GitHub
  
  }

  


# Define the CodePipeline resource
resource "aws_codepipeline" "codepipeline" {
  name     = "statichosting"
  role_arn = "arn:aws:iam::475233874405:role/service-role/AWSCodePipelineServiceRole-us-east-1-S3Hosting"

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"

  
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"  # Using CodeStar Source Connection
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = "arn:aws:codeconnections:us-east-1:475233874405:connection/9f33c364-9ca7-438a-bd3f-d17530023a5f"  # Reference CodeStar Connection ARN
        FullRepositoryId = "EKechei/terraform-ci-cd-s3-static-website"
        BranchName       = "main"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name             = "Deploy"
      category         = "Deploy"
      owner            = "AWS"
      provider         = "S3"
      version          = "1"
      input_artifacts  = ["source_output"]
      configuration = {
        BucketName = "nyangilika"
        Extract    = "true"
      }
    }
  }
}

# AWS S3 bucket resource
resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "buckettots1"  # Ensure this bucket name is unique globally
}

# S3 bucket public access block resource
resource "aws_s3_bucket_public_access_block" "codepipeline_bucket_pab" {
  bucket = aws_s3_bucket.codepipeline_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
