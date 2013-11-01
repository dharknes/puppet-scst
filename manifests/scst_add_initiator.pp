# == Define: scst::scst_add_initiator
#
# This define adds an initiator (iSCSI client) to the target security
# group (ini_group).
#
# === Parameters
#
# Document parameters here.
#
# [*target_name*]
#   Name of the iSCSI target to which we add the initiator
#
# [*group_name*]
#   Which ini_group should we add the initiator to
#
# [*initiator_name*]
#   Name of the initiator
#
# === Variables
#
#   None
#
# === Examples
#
#   scst::scst_add_initiator { 'webdata':
#       target_name     => 'webdata',
#       group_name      => 'allow_webdata',
#       initiator_name  => 'InitiatorName=iqn.1994-05.com.redhat:c12916ea6761',
#   }
#
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
