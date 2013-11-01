# == Define: scst::scst_add_device
#
# This define is used to add a device to the scst subsystem so it can be 
# mapped to a lun and target
#
#
# === Parameters
#
# [*volume_group*]
# There is the assumption that the device are created from LVM.  This is
# name of the volume_group holding the LV.
#
# This assumption will probably change in the future.
#
# [*volume_name*]
# Name of the LV used for the device
#
# === Variables
#
#   No variable in this class
#
# === Examples
#
#   class { 'scst::scst_add_device':
#       volume_group => 'Data',
#       volume_name  => 'WebData',
#   }
#
# === Authors
#
# Derek Harkness <dharknes@mac.com>
#
# === Copyright
#
# Copyright 2013 Derek Harkness, unless otherwise noted.
#
define scst::scst_add_device (
    $volume_group   = 'Data',
    $volume_name    = undef, 
) {

# Volume_group and volume_name are used to construct the path to the phsyical
# device.  This needs to be revisted.
    exec { "device_${name}":
        command => "/bin/echo 'add_device ${name} filename=/dev/${volume_group}/${name}; nv_cache=1' > /sys/kernel/scst_tgt/handlers/vdisk_blockio/mgmt",
        creates => "/sys/kernel/scst_tgt/devices/${name}",
    }
}
