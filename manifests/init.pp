# == Class: scst
#
# SCST is the generic SCSI target subsystem for Linux.  This module attempts 
# to provide base level management and configuration of SCST and the
# devices create by it.
#
# The base class scst install and configures SCST for adding and managing
# device.
#
# === Parameters
#
#   No parameters on this class
#
# === Variables
#
#   No variable in this class
#
# === Examples
#
#   include scst
#
# === Authors
#
# Derek Harkness <dharknes@mac.com>
#
# === Copyright
#
# Copyright 2013 Derek Harkness, unless otherwise noted.
#
class scst {

    include scst::install
    include scst::config

}
