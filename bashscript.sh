#!/bin/bash
# Bash Assignment 
# COMP2101 Tuesday Morning Class
# Jonathan Stamos
# Student ID- 100127686


# Declare variables and assign any default values
rundefaultmode="yes"




# command line options to narrow down the Output field
function helpcmds {
echo "
Output can be one or more for the following:
$0 [-h | --help menu]
$0 [-hd | --Displays host and domain name]
$0 [-i | --IP address of the system]
$0 [-os | --Operating System name]
$0 [-ov | --Operating System version]
$0 [-ci | --CPU info ]
$0 [-ri | --RAM info]
$0 [-df | --Available Disk Space]
$0 [-p | --List of Installed Printers]
"
}




function errormessage {
echo "$0" >&2
}


# Narrowing the information field
while [ $# -gt 0 ]; do
case "$1" in
-h)
helpcmds
rundefaultmode="no"
;;
-hd)
hostinfo="yes"
rundefaultmode="no"
;;
-i)
ipinfo="yes"
rundefaultmode="no"
;;
-os)
osinfo="yes"
rundefaultmode="no"
;;
-ov)
ovinfo="yes"
rundefaultmode="no"
;;
-ci)
cpuinfo="yes"
rundefaultmode="no"
;;
-ri)
raminfo="yes"
rundefaultmode="no"
;;
-df)
diskinfo="yes"
rundefaultmode="no"
;;
-p)
printerinfo="yes"
rundefaultmode="no"
;;
-sw)
errormessage "
'$1' Not a valid entry"
exit 1
;;
esac
shift
done




# Information variables
Systemname="$(hostname)"
domainname="$(hostname -d)"
ipaddress="$(hostname -I)"
OSname="$(lsb_release -i)"
OSversion="$(grep PRETTY /etc/os-release |sed -e 's/.*=//' -e 's/"//g')"
CPUdetails="$(lscpu | grep "Model name:")"
RAMinfo="$(cat /proc/meminfo | grep MemTotal)"
discspace="$(df -h)"
printerinformation="$(lpstat -p)"


# Outputs

# Host name/Domain Name Details
hostnamedetails="Hostname: $Systemname
Domain Name: $domainname"
# IP Details
ipaddressdetails="IP Address: $ipaddress"
# OS Details
osdetails="Operating System: $OSname"
# OS Version
osversion="Operating System Version: $OSversion"
# CPU Information
cpudetails="CPU Information: $CPUdetails"
# RAM Details
ramdetails="RAM Information: $RAMinfo"
# Disc Space Details
discdetails="
DISC Information: $discspace"
# Printer Details
printerdetails="Installed Printer Information: $printerinformation"


# OUTPUT


if [ "$rundefaultmode" = "yes" -o "$hostinfo" = "yes" ]; then
echo "$hostnamedetails"
fi
if [ "$rundefaultmode" = "yes" -o "$ipinfo" = "yes" ]; then
echo "$ipaddressdetails"
fi
if [ "$rundefaultmode" = "yes" -o "$osinfo" = "yes" ]; then
echo "$osdetails"
fi
if [ "$rundefaultmode" = "yes" -o "$ovinfo" = "yes" ]; then
echo "$osversion"
fi
if [ "$rundefaultmode" = "yes" -o "$cpuinfo" = "yes" ]; then
echo "$cpudetails"
fi
if [ "$rundefaultmode" = "yes" -o "$raminfo" = "yes" ]; then
echo "$ramdetails"
fi
if [ "$rundefaultmode" = "yes" -o "$diskinfo" = "yes" ]; then
echo "$discdetails"
fi
if [ "$rundefaultmode" = "yes" -o "$printerinfo" = "yes" ]; then
echo "$printerdetails"
fi


echo END OF SYSTEM INFORMATION
