DEPLOY_PATH=/home/deploy

if [ -d $DEPLOY_PATH ]; then
	echo "User already created, skipping"
else
  adduser deploy --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
  echo "deploy:secret4deploy" | sudo chpasswd
  adduser deploy sudo

  mkdir $DEPLOY_PATH/.ssh
  chmod 700 $DEPLOY_PATH/.ssh

  mv files/id_rsa.pub $DEPLOY_PATH/.ssh/authorized_keys
  chmod 644 $DEPLOY_PATH/.ssh/authorized_keys

  chown -R deploy:deploy $DEPLOY_PATH

  mv files/sudoers /etc/sudoers.d/deploy
  chown root:root /etc/sudoers.d/deploy
  chmod 0440 /etc/sudoers.d/deploy
fi
