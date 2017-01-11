provider "cloudinit" {}

data "template_file" "init-script" {
  template = "${file("templates/init.cfg")}"
  vars {
    userdata_index = "${base64encode(file("${path.module}/files/index.html"))}"
    nginx_conf = "${base64encode(file("${path.module}/files/nginx.conf"))}"
    backend_tmp_app = "${base64encode(file("${path.module}/files/backend/app.js"))}"
    backend_tmp_app_package = "${base64encode(file("${path.module}/files/backend/package.json"))}"
    pm2_conf = "${base64encode(file("${path.module}/templates/processes.tpl"))}"
    mount = "${base64encode(file("${path.module}/files/mount.sh"))}"
    AWS_REGION = "${var.AWS_REGION}"
  }
}

data "template_cloudinit_config" "cloudinit-web" {

  gzip = false
  base64_encode = false


   part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = "${data.template_file.init-script.rendered}"
  }
}
