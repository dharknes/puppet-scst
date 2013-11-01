scst
====

####Table of Contents

1. [Overview - What is the SCST module?](#overview)
2. [Module Description - What does the module do?](#module-description)
3. [Setup - The basics of getting started with SCST module](#setup)
4. [Upgrading - Guide for upgrading from older revisions of the module](#upgrading)
5. [Usage - The class and parameters available for configuration](#usage)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Development](#development)
8. [Release Notes](#release-notes)

Overview
--------
This module is intended to provide basic control and configuration of the the SCST generic SCSI subsystem.  It currently provides basic functions for managing iSCSI targets.

Module Description
------------------
The SCST module makes installing and managing simple and straight forward.  The goal is remove as much complexity from the mange of SCST as possible while maintaining as much of SCST's power and flexibility.

Setup
-----


Upgrading
---------

Usage
-----
SCST is a fairly complete software package but I've tried to keep this module as simple as possible.  Usage is very straight forward.

    include scst

    scst::scst_add_target { "webdata_target": 
        initiator_name      => $initiator_name,
        initiator_address   => $::ipaddress,
        lun_size            => $storage_volume_size,
    }

This should be enought to get SCST up and running.

Limitations
------------
Compatible with:

    Puppet Version: 2.7+

Platforms:
* Centos | RHEL 5 + 6

Development
------------
In the not to distant future I am planning on adding Ubuntu support, cleaning up the defined type, and expanding the support SCST options.  My environment is iSCSI heavy so that's where most of my development will be.
