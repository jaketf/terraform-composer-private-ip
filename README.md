# Private IP Cloud Composer Terraform Module
This module is a wrapper for the REST API call described in 
[these instructions](https://cloud.google.com/composer/docs/how-to/managing/configuring-private-ip)
for configuring a private ip Cloud Composer Environment.

This is meant as an example temporary workaround until the [Cloud Composer Provider](https://www.terraform.io/docs/providers/google/r/composer_environment.html) exposes the option fro private ip.
You can modify to change other [composer_config.json](config/composer_config.json) to add any other Composer configuration options in the [REST API](https://cloud.google.com/composer/docs/reference/rest/v1beta1/projects.locations.environments/create) not exposed  in this example.


## Implementation Notes

### Workaround Design
As private IP Cloud Composer environments are not available through
the terraform provider, this module uses the `restapi` provider to make
an HTTP POST to the [Cloud Composer REST API](https://cloud.google.com/composer/docs/reference/rest/).
You can modify the json pay load in [`composer_config.json`](./config/composer_config.json) to do 
add any of the other configuration parameters exposed by this API.

### Usage
- Create a `terraform.tfvars` file similar to [`terraform.tfvars.example`](./terraform.tfvars.example)
and set the appropriate variables.
- Run `terraform init` to install the appropriate providers.
- `terraform apply`

#### Note on Email
This module also overrides some `smtp` values in the airflow config. 
However, to get emailing working you will need to enable the [SendGrid API](https://console.cloud.google.com/marketplace/details/sendgrid-app/sendgrid-email?filter=solution-type:service&q=sendgrid%20email%20api&id=1943c2ef-912f-4529-af14-ba0bea3c0e96) from the GCP marketplace. Once this is activated you will need to grab thee API key and set the `SENDGRID_API_KEY` environment variable. This can bee edited in the cloud console. You can read more about this in the [configuring SendGrid email service](https://cloud.google.com/composer/docs/how-to/managing/creating#configuring_sendgrid_email_services) section of the docs.
Alternitively, you could set up a third party email service.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cidr-range | CIDR range for your subnet. | string | `"10.10.0.0/21"` | no |
| composer-image | Composer image version. | string | `"composer-1.6.0-airflow-1.10.1"` | no |
| composer-subnet | Name for composer subnetwork to create | string | `"composer-subnet"` | no |
| email | Email to send mail to on SLA misses. | string | n/a | yes |
| machine-type | Machine type for the Composer GKE nodes. | string | `"n1-standard-8"` | no |
| name | Composer Environment name | string | `"pbm-composer"` | no |
| network | The network you Composer Environment should use | string | n/a | yes |
| node-count | Number of nodes for the Composer GKE cluster. | string | `"3"` | no |
| project | Project ID for your Composer Environment | string | n/a | yes |
| region | Region for your composer environment | string | `"us-central1"` | no |
| zone | Zone for your composer environment | string | `"us-central1-f"` | no |
