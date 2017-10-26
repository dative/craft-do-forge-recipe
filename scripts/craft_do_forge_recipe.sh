#!/bin/bash
##############################################################
#                                                            #
#     Digital Ocean / Forge Recipe for CraftCMS websites     #
#                                                            #
#============================================================#
#                                                            #
#  Assumptions:                                              #
#                                                            #
#  - Ubuntu 16.04 Digital Ocean droplet, created by Forge    #
#  - You are running this recipe as root                     #
#                                                            #
#============================================================#
#                                                            #
#  References & Credits:                                     #
#                                                            #
#  Thanks to Andrew Welch & @nystudio107 folks. This recipe  #
#  rely heavily on their articles.                           #
#                                                            #
##############################################################

# Exit immediately if a simple command exits with a non-zero status (https://ss64.com/bash/set.html) 
set -e

error_msg () {
  echo -e "\e[1;31m*** Error:\e[0m $1"
}

success_msg () {
  echo -e "\e[32m*** $1\e[0m"
}

info_msg () {
  echo -e "\e[34m*** $1\e[0m"
}

print_msg () {
  echo -e ">> $1"
}

# Fix MySql 5.7.5+ issue ( https://craftcms.stackexchange.com/questions/12084/getting-this-sql-error-group-by-incompatible-with-sql-mode-only-full-group-by/12106 )
patch_mysql () {
  info_msg "Start fix for MySql 5.7.5+ issue"

  if grep -q -i '\[mysqld\]' /etc/mysql/my.cnf; then
    success_msg "Server is already patch"
  else
    print_msg "Starting MySql patching"
      cat <<EOT >> /etc/mysql/my.cnf
[mysqld]
sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
EOT
    success_msg "MySql patch is complete!"
  fi
}


perform_craftcms_server_setup () {

  # Check if the user is root
  user="$(id -un 2>/dev/null || true)"
  if [ "$user" != 'root' ]; then

    error_msg 'this installer needs the ability to run commands as root.
We are unable to find either "sudo" or "su" available to make this happen.'
    exit 1
  fi

  success_msg "Woot! User is root :-)"

  # Install Digital Ocean Monitoring tools
  # curl -sSL https://agent.digitalocean.com/install.sh | bash

  patch_mysql

  # # Create a playground directory to be remove at the end
  # mkdir ~/playground
  # cd ~/playground

  # # Maker sure you have tools in place
  # apt-get -y install autoconf automake libtool nasm make pkg-config git

  # # Install jpegoptim & optipng ( https://nystudio107.com/blog/creating-optimized-images-in-craft-cms )
  # apt-get -y install jpegoptim
  # apt-get -y install optipng

  # # Install the nginx partials from https://github.com/nystudio107/nginx-craft

  # git clone https://github.com/nystudio107/nginx-craft.git nginx-craft

  # cp -R nginx-craft/nginx-partials /etc/nginx

  # # Clean up playground
  # cd ~
  # rm -rf ~/playground
}

info_msg "Installing CraftCMS setup on Forge"

perform_craftcms_server_setup