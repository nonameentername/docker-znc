#!/bin/bash

if [[ -z "$ZNC_USER" || -z "$ZNC_PASS" ]]; then
    echo 'Please define $ZNC_USER and $ZNC_PASS'
fi

/usr/bin/expect > /tmp/output <<EOF
spawn znc --makepass
expect "Enter Password"
send $ZNC_PASS\n
expect "Confirm Password"
send $ZNC_PASS\n

expect "</Pass>"
send $expect_out(buffer)
EOF

export PASSWORD=$(cat /tmp/output | grep '^[[:space:]]\|^<')

mkdir -p /znc/configs
cat znc.conf | envsubst > /znc/configs/znc.conf
chown -R znc:znc /znc

su znc -c "znc -f -d /znc"
