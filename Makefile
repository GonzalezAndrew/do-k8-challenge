.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

env: ## Set Environment Variables
	@. env.sh

init: env ## Initializes the terraform remote state backend and pulls the correct projects state.
	@terraform -chdir=./terraform init

update: ## Gets any module updates
	@terraform -chdir=./terraform get -update=true &>/dev/null

plan: init update ## Runs a plan. 
	@terraform -chdir=./terraform plan

show: init ## Shows a module
	@terraform -chdir=./terraform show -module-depth=-1

apply: init update ## Run a apply.
	@terraform -chdir=./terraform apply

output: update ## Show outputs of a module or the entire state.
	@if [ -z $(MODULE) ]; then terraform -chdir=./terraform output ; else terraform output -module=$(MODULE) ; fi

destroy: init update ## Destroys targets
	@terraform -chdir=./terraform destroy
