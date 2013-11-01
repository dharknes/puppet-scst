# Define
# Add docs!
define scst::scst_add_initiator (
    $target_name    = undef,
    $group_name     = undef,
    $initiator_name = undef,
    ) {

    # Adds initiator to the target security group
    exec { $initiator_name:
        command         => "/bin/echo 'add ${initiator_name}' > /sys/kernel/scst_tgt/targets/iscsi/${target_name}/ini_groups/${group_name}/initiators/mgmt",
        creates         => "/sys/kernel/scst_tgt/targets/iscsi/${target_name}/ini_groups/${group_name}/initiators/${initiator_name}",
    }
}
