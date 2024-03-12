.PHONY: lint plan apply

lint:
	terraform validate
	terraform fmt
	tflint

plan: lint
	terraform plan

apply: plan
	terraform apply