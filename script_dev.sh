#!/bin/bash
PASS=Moneda123
DB=neobank

# run <usuario> <sql>: ejecuta una sentencia como ese usuario
run() {
    echo "-> [$1] $2"
    MYSQL_PWD="$PASS" mariadb --user="$1" --host=localhost --port=3306 \
        --database="$DB" --table --skip-ssl --execute "$2"
}

# Consulta libre pasada por parámetro (como root)
if [[ $# -gt 0 ]]; then
    run root "$1"
    exit $?
fi

# Query1: concede todos los permisos sobre neobank al usuario Jon
run root "GRANT ALL PRIVILEGES ON ${DB}.* TO 'Jon'@'localhost';" || exit 1

# Query2: registra una transacción (ahora como Jon)
run Jon "INSERT INTO transactions(account_id,type,amount) VALUES (1,'DEPOSIT',100000.00);" || exit 1
