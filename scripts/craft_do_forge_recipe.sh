#!/bin/bash

# Craft CMS Server Setup 
#
# Forge Bash Script Recipe for CraftCMS websites on Digital Ocean
#
# @author    webrgp
# @link      https://github.com/webrgp
# @package   craft-do-forge-recipe
# @since     1.0.0
# @license   MIT

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

# Install Digital Ocean Monitoring tools
install_do_monitoring_tools () {
  curl -sSL https://agent.digitalocean.com/install.sh | sh
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

  patch_mysql

  install_do_monitoring_tools

  success_msg "CraftCMS setup on Forge completed!"
}

info_msg "Installing CraftCMS setup on Forge"

perform_craftcms_server_setup