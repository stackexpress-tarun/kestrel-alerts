/usr/bin/expect << EOF
spawn /usr/bin/telnet localhost 22133
expect -re ".*>"
send "STATS\r"
expect -re ".*>"
send "exit\r"
EOF
