#!/bin/bash
apt update
apt install ansible -y

cat << 'EOF' > /home/ubuntu/playbook.yml
---
- name: Install apache sever and change default port
  hosts: localhost
  become: true

  tasks:

    - name: install apache Server
      apt:
        name: apache2
        state: present

    - name: change web server default port to 8080
      lineinfile:
        path: /etc/apache2/ports.conf 
        regexp: '^Listen 80$'
        line: 'Listen 8080'

    - name: restart apache server
      service:
        name: apache2
        state: restarted
EOF

ansible-playbook /home/ubuntu/playbook.yml

#apt install apache2 -y
#echo "Hello from - $(hostname)" > /var/www/html/index.html