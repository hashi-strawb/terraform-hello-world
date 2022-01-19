# Variable Definition Files

Pick a varfile like so:

```
$ terraform apply -var-file test.tfvars

Changes to Outputs:
  ~ hello = "Hello from Dev, World!" -> "Hello from Test World!"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes


Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

hello = "Hello from Test World!"
```


This works fine locally.

In Terraform Cloud, we need to set a variable to make use of varfiles:

https://www.terraform.io/cli/config/environment-variables#tf_cli_args-and-tf_cli_args_name

* Key: TF_CLI_ARGS_plan
	* specifically _plan, as TF_CLI_ARGS would apply to all Terraform commands, not all of which have the relevant flag
* Value: -var-file="dev.tfvars"
	* This results in Terraform being run as, for example:
	* terraform plan -var-file="dev.tfvars"
* Category: env
	* It's specifically an environment variable, rather than a Terraform variable
