if sudo -u root mysql -proot -e 'use filemaker_staging'; then
  echo "database already created, skipping"
else
  sudo -u root mysql -proot -e "CREATE DATABASE filemaker_staging;"
  sudo -u root mysql -proot -e "CREATE DATABASE filemaker_production;"
  sudo -u root mysql -proot -e "CREATE USER 'carnaval_fmkr'@'localhost' IDENTIFIED BY 'secret4keeper';"
  sudo -u root mysql -proot -e "GRANT ALL PRIVILEGES ON filemaker_staging.* TO 'carnaval_fmkr'@'localhost';"
  sudo -u root mysql -proot -e "GRANT ALL PRIVILEGES ON filemaker_production.* TO 'carnaval_fmkr'@'localhost';"
  sudo -u root mysql -proot -e "FLUSH PRIVILEGES;"
fi
