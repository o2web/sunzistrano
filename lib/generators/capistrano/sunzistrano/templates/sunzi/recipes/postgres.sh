DB_USER=<%= @attributes.postgres_user %>
APP=<%= @attributes.app_name %>

if sudo -u postgres psql -lqt | cut -d \| -f 1 | grep -w "${APP}_staging" &>/dev/null; then
  echo "Database already created, skipping"
else
  sudo -u postgres psql -c "create user $DB_USER with password '<%= @attributes.postgres_pwd %>';"
  sudo -u postgres psql -c "create database ${APP}_staging owner $DB_USER;"
  sudo -u postgres psql -c "create database ${APP}_production owner $DB_USER;"
fi
