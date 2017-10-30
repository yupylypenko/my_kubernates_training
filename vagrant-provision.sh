## add kevin
useradd -m -s /bin/bash -U ansible -u 666 --groups wheel
cp -pr /home/vagrant/.ssh /home/ansible/
chown -R ansible:ansible /home/ansible
echo "%kevin ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ansible
