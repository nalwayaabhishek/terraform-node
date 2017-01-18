provider "cloudinit" {}

data "template_file" "init_script" {
  template = "${file("templates/init.cfg")}"

  vars {
    frontend_tmp_index      = "${base64encode(file("${path.module}/files/index.html"))}"
    nginx_conf              = "${base64encode(file("${path.module}/files/nginx.conf"))}"
    backend_tmp_app         = "${base64encode(file("${path.module}/files/backend/app.js"))}"
    backend_tmp_app_package = "${base64encode(file("${path.module}/files/backend/package.json"))}"
    pm2_conf                = "${base64encode(file("${path.module}/templates/processes.tpl"))}"
    ebs_mount               = "${base64encode(file("${path.module}/files/mount.sh"))}"
    region                  = "${var.region}"
  }
}

data "template_cloudinit_config" "node_bootstrap" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = "${data.template_file.init_script.rendered}"
  }
}
