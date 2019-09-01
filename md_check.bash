#!/bin/bash

$new=md5sum /etc/crontab
$old=tail -1 /var/crontab_check.txt
if [[ "$new" -eq "$old" ]]
	echo "SOMEONE TRY TO CHANGE CRONTAB" | mail -s "FAGGOTS: " root
md5sum /etc/crontab >> /var/crontab_check.txt
