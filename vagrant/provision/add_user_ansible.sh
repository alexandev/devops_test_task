#!/bin/bash

provision_name="Add user ansible"
user_name="ansible"

echo "[PROVISION] Provision <$provision_name> started."


sudo useradd $user_name
echo $user_name | sudo passwd $user_name --stdin
sudo usermod -aG wheel $user_name


echo "[PROVISION] Provision <$provision_name> done."
