#!/bin/bash
USER=root
PASS=Moneda123
HOST=localhost
PORT=3306
DB=neobank

# Conexión a la base de datos
CONN=(--user="$USER" --host="$HOST" --port="$PORT" --table)
CONN_DB=("${CONN[@]}" --database="$DB")

# Query1: concede todos los permisos sobre neobank al usuario Jon
QUERY1="GRANT ALL PRIVILEGES ON ${DB}.* TO 'Jon'@'10.0.12.12';"

# Query2: registra una transacción
QUERY2="INSERT INTO transactions(account_id,type,amount) VALUES (1,'DEPOSIT',100000.00);"

# Consulta libre pasada por parámetro.
if [[ $# -gt 0 ]]; then
    MYSQL_PWD="$PASS" mariadb "${CONN_DB[@]}" --execute "$1"
    exit $?
fi

echo "-> $QUERY1"
MYSQL_PWD="$PASS" mariadb "${CONN_DB[@]}" --execute "$QUERY1" || exit 1

echo "-> $QUERY2"
MYSQL_PWD="$PASS" mariadb "${CONN_DB[@]}" --execute "$QUERY2" || exit 1
