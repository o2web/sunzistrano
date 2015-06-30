if hash passenger 2>/dev/null; then
  echo "Passenger + Nginx already installed, skipping"
else
  gem install passenger -v <%= @attributes.passenger_version %>
  if <%= @attributes.increase_swap %> = 'true'; then
    sudo dd if=/dev/zero of=/swap bs=1M count=1024
    sudo mkswap /swap
    sudo swapon /swap
  fi
  yes | rbenv sudo passenger-install-nginx-module
  sudo mv files/nginx /etc/init.d/nginx
  sudo chmod +x /etc/init.d/nginx
  sudo service nginx start
fi
