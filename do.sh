#! /bin/bash

function abort_file_not_exist()
{
	dir="$1"
	msg="$2"

	if [ ! -e "$dir" ];
	then
		echo "$msg"
		exit 1
	fi;

}

function abort_dir_not_exist()
{
	dir="$1"
	msg="$2"
	if [ ! -d "$dir" ];
	then
		echo "$msg"
		exit 1
	fi;
}

#echo "Usage: (cd .. ; ln -s anlaneg_tcpdump tcpdump ; ln -s anlaneg_libpcap libpcap)"
abort_dir_not_exist "../tcpdump" "need 'tcpdump' directory"
abort_dir_not_exist "../libpcap" "need 'libpcap' directory"

abort_file_not_exist "../tcpdump/do.sh" "need tcpdump/do.sh file"

#export CFLAGS=-g
diff_str=`diff -Nu ../tcpdump/do.sh $0`
if [ "X$diff_str" == "X" ];
then
	(echo "do build libpcap" ; cd ../libpcap ; if [ ! -e Makefile ];then ./configure --with-pcap=dpdk-vpc ; fi; make ;)
	(echo "do build tcpdump" ; cd ../tcpdump ; if [ ! -e Makefile ]; then ./configure ; fi; make ;)
fi;
