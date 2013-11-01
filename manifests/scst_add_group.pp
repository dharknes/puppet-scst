define scst::scst_add_group (
    $target_name    = undef,
    ) {

    
    # Create a security group
    exec { "group_${name}":
        command => "/bin/echo 'create ${name}' > /sys/kernel/scst_tgt/targets/iscsi/${target_name}/ini_groups/mgmt",
        creates => "/sys/kernel/scst_tgt/targets/iscsi/${target_name}/ini_groups/${name}",
    }

}
