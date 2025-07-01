#!/bin/bash

USER="ansible"
KEY_PATH="~/.ssh/ansible_test"
SSH_OPTIONS="-o StrictHostKeyChecking=accept-new -o ConnectTimeout=5"

PG_PORT="5432"

WEB_SERVERS=(
    "10.0.0.101"
)
DB_SERVERS=(
    "10.0.0.102"
)

ANSIBLE_INVENTORY="/opt/ansible/inventories/test/hosts.yaml"

echo ""
echo "[ Проверка серверов Nginx ]"

for HOST in "${WEB_SERVERS[@]}"; do
    echo -n " $HOST: "

    if ssh -i $KEY_PATH $SSH_OPTS "$USER@$HOST" "systemctl status nginx > /dev/null"; then
        echo "OK"
    else
        echo "FAIL"
    fi
done

echo ""
echo "[ Проверка портов Postgres ]"

for HOST in "${DB_SERVERS[@]}"; do
    echo -n " $HOST: "

    if ssh -i $KEY_PATH $SSH_OPTS "$USER@$HOST" "netstat -tulpn | grep $PG_PORT > /dev/null"; then
        echo "OK"
    else
        echo "FAIL"
    fi
done

echo ""
echo "[ Проверка хостов из инвентаря ansible ]"

mapfile -t HOSTS < <(grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' "$ANSIBLE_INVENTORY")

for HOST in "${HOSTS[@]}"; do
    echo -n " $HOST: "

    if ping -qc 3 $HOST >/dev/null; then
        echo "OK"
    else
        echo "FAIL"
    fi
done
