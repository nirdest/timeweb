terraform {
  required_providers {
    twc = {
      source = "tf.timeweb.cloud/timeweb-cloud/timeweb-cloud"
    }
  }
  required_version = ">= 0.13"
}

#provider "twc" {
#  token =  ${{ secrets.TIMEWEB_TOKEN }}
#}

data "twc_configurator" "configurator" {
  location = "kz-1"
}

data "twc_os" "os" {
  name    = "ubuntu"
  version = "22.04"
}

data "twc_ssh_keys" "ssh-key" {
  name = "macbook"
}

data "twc_projects" "project" {
  name = "terraform"
}

resource "twc_server" "my-timeweb-server" {
  name         = "GitLab"
  os_id        = data.twc_os.os.id
  ssh_keys_ids = [data.twc_ssh_keys.ssh-key.id]
  project_id   = data.twc_projects.project.id

  configuration {
    configurator_id = data.twc_configurator.configurator.id
    disk            = 1024 * 50
    cpu             = 2
    ram             = 1024 * 4
  }
}
