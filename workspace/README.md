# What's my current workspace?

You can use the `terraform.workspace` variable to find your current workspace.

You can then use this as part of other terraform code, to conditionally do things differently depending on the workspace.

For example, you could have a `local` defined as such:

```
locals {
  environment_config = {
    "dev" = {
      concurrency = 5
    }
    "prod" = {
      concurrency = 10
    }
  }

}
```

And then pick the relevant variable based on the current workspace:

```
locals {
  concurrency = local.environment_config[terraform.workspace].concurrency
}

resource foo "foo" {
  concurrency = local.concurrency
}
```

## Locally

Locally, with no workspaces set:

```
$ terraform apply

Changes to Outputs:
  + hello = "hello world from the default workspace"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes


Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

hello = "hello world from the default workspace"
```

If we create a workspace:

```
$ terraform workspace new foo
Created and switched to workspace "foo"!

You're now on a new, empty workspace. Workspaces isolate their state,
so if you run "terraform plan" Terraform will not see any existing state
for this configuration.


$ terraform apply

Changes to Outputs:
  + hello = "hello world from the foo workspace"

You can apply this plan to save these new output values to the Terraform state, without changing any real
infrastructure.

Do you want to perform these actions in workspace "foo"?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes


Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

hello = "hello world from the foo workspace"
```


## Terraform Cloud

Running in Terraform Cloud, in a workspace named `terraform-hello-world`, in remote execution mode

Outputs:

* `hello: "hello world from the terraform-hello-world workspace"`



When running on an agent pool, in a workspace named `terraform-hello-agent`

Outputs:

* `hello: "hello world from the terraform-hello-agent workspace"`

Agent logs for the plan and apply

```
2022-01-19T15:58:29.477Z [INFO]  core: Job received: job.type=plan job.id=run-Y7jbLBsmisYiBLaz
2022-01-19T15:58:29.477Z [INFO]  terraform: Handling run: run.id=run-Y7jbLBsmisYiBLaz run.operation=plan organization.name=fancycorp workspace.name=terraform-hello-agent
2022-01-19T15:58:29.536Z [INFO]  terraform: Extracting Terraform from release archive
2022-01-19T15:58:30.026Z [INFO]  terraform: Terraform CLI details: version=1.1.3
2022-01-19T15:58:30.026Z [INFO]  terraform: Downloading Terraform configuration
2022-01-19T15:58:30.137Z [INFO]  terraform: Running terraform init
2022-01-19T15:58:33.184Z [INFO]  terraform: Running terraform plan
2022-01-19T15:58:38.612Z [INFO]  terraform: Generating and uploading plan JSON
2022-01-19T15:58:42.825Z [INFO]  terraform: Generating and uploading provider schemas JSON
2022-01-19T15:58:47.873Z [INFO]  terraform: Persisting filesystem to remote storage
2022-01-19T15:58:48.390Z [INFO]  terraform: Finished handling run
2022-01-19T15:58:51.389Z [INFO]  core: Waiting for next job
2022-01-19T15:59:12.209Z [INFO]  core: Job received: job.type=apply job.id=run-Y7jbLBsmisYiBLaz
2022-01-19T15:59:12.209Z [INFO]  terraform: Handling run: run.id=run-Y7jbLBsmisYiBLaz run.operation=apply organization.name=fancycorp workspace.name=terraform-hello-agent
2022-01-19T15:59:12.262Z [INFO]  terraform: Extracting Terraform from release archive
2022-01-19T15:59:12.773Z [INFO]  terraform: Terraform CLI details: version=1.1.3
2022-01-19T15:59:12.773Z [INFO]  terraform: Restoring filesystem from remote storage
2022-01-19T15:59:12.925Z [INFO]  terraform: Running terraform init
2022-01-19T15:59:25.765Z [INFO]  terraform: Running terraform apply
2022-01-19T15:59:30.461Z [INFO]  terraform: Finished handling run
2022-01-19T15:59:32.511Z [INFO]  core: Waiting for next job
```
