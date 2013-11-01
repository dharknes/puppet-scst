class scst::config {

    exec { 'save_config':
        command     => '/usr/local/sbin/scstadmin -write_config /etc/scst.conf',
        refreshonly => true,
    }

}
