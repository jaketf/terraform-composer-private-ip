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

provider "google" {
  version = "~> 1.20"
}

data "google_client_config" "current" {}

resource "google_compute_subnetwork" "composer-subnet" {
  project                  = "${var.project}"
  name                     = "${var.composer-subnet}"
  ip_cidr_range            = "${var.cidr-range}"
  region                   = "us-central1"
  network                  = "${var.network}"
  private_ip_google_access = "true"
  enable_flow_logs         = "true"
}

data "template_file" "composer-env-config" {
  template = "${file("config/composer_config.json")}"

  vars = {
    name            = "${var.name}"
    project         = "${var.project}"
    region          = "${var.region}"
    zone            = "${var.zone}"
    network         = "${var.network}"
    composer-subnet = "${google_compute_subnetwork.composer-subnet.name}"
    cidr-range      = "${var.cidr-range}"
    machine-type    = "${var.machine-type}"
    node-count      = "${var.node-count}"
    composer-image  = "${var.composer-image}"
    email           = "${var.email}"
  }
}

provider "restapi" {
  uri = "https://composer.googleapis.com/v1beta1/"

  headers = {
    "Authorization" = "Bearer ${data.google_client_config.current.access_token}"
    "Content-Type"  = "application/json"
  }

  id_attribute = "name"
  write_returns_object = true
}

resource "restapi_object" "composer-environment" {
  path = "/projects/${var.project}/locations/${var.region}/environments"
  data = "${data.template_file.composer-env-config.rendered}"
}
