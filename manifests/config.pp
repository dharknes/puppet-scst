# == Class: scst::config
#
#  Class to perform initial configuration of scst
#
# === Parameters
#
#   No parameters
#
# === Variables
#
#   No variables
#
# === Examples
#
#   include scst::config
#
# === Authors
#
# Derek Harkness <dharkens@mac.com>
#
# === Copyright
#
# Copyright 2013 Derek Harkness, unless otherwise noted.
#
class scst::config {

    exec { 'save_config':
        command     => '/usr/local/sbin/scstadmin -write_config /etc/scst.conf',
        refreshonly => true,
    }

}
