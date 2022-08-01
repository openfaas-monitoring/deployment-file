#!/bin/bash
#批量安装node_exporter
soft_dir=/root/soft
if [ ! -e $soft_dir ];then
        mkdir $soft_dir
fi
 
netstat -lnpt | grep 9100
if [ $? -eq 0 ];then
        use=`netstat -lnpt | grep 9100 | awk -F/ '{print $NF}'`
        echo "9100端口已经被占用，占用者是 $use"
        exit 1
fi
 
cd $soft_dir
wget https://github.com/prometheus/node_exporter/releases/download/v1.0.1/node_exporter-1.0.1.linux-amd64.tar.gz
tar xf node_exporter-1.0.1.linux-amd64.tar.gz
mv node_exporter-1.0.1.linux-amd64 /usr/local/node_exporter
 
cat <<EOF >/usr/lib/systemd/system/node_exporter.service
[Unit]
Description=https://prometheus.io
 
[Service]
Restart=on-failure
ExecStart=/usr/local/node_exporter/node_exporter --collector.systemd --collector.systemd.unit-whitelist=(docker|kubelet|node_exporter).service
 
[Install]
WantedBy=multi-user.target
EOF
 
systemctl daemon-reload
systemctl enable node_exporter
systemctl restart node_exporter
 
netstat -lnpt | grep 9100
 
if [ $? -eq 0 ];then
        echo "node_eporter install finish..."
fi