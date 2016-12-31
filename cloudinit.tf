provider "cloudinit" {}

data "template_file" "init-script" {
  template = "${file("templates/init.cfg")}"
  vars {
    userdata_index = "${base64encode(file("${path.module}/files/index.html"))}"
    frontent_nginx_conf = "${base64encode(file("${path.module}/files/frontent.conf"))}"
    backend_nginx_conf = "${base64encode(file("${path.module}/files/backend.conf"))}"
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
