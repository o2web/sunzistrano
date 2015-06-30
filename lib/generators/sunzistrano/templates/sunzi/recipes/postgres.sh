if sudo -u postgres psql -lqt | cut -d \| -f 1 | grep -w app_staging &>/dev/null; then
  echo "Database already created, skipping"
else
  sudo -u postgres psql -c "create user keeper with password 'secret4keeper';"
  sudo -u postgres psql -c "create database app_staging owner keeper;"
  sudo -u postgres psql -c "create database app_production owner keeper;"
fi
