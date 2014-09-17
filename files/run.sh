#!/bin/bash

if [[ -z "$ZNC_USER" || -z "$ZNC_PASS" ]]; then
    echo 'Please define $ZNC_USER and $ZNC_PASS'
fi

ZNC_SALT="$(dd if=/dev/urandom bs=16c count=1 | md5sum | awk '{print $1}')"
export PASSWORD="sha256#$(echo -n ${ZNC_PASS}${ZNC_SALT} | sha256sum | awk '{print $1'})#${ZNC_SALT}#"

mkdir -p /znc/configs
cat znc.conf | envsubst > /znc/configs/znc.conf
mkdir .znc
znc --makepem
cp .znc/znc.pem /znc/
chown -R znc:znc /znc

su znc -c "znc -f -r -d /znc"
