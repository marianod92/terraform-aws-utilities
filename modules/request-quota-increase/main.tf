terraform {
  # This module is now only being tested with Terraform 1.1.x. However, to make upgrading easier, we are setting 1.0.0 as the minimum version.
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "< 4.0"
    }
  }
}

resource "aws_servicequotas_service_quota" "increase_quotas" {
  for_each = var.resources_to_increase

  quota_code   = local.codes[each.key].quota_code
  service_code = local.codes[each.key].service_code
  value        = each.value
}

locals {
  # PRs to add more of these mappings are very welcome. For more information
  # on how to find the Service Code and Quota Code, see the README.md!
  codes = {
    nacl_rules = {
      quota_code   = "L-2AEEBF1A"
      service_code = "vpc"
    },
    nat_gateway = {
      quota_code   = "L-FE5A380F"
      service_code = "vpc"
    }
  }
}
