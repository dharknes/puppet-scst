# == Define: scst::scst_add_target
#
# Creates an LV in volume_group then add the target to the iSCSI-SCST subsystem 
#
# === Parameters
#
# [*lun_size*]
# [*initiator_address*]
# [*initiator_name*]
#
# === Variables
#
# [*target_name*]
#
# === Examples
#
#   scst::scst_add_target { "${::hostname}-1": 
#       initiator_name      => $initiator_name,
#       initiator_address   => $::ipaddress,
#       lun_size            => $storage_volume_size,
#       tag                 => $storage_brick_name,
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
define scst::scst_add_target (
    $initiator_address,
    $initiator_name,
    $lun_size           = '1T',
    $volume_group       = 'Data',
    ) {

    $target_name = "iqn.2013-05.edu.merit:${name}"

    if size($name) > 16 {
        $device_name = delete($name, 'scgw-')

        if size($device_name) > 16 {
            fail("${device_name} to long")
        }

    } else {
        $device_name = $name
    }

    logical_volume { $name:
        ensure          => present,
        volume_group    => $volume_group,
        size            => $lun_size,
        notify          => Exec["resync_size-$target_name"],
    }

    scst::scst_add_device { $device_name:
        volume_name     => $name,
        require         => [ Exec[$target_name], Logical_volume[$name] ],
        notify          => Class['scst::config'],
    }

    scst::scst_add_group { $name: 
        target_name     => $target_name,
        require         => [ Exec[$target_name] ],
        notify          => Class['scst::config'],
    }

    scst::scst_map_lun { $name:
        target_name     => $target_name,
        device_name     => $device_name,
        group_name      => $name,
        require         => [ Exec[$target_name], Scst::Scst_add_device[$device_name], Scst::Scst_add_group[$name] ],
        notify          => Class['scst::config'],
    }

    scst::scst_add_initiator { $name:
        target_name     => $target_name,
        group_name      => $name,
        initiator_name  => $initiator_name,
        require         => [ Exec[$target_name], Scst::Scst_add_group[$name] ],
        notify          => Class['scst::config'],
    }

    # Create Target
    exec { $target_name:
        command         => "/bin/echo 'add_target ${target_name}' > /sys/kernel/scst_tgt/targets/iscsi/mgmt",
        creates         => "/sys/kernel/scst_tgt/targets/iscsi/${target_name}",
    }

    exec { "enable-$target_name":
        command         => "/bin/echo 1 > /sys/kernel/scst_tgt/targets/iscsi/${target_name}/enabled",
        onlyif          => "/usr/bin/test `cat /sys/kernel/scst_tgt/targets/iscsi/${target_name}/enabled` -ne 1",
        require         => [ Exec[$target_name], Scst::Scst_add_device[$device_name], Scst::Scst_add_group[$name], Scst::Scst_add_initiator[$name] ],
    }

    exec { "resync_size-$target_name":
        command         => "/bin/echo 1 > /sys/kernel/scst_tgt/targets/iscsi/${target_name}/ini_groups/${name}/luns/0/device/resync_size",
        refreshonly     => true,
        require         => [ Exec[$target_name], Scst::Scst_add_device[$device_name], Scst::Scst_add_group[$name], Scst::Scst_add_initiator[$name] ],
    }

    firewall { "3260001 Allow ${name}":
        chain       => 'ISCSI',
        source      => $initiator_address,
        action      => 'accept',
    }
}
