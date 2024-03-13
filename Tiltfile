load("ext://helm_remote", "helm_remote")

# Tilt will build the docker image in the root
docker_build("chatbot", ".", dockerfile="Dockerfile-server")
docker_build("streamlit", ".", dockerfile="Dockerfile-frontend")

k8s_yaml("manifests/chatbot.yaml")
k8s_yaml("manifests/streamlit.yaml")

k8s_resource("chatbot", port_forwards=["8000:8000"])
k8s_resource("streamlit", port_forwards=["8501:8501"])