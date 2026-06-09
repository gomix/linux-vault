On RHEL 9.4

To validate the OSCAP profile (`xccdf_org.ssgproject.content_profile_cis_server_l1`), we recommend confirming that the `scap-security-guide` package is available in the installation environment and that the RHEL 9 SCAP content includes the CIS Server Level 1 profile. 

```kickstart
%addon com_redhat_oscap
    content-type = scap-security-guide
    profile = xccdf_org.ssgproject.content_profile_cis_server_l1
%end
```

```bash
$ cat /etc/redhat-release 
Red Hat Enterprise Linux release 9.4 (Plow)

; install the pkgs
$ sudo dnf install -y scap-security-guide openscap-scanner

;verify data stream is present
$ ls -l /usr/share/xml/scap/ssg/content/ssg-rhel9-ds.xml
-rw-r--r--. 1 root root 25035200 Aug 15  2024 /usr/share/xml/scap/ssg/content/ssg-rhel9-ds.xml

; verify CIS L1 present
$ oscap info /usr/share/xml/scap/ssg/content/ssg-rhel9-ds.xml | grep cis_server_l1
				Id: xccdf_org.ssgproject.content_profile_cis_server_l1
				
				
$ rpm -q scap-security-guide
scap-security-guide-0.1.74-1.el9_4.noarch
```

