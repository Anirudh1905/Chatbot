resource "aws_ecr_repository" "ecr" {
  name = "chatbot-repo"

  image_scanning_configuration {
    scan_on_push = true
  }
}