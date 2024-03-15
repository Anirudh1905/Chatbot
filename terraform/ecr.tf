resource "aws_ecr_repository" "ecr_server" {
  name = "chatbot-repo/server"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "ecr_streamlit" {
  name = "chatbot-repo/streamlit"

  image_scanning_configuration {
    scan_on_push = true
  }
}