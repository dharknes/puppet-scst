# == Class: scst::service
#
# Start the scst service
#
# === Parameters
#
# [*ensure*]
#   Provides a switch to enable or disable the scst daemon
#
# === Variables
#
#   None
#
# === Examples
#
#  class { scst::service:
#       ensure  => present,
#  }
#
# === Authors
#
# Derek Harkness <dharknes@mac.com>
#
# === Copyright
#
# Copyright 2013 Derek Harkness, unless otherwise noted.
#
class scst::service(
    $ensure = present,
) {

    service { 'scst':
        ensure      => $ensure,
        name        => 'scst',
        enable      => true,
        hasstatus   => true,
        hasrestart  => true,
        pattern     => 'scst',
        require     => Class['scst::install'],
    }

}
