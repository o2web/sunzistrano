DEPLOY_USER=<%= @attributes.deploy_user %>
DEPLOY_PATH=/home/$DEPLOY_USER
DEPLOY_PWD=<%= @attributes.deploy_pwd %>

if [ -d $DEPLOY_PATH ]; then
	echo "User already created, skipping"
else
  adduser $DEPLOY_USER --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
  echo "$DEPLOY_USER:$DEPLOY_PWD" | sudo chpasswd
  adduser $DEPLOY_USER sudo

  mkdir $DEPLOY_PATH/.ssh
  chmod 700 $DEPLOY_PATH/.ssh

  mv files/id_rsa.pub $DEPLOY_PATH/.ssh/authorized_keys
  chmod 644 $DEPLOY_PATH/.ssh/authorized_keys

  chown -R $DEPLOY_USER:$DEPLOY_USER $DEPLOY_PATH

	mv files/sudoers /etc/sudoers.d/deploy
	chown root:root /etc/sudoers.d/deploy
	chmod 0440 /etc/sudoers.d/deploy
fi
