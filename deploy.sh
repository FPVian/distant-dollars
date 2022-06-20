#!/bin/sh
sudo apt update
sudo apt upgrade
sudo apt install python3.10
sudo apt install python3-pip
sudo apt install python3.10-venv

python3 -m venv venv --upgrade-deps
source venv/bin/activate

sudo git pull origin main # I am here
sudo pip3 install -r requirements.txt
daphne distant-dollars.asgi:application # run from manage.py dir, on PATH, sub names