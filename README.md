# roger_slyline1

1) Дебиан https://www.debian.org/CD/http-ftp/
2) При разделении нужно закладывать дополнительные 5% на зарезервированную часть диска;
3) kir:pass root:pass
4) Устанавливаем внутри груб, в разделе нетворк настраиваем зеркало для скачивания пакетов;
4.1) Создание пользователя: adduser username, usermod -aG sudo username, su - username
4.2) Удаление пользователя: deluser user, deluser --remove-home sammy
5) Настраиваем статический ip с маской 30:

	файл /etc/network/interfaces


	динамический ip прописывается так - 
	iface enp0s8 inet dhcp
	address 192.168.56.101 - ip виртуальной машины
	netmask 255.255.255.252

	Статический так - 
	iface enp0s3 inet static
      	address 192.168.56.101 
      	netmask 255.255.255.252 - маска на 30

	11111111.11111111.11111111.111111 00 - маска на 30; (.252)
	11111111.11111111.11111111 .00000000 - маска на 24;

	После изменений вводи команду на рестарт сервиса networking 

6) Подключение по Ssh без настроек:
	Порт выбирается в /etc/ssh/sshd_config -> Port	
	ssh -p 44444 kir@192.168.56.101
			
	
7) Настройка SSH
	нужно запретить доступ под рутом
       sshd_config -> PermitRootLogin “prohibit-password” - доступ возможен только по ключу

8) Подключение по rsa
 	ssh-keygen - создаем ключики
	ssh-copy-id username@remote_host -p 44444 - переносим на машину
	рестартим sshd и подключаемся без пароля
	ставим PasswordAuthentication no в sshd_config

9) Настраиваем файрвол
	полностью по инструкции https://upcloud.com/community/tutorials/configure-iptables-debian/

10) Защита от ДДОС

	а) UFW
		sudo ufw status verbose
		https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-		with- ufw-on-ubuntu-14-04
	
		sudo apt-get install ufw
		sudo ufw allow 44444/tcp
		sudo ufw allow 80/tcp
		sudo ufw allow 443/tcp
	б) fail2ban
		
		sudo vim /etc/fail2ban/jail.conf

		sudo vim /etc/fail2ban/jail.conf
		[sshd]
		enabled = true
		port    = 42
		logpath = %(sshd_log)s
		backend = %(sshd_backend)s
		maxretry = 3
		bantime = 600	


	service fail2ban status

11) Защита от сканирования локальных портов
	sudo apt-get install nmap -y  сканирование локальных портов
	редактировать
	/etc/default/portsentry

12) Настройка обновлений:

	https://crontab.guru/#0_4_*_*_7 - расписание

	
	echo "sudo apt-get update -y >> /var/log/update_script.log" >> ~/update.sh - составление списка
	echo "sudo apt-get upgrade -y >> /var/log/update_script.log" >> ~/update.sh - обновление по списку



	настрока кронтаб:
	
	SHELL=/bin/bash

	@reboot sudo /home/kir/update.sh
	0 4 * * 7 sudo /home/kir/update.sh

	

13) Настройка проверки md5 в полночь
	md5sum
	crontab file /var/spool/cron/crontabs/root

14) nginx
	https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-debian-9
	

15) Self-signed certificate nginx-debian9
	https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-on-debian-9

16) start flask on nginx
https://www.digitalocean.com/community/tutorials/how-to-serve-flask-applications-with-uswgi-and-nginx-on-ubuntu-18-04
	
