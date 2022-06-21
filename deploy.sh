#!/bin/sh
sudo git pull origin main
cp ../.env .
source venv/bin/activate
sudo pip3 install -r requirements.txt
python3 manage.py makemigrations
python3 manage.py migrate
python3 manage.py collectstatic
sudo systemctl restart nginx
sudo daphne ddsite.asgi:application