.PHONY: cluster cluster-down run-service docker-build run-server run-frontend

cluster:
	ctlptl apply -f manifests/cluster.yaml

cluster-down:
	ctlptl delete -f manifests/cluster.yaml

run-service:
	tilt up

docker-build:
	docker build -f Dockerfile

run-server:
	uvicorn src.main:app --reload

run-frontend:
	streamlit run src/frontend.py