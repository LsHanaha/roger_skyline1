


NEW=$(cat /Users/lshanaha/Desktop/matcha/config.py | grep "RELEASE_VERSION = " | awk -F"[\'\']" '{print $2}')
OLD=$(cat /Users/lshanaha/Desktop/matcha/loaded_version.txt)

if [[ "cat: config.py: No such file or directory" = $NEW ]];
	then git clone https://github.com/Nestnestnest/simplex.git;
	NEW=$(cat /Users/lshanaha/Desktop/matcha/config.py | grep "RELEASE_VERSION = " | awk -F"[\'\']" '{print $2}')
fi;

if [[ $NEW > $OLD  ]];
then
	scp -P 44444 -o ConnectTimeout=60 -r /Users/lshanaha/Desktop/matcha/app kir@192.168.56.3:/home/kir
	echo $NEW > /Users/lshanaha/Desktop/matcha/loaded_version.txt
	echo "Update $NEW was send to server" > loading_log.txt
fi;

