#!/bin/bash

provision_name="Install Ansible"

echo "[PROVISION] Provision <$provision_name> started."

echo "[PROVISION] Installing linux dependencies..."
yum install -y $(cat /opt/ansible/oracle_linux_requirements.txt)

# echo "[PROVISION] Creating and activating python virtual environment..."
# python3.11 -m venv /opt/ansible/.venv
# source /opt/ansible/.venv/bin/activate

# echo "[PROVISION] Installing python dependencies..."
# pip install --upgrade pip
# pip install -r /opt/ansible/python_requirements.txt

# echo "[PROVISION] Installing ansible collections..."
# ansible-galaxy install --force -r /opt/ansible/ansible_requirements.yaml

echo "[PROVISION] Provision <$provision_name> done."
