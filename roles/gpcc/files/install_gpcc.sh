#!/usr/bin/expect -f
set timeout 5 
	spawn /home/gpadmin/gpcc-tmp-install/gpcc.bin -c /home/gpadmin/gpcc_config.ini -W

	expect  "^Password for GPDB user gpmon:*"
	send    "changeme\r"

	expect	"^--More--*"
	send 	"q"

	expect	"^Do you agree to the Pivotal Greenplum Command Center End User License Agreement*"
	send	"Y\r"

        expect  "^Would you like to continue with gpcc installation*"
        send    "Y\r"

#	expect	"^Where would you like to install Greenplum Command Center*"
#	send	"/usr/local\r"

#	expect  "^What would you like to name this installation of Greenplum Command Center*"
#	send	"gpcc\r";

#	expect	"^What port would you like gpcc webserver to use*"
#	send 	"28080\r"

#	expect  "^Would you like to enable kerberos*"
#	send	"n\r";

#	expect	"^Would you like enable SSL*"
#	send	"y\r"

#	expect	"^Please enter the full path of certificate file, including filename:*"
#	send	"/home/gpadmin/certs/cert.pem\r"

	interact
exit
