scp -i "distant-dollars-key.pem" "..\.env" ubuntu@ec2-18-190-53-205.us-east-2.compute.amazonaws.com:~
ssh -i "distant-dollars-key.pem" ubuntu@ec2-18-190-53-205.us-east-2.compute.amazonaws.com
sudo apt update
sudo apt upgrade
sudo apt install python3.10
sudo apt install python3-pip
sudo apt install python3.10-venv
sudo apt install nginx # WSL is here

git clone https://github.com/FPVian/distant-dollars.git
cp .env distant-dollars/
cp distant-dollars/configs/nginx.conf /etc/nginx/sites-available/dd-nginx.conf
cd distant-dollars/
python3 -m venv venv --upgrade-deps
source venv/bin/activate
pip3 install -r requirements.txt

python3 manage.py makemigrations
python3 manage.py migrate
python3 manage.py collectstatic

# python3 
# import django
# print(django.get_version())
# exit()
sudo nginx -t #  verify configuration
sudo ln -s /etc/nginx/sites-available/dd-nginx.conf /etc/nginx/sites-enabled/
sudo systemctl restart nginx

daphne ddsite.asgi:application
# ^^^ need to daemonize this and restarting the nginx server


sudo snap install core; sudo snap refresh core
sudo apt-get remove certbot
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo certbot --nginx
sudo certbot renew --dry-run # test that renewals work