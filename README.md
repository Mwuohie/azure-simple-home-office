# Azure Simple Home Office (Terraform)

A small Azure environment built with Terraform and split into reusable modules: a resource group, a virtual network and subnet, two network interfaces, and one Windows and one Linux virtual machine.

## What it deploys

| Resource | Details |
|---|---|
| Resource group | `home-office-rg` in `australiaeast` |
| Virtual network | `10.0.0.0/16` |
| Subnet | `10.0.1.0/24` |
| Network interfaces | Two, created with `count` and returned as a list output |
| Windows VM | Windows Server 2019 Datacenter, `Standard_B1s` |
| Linux VM | Ubuntu, `Standard_B1s`, password authentication |

## Structure

```
main.tf                  root module: provider, resource group, module calls
variables.tf             root variables (admin_password)
modules/
  networking/            VNet, subnet, NICs, outputs
  compute/               Windows and Linux VMs
```

The networking module outputs the NIC IDs, and the compute module consumes them. This keeps the dependency explicit in the root module.

## Usage

Requires Terraform and the Azure CLI, signed in with `az login`.

```
terraform init
terraform plan -var "admin_password=<strong password>"
terraform apply -var "admin_password=<strong password>"
terraform destroy -var "admin_password=<strong password>"
```

The password can also be supplied through the `TF_VAR_admin_password` environment variable. It is declared `sensitive` and is never stored in the repository.

## Design notes and limitations

- Lab scope. The VMs have no public IP address and no network security group yet.
- Password authentication is used for simplicity. A production build would use SSH keys for Linux and a secrets store for credentials.
- Local state is used and excluded through `.gitignore`. A shared build would use a remote backend such as Azure Storage.
- The Linux image reference (Ubuntu 18.04) is an older release and should be updated to a current LTS image.

## Next steps

- Add a network security group and associate it with the subnet.
- Move state to a remote backend.
- Replace password authentication with SSH keys.
