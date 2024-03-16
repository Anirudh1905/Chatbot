load("ext://helm_remote", "helm_remote")

helm_remote(
  "nginx-ingress",  # Name for your release
  repo_name="nginx-stable",  # Assuming you want the stable version
  repo_url="https://helm.nginx.com/stable",
  # No additional values file specified here (optional)
)

# Tilt will build the docker image in the root
docker_build("server", ".", dockerfile="Dockerfile-server")
docker_build("streamlit", ".", dockerfile="Dockerfile-frontend")

k8s_yaml("manifests/chatbot.yaml")
k8s_yaml("manifests/streamlit.yaml")

k8s_resource("chatbot", port_forwards=["8000:8000"])
k8s_resource("streamlit", port_forwards=["8501:8501"])