#!/bin/sh
cd distant-dollars/
sudo git pull origin main
sudo cp ../.env .
#source venv/bin/activate
sudo pip3 install -r requirements.txt
sudo python3 manage.py makemigrations
sudo python3 manage.py migrate
sudo python3 manage.py collectstatic
-yes
sudo systemctl restart nginx
sudo supervisorctl restart all
