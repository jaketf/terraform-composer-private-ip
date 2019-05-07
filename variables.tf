# Copyright 2019 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

variable "project" {
  description = "Project ID for your Composer Environment"
}

variable "region" {
  description = "Region for your composer environment"
  default     = "us-central1"
}

variable "zone" {
  description = "Zone for your composer environment"
  default     = "us-central1-f"
}

variable "network" {
  description = "The network you Composer Environment should use"
}

variable "composer-subnet" {
  description = "Name for composer subnetwork to create"
  default     = "composer-subnet"
}

variable "name" {
  description = "Composer Environment name"
  default     = "pbm-composer"
}

variable "composer-image" {
  description = "Composer image version."
  default     = "composer-1.6.0-airflow-1.10.1"
}

variable "node-count" {
  description = "Number of nodes for the Composer GKE cluster."
  default     = 3
}

variable "machine-type" {
  description = "Machine type for the Composer GKE nodes."
  default     = "n1-standard-8"
}

variable "email" {
  description = "Email to send mail to on SLA misses."
}

variable "cidr-range" {
  description = "CIDR range for your subnet."
  default     = "10.180.0.0/20"
}
