# == Class: scst::install
#
#   This class downloads, compiles, and installs the SCST system.
#
# === Parameters
#
#   No parameters on this class
#
# === Variables
#
#   No variables on this class
#
# === Examples
#
#   include scst::install
#
# === Authors
#
# Derek Harkness <dharknes@mac.com>
#
# === Copyright
#
# Copyright 2013 Derek Harkness, unless otherwise noted.
#
class scst::install {

    package { ['subversion', 'make', 'gcc', 'perl-ExtUtils-MakeMaker']:
        ensure  => present,
    }
    
    file { '/root/src':
        ensure  => directory,
    }

# Add an onlyif check for /sys/kernel/scst
#  If that exists I'm not sure we need to redownload etc.
    exec { 'svn_co_scst':
        command     => '/usr/bin/svn co https://scst.svn.sourceforge.net/svnroot/scst/trunk scst',
        cwd         => '/root/src/',
        creates     => '/root/src/scst',
        require     => Package['subversion'],
    }

# This is needed if you're running an older centos kernel
    exec { 'rpm_kernel_source':
        command     => "/bin/rpm -i http://vault.centos.org/${::operatingsystemrelease}/updates/${::architecture}/Packages/kernel-devel-${::kernelrelease}.rpm",
        creates     => "/usr/src/kernels/${::kernelrelease}",
    }

    exec { 'build_scst':
        command     => '/usr/bin/make scst scst_install iscsi iscsi_install scstadm scstadm_install',
        cwd         => '/root/src/scst',
        creates     => '/usr/local/sbin/scstadmin',
        require     => [Exec['svn_co_scst'], Exec['rpm_kernel_source'], Package['perl-ExtUtils-MakeMaker'] ],
    }

}
