
#!/bin/sh

    echo ""
    echo "DMI Configuration"
    echo ""
    read input
    let DEBUG="$input"

    if [ "$DEBUG" == "1" ]
    then
        #
        scp '~/Downloads/SW*application.tgz.gz' root@192.168.4.177:/tmp
        sshpass -p 'dat' ssh root@$1 'tar xzhf SW*pkg-application.tgz.tgz.gz'
		sshpass -p 'dat' ssh root@$1 'exit;reboot'
        fi
fi
