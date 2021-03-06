scp -i "distant-dollars-key.pem" "..\.env" ubuntu@ec2-18-190-53-205.us-east-2.compute.amazonaws.com:~
ssh -i "distant-dollars-key.pem" ubuntu@ec2-18-190-53-205.us-east-2.compute.amazonaws.com
sudo apt update
sudo apt upgrade -y
sudo apt install python3.10 -y
sudo apt install python3-pip -y
sudo apt install python3.10-venv -y
sudo apt install nginx -y
sudo apt install supervisor -y
sudo apt install daphne -y

mkdir logs
git clone https://github.com/FPVian/distant-dollars.git
cp .env distant-dollars/
cd distant-dollars/
# python3 -m venv venv --upgrade-deps
# source venv/bin/activate
sudo pip3 install -r requirements.txt

python3 manage.py makemigrations
python3 manage.py migrate
python3 manage.py collectstatic -yes

# python3 
# import django
# print(django.get_version())
# exit()

sudo cp configs/dd-nginx.conf /etc/nginx/sites-available/dd-nginx.conf
sudo nginx -t #  verify configuration
sudo ln -s /etc/nginx/sites-available/dd-nginx.conf /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default
sudo systemctl restart nginx

sudo snap install core; sudo snap refresh core
sudo apt-get remove certbot
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo certbot --nginx # -distantdollars@gmail.com -y -n -1,2
sudo certbot renew --dry-run # test that renewals work

# daphne ddsite.asgi:application
sudo cp configs/supervisor.conf /etc/supervisor/conf.d/supervisor.conf
sudo mkdir /run/daphne
sudo cp configs/daphne.conf /usr/lib/tmpfiles.d/daphne.conf
sudo supervisorctl reread
sudo supervisorctl update
sudo service nginx reload
