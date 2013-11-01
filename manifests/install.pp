# == Class: scst
#
# Full description of class scst here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { scst:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
class scst::install {

    package { ['subversion', 'make', 'gcc', 'perl-ExtUtils-MakeMaker']:
        ensure  => present,
    }
    
    file { '/root/src':
        ensure  => directory,
    }

    exec { 'svn_co_scst':
        command     => '/usr/bin/svn co https://scst.svn.sourceforge.net/svnroot/scst/trunk scst',
        cwd         => '/root/src/',
        creates     => '/root/src/scst',
        require     => Package['subversion'],
    }

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
