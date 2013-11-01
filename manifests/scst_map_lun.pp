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
