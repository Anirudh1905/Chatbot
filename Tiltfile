load("ext://helm_remote", "helm_remote")

# Tilt will build the docker image in the root
docker_build("chatbot", ".", dockerfile="Dockerfile1")
docker_build("streamlit", ".", dockerfile="Dockerfile2")

k8s_yaml("manifests/chatbot.yaml")

k8s_resource("chatbot", port_forwards=["8000:8000", "8501:8501"])