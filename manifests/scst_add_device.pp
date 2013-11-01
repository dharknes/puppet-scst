define scst::scst_add_device (
    $volume_group   = 'MeritStorage',
    $volume_name    = undef, ) {

    # Create device
    exec { "device_${name}":
        command => "/bin/echo 'add_device ${name} filename=/dev/${volume_group}/${name}; nv_cache=1' > /sys/kernel/scst_tgt/handlers/vdisk_blockio/mgmt",
        creates => "/sys/kernel/scst_tgt/devices/${name}",
    }
}
