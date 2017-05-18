
HOST=$1
USER='root'
PASSWD='dat'

echo ""
echo "DMI Configuration"
echo ""

scp '~/Downloads/SW*application.tgz.gz' root@$1:/tmp

sshpass -p $PASSWD ssh $USER@$1 'rm -r /opt'

sshpass -p $PASSWD ssh $USER@$1 'tar xzhf SW*pkg-application.tgz.tgz.gz'
sshpass -p $PASSWD ssh $USER@$1 'exit;reboot
