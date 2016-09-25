samba
=====

Samba sharing container - shares one or more volumes over Samba.

Configuration
-------------

Set the NetBIOS name, workgroup, and shares using environment variables::

    name: mewtwo
    workgroup: WORKGROUP
    share0: Disk1|/media/Disk1
    share0: OtherName|/media/Disk2

Make sure to mount any volumes you share. You also need to share these ports::

    - "137:137"
    - "138:138"
    - "139:139"
    - "445:445"
