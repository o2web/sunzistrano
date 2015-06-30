DEPLOY_PATH=/home/deploy
RBENV_PATH=$DEPLOY_PATH/.rbenv
PLUGINS_PATH=$RBENV_PATH/plugins
PROFILE=$DEPLOY_PATH/.bashrc
RUBY_VERSION=<%= @attributes.rbenv_ruby %>
RBENV_EXPORT_PATH="export PATH=\"$RBENV_PATH/bin:$PLUGINS_PATH/ruby-build/bin:$PATH\""
RBENV_INIT='eval "$(rbenv init -)"'

if [ -d $RBENV_PATH ]; then
  eval $RBENV_EXPORT_PATH
  eval $RBENV_INIT
  echo 'Ruby already installed, skipping'
else
  git clone git://github.com/sstephenson/rbenv.git $RBENV_PATH
  git clone git://github.com/sstephenson/ruby-build.git $PLUGINS_PATH/ruby-build
  git clone git://github.com/sstephenson/rbenv-gem-rehash.git $PLUGINS_PATH/rbenv-gem-rehash
  git clone git://github.com/dcarley/rbenv-sudo.git $PLUGINS_PATH/rbenv-sudo
  eval $RBENV_EXPORT_PATH
  eval $RBENV_INIT
  echo $RBENV_EXPORT_PATH >> $PROFILE
  echo $RBENV_INIT >> $PROFILE
  rbenv install $RUBY_VERSION
  rbenv global $RUBY_VERSION
  echo 'gem: --no-ri --no-rdoc' > $DEPLOY_PATH/.gemrc
  gem install bundler
  gem install backup
fi
