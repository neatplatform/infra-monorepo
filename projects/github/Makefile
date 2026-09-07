remote.tfbackend:
	@ echo 'token = ""' > remote.tfbackend;

terraform.tfvars:
	@ echo 'github_token = ""' > terraform.tfvars;

.PHONY: init
init:
	terraform init -backend-config=remote.tfbackend

.PHONY: clean
clean:
	@ rm -rf .terraform terraform.tfstate terraform.tfstate.backup
