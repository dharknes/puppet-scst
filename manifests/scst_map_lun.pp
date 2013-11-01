# == Define: scst::scst_map_lun
#
#
# === Parameters
#
# [*lun_number*]
# [*target_name*]
# [*device_name*]
# [*group_name*]
#
# === Variables
#
# None
#
# === Examples
#
#   scst::scst_map_lun { 'webdata_lun_0':
#       target_name     => iqn.2013-05.com.example:webdata},
#       device_name     => 'webdata_fast_disk',
#       group_name      => 'webdata_allow',
#   }
#
#
# === Authors
#
# Derek Harkness <dharknes@mac.com>
#
# === Copyright
#
# Copyright 2013 Derek Harkness, unless otherwise noted.
#
define scst::scst_map_lun (
    $lun_number     = 0,
    $target_name    = undef,
    $device_name    = undef, 
    $group_name     = undef,
    ) {

    # Map Device to Target (Create LUN)
    exec { "lun_${name}":
        command => "/bin/echo 'add ${device_name} ${lun_number}' > /sys/kernel/scst_tgt/targets/iscsi/${target_name}/ini_groups/${group_name}/luns/mgmt",
        creates => "/sys/kernel/scst_tgt/targets/iscsi/${target_name}/ini_groups/${group_name}/luns/${lun_number}",
    }

}
