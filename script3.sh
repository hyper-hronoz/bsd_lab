#!/bin/sh


ipfw -q -f flush

ipfw add 100 nat 1 ip from any to any via em0

ipfw add 110 check-state

ipfw add 120 allow tcp from me to any 80 out keep-state

ipfw add 130 allow tcp from me to any 443 out keep-state

ipfw add 140 allow udp from me to any 53 out keep-state

ipfw add 65535 deny log ip from any to any

