#! /bin/bash
target_dir=/root
input=none


while [ ! -d "$input" ]
do
	echo "Enter root directory of the service:[/root] "
	read input
	if [ -z "$input" ]
	then
		input=/root
	fi
done

target_dir=$input
target_dir+=/ddns

mkdir -p $target_dir


pip3 install pyinstaller
pyinstaller --onefile ddns_aws.py




service_file="ddns_aws.service"
content="[Unit]\nDescription = DDNS services for Route53\nAfter = network.target syslog.target\nWants = network.target\n\n[Service]\nType = simple\nRestart = always\nRestartSec = 10\nWorkingDirectory = "$target_dir"\nExecStart = $target_dir/ddns_aws\n\n[Install]\nWantedBy = multi-user.target\n"
echo -en $content > $service_file



cp -n $service_file $target_dir
mv -f $service_file /lib/systemd/system/


cp -n ddns_aws.config $target_dir
mv -f ./dist/ddns_aws $target_dir/ddns_aws
rm -rf build ddns_aws.spec dist

systemctl daemon-reload
systemctl restart ddns_aws.service
