#!/bin/bash
# Reset forgotten MySQL root password (Homebrew MySQL on macOS).
# Usage: ./reset-mysql-root-password.sh 'YourNewPassword'
# Use a password without single-quote characters to avoid shell escaping issues.

set -e
NEW_PASSWORD="${1:?Usage: $0 \"YourNewPassword\"}"

MYSQL_PREFIX="$(brew --prefix mysql 2>/dev/null)" || MYSQL_PREFIX="$(brew --prefix mysql@9.4 2>/dev/null)" || MYSQL_PREFIX="/usr/local/opt/mysql"
[ -x "$MYSQL_PREFIX/bin/mysqld_safe" ] || { echo "MySQL not found at $MYSQL_PREFIX"; exit 1; }

echo "Stopping MySQL..."
brew services stop mysql 2>/dev/null || true
sleep 2
pkill -f mysqld || true
sleep 2

echo "Starting MySQL in safe mode (no password check)..."
cd "$MYSQL_PREFIX"
./bin/mysqld_safe --skip-grant-tables --skip-networking &
SAFE_PID=$!
sleep 5

echo "Setting new root password..."
./bin/mysql -u root -e "FLUSH PRIVILEGES; ALTER USER 'root'@'localhost' IDENTIFIED BY '${NEW_PASSWORD}'; FLUSH PRIVILEGES;"

echo "Stopping safe-mode MySQL..."
kill $SAFE_PID 2>/dev/null || true
sleep 2
pkill -f mysqld_safe || true
sleep 2

echo "Starting MySQL normally..."
brew services start mysql
sleep 3

echo "Done. Test with: mysql -u root -p"
echo "Run your app with: export MYSQL_PASSWORD='YOUR_NEW_PASSWORD'"
