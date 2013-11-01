# == Define: scst::scst_add_group
#
# iSCST Targets are secured or LUN masked by initiator groups.  This define
# creates an initiator group for a given target.
#
#
# === Parameters
#
# [*target_name*]
#   The target is exported iSCSI device.
#
# === Variables
#
# [*name*]
#   Name is used to provide a unique name for each ini_group
#
# === Examples
#
#   class { 'scst::scst_add_group':
#       target_name => 'webdata',
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

define scst::scst_add_group (
    $target_name    = undef,
    ) {

    
    # Create a security group
    exec { "group_${name}":
        command => "/bin/echo 'create ${name}' > /sys/kernel/scst_tgt/targets/iscsi/${target_name}/ini_groups/mgmt",
        creates => "/sys/kernel/scst_tgt/targets/iscsi/${target_name}/ini_groups/${name}",
    }

}
