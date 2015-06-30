if hash expect 2>/dev/null; then
  echo "Librairies already installed, skipping"
else
  sudo apt-get update

  sudo timedatectl set-timezone <%= @attributes.timezone %>

  sudo apt-get -y install curl
  curl -sL https://deb.nodesource.com/setup | sudo bash -
  sudo apt-get -y install \
  expect \
  ntp \
  git-core \
  zlib1g-dev \
  build-essential \
  libssl-dev \
  libreadline-dev \
  libyaml-dev \
  libsqlite3-dev \
  sqlite3 \
  libxml2-dev \
  libxslt1-dev \
  libcurl4-openssl-dev \
  python-software-properties \
  libffi-dev \
  nodejs \
  imagemagick \
  postgresql \
  postgresql-contrib \
  libpq-dev
fi
