data "template_file" "user_data_hw" {
  template = <<EOF
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="

--==MYBOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
(DEV=$(lsblk -o +model|grep NVM|awk '{print "/dev/"$1}') && sudo pvcreate $DEV && sudo vgcreate local $DEV && sudo lvcreate -l 100%FREE -n local local && sudo mkfs.xfs /dev/local/local && sudo mkdir -p /srv/local && sudo mount /dev/local/local /srv/local && sudo sysctl -w vm.max_map_count=262144)

--==MYBOUNDARY==--
EOF
}

resource "aws_launch_template" "eks-launch-template" {
  name = "eks-launch-template"
  user_data = "${base64encode(data.template_file.user_data_hw.rendered)}"
}
