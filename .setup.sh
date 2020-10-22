sudo apt-get update;
sudo apt-get install nginx -y;
sudo service nginx start;
node load.js 2> /dev/null;