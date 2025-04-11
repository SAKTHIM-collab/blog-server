mkdir -p ~/blog-server
cd ~/blog-server
mkdir -p scripts config cronjobs
tree ~/blog-server
sudo snap install tree
tree ~/blog-server
mv ~/Downloads/initUsers.sh scripts/
cd scripts
touch initUsers.sh
rm ~/blog-server/scripts/initUsers.sh
#!/bin/bash
# Root directory
ROOT=~/blog-server
# Create directory structure
mkdir -p $ROOT/scripts
mkdir -p $ROOT/config
mkdir -p $ROOT/cronjobs
# Create script files
touch $ROOT/scripts/initUsers.sh
touch $ROOT/scripts/manageBlogs.sh
touch $ROOT/scripts/blogFilter.sh
touch $ROOT/scripts/userFY.sh
touch $ROOT/scripts/adminPanel.sh
touch $ROOT/scripts/subscriptionModel.sh
touch $ROOT/scripts/ncNotify.sh
touch $ROOT/scripts/requestAuthor.sh
touch $ROOT/scripts/approveAuthor.sh
# Make scripts executable
chmod +x $ROOT/scripts/*.sh
# Create config files
touch $ROOT/config/users.yaml
touch $ROOT/config/userpref.yaml
touch $ROOT/config/blacklist.txt
# Create cronjob file
touch $ROOT/cronjobs/admin_report_cron.txt
# Create README.md
touch $ROOT/README.md
# Confirmation
echo "✅ blog-server/ structure created successfully at: $ROOT"
tree $ROOT 2>/dev/null || ls -R $ROOT
sudo groupadd g_user
sudo groupadd g_author
sudo groupadd g_mod
sudo groupadd g_admin
#!/bin/bash
YAML_FILE=~/blog-server/config/users.yaml
if [ "$EUID" -ne 0 ]; then   echo "❌ Please run as root (sudo).";   exit; fi
tree ~/blog-server
ls ~/blog-server/scripts/initUsers.sh
sudo apt update
sudo apt install yq jq
chmod +x ~/blog-server/scripts/initUsers.sh
nano ~/blog-server/scripts/initUsers.sh
#!/bin/bash
YAML_FILE=~/blog-server/config/users.yaml
if [ "$EUID" -ne 0 ]; then   echo "❌ Please run as root (sudo).";   exit; fi
tree ~/blog-server
echo 'export PATH=$PATH:$HOME/blog-server/scripts' >> ~/.bashrc
source ~/.bashrc
chmod +x ~/blog-server/scripts/initUsers.sh
sudo ~/blog-server/scripts/initUsers.sh
nano ~/blog-server/scripts/manageBlogs.sh
chmod +x ~/blog-server/scripts/manageBlogs.sh
nano ~/blog-server/scripts/blogFilter.sh
chmod +x ~/blog-server/scripts/blogFilter.sh
nano ~/blog-server/scripts/initUsers.sh
nano ~/blog-server/scripts/manageBlogs.sh
chmod +x ~/blog-server/scripts/manageBlogs.sh
./blog-server/scripts/manageBlogs.sh -p sample.txt
sudo ./blog-server/scripts/manageBlogs.sh -p sample.txt
mkdir -p /home/authors/sak03/blogs
echo "My first blog post" | sudo tee /home/authors/sak03/blogs/sample.txt
sudo mkdir -p /home/authors/sak03/{blogs,public}
sudo chown -R sak03:g_author /home/authors/sak03
mkdir -p /home/authors/sak03/blogs
echo "My first blog post" | sudo tee /home/authors/sak03/blogs/sample.txt
sudo ./blog-server/scripts/manageBlogs.sh -p sample.txt
/home/authors/sak03/blogs/
nano blog-server/scripts/manageBlogs.sh
sudo ./blog-server/scripts/manageBlogs.sh -p sample.txt
chmod +x blog-server/scripts/manageBlogs.sh
sudo ./blog-server/scripts/manageBlogs.sh -p sample.txt
nano blog-server/scripts/blogFilter.sh
chmod +x blog-server/scripts/blogFilter.sh
nano blog-server/scripts/userFY.sh
chmod +x blog-server/scripts/userFY.sh
nano blog-server/scripts/adminPanel.sh
chmod +x blog-server/scripts/adminPanel.sh
crontab -e
nano blog-server/scripts/admin_report_wrapper.sh
chmod +x blog-server/scripts/admin_report_wrapper.sh
nano blog-server/scripts/subscriptionModel.sh
chmod +x blog-server/scripts/subscriptionModel.sh
nano blog-server/scripts/ncNotify.sh
chmod +x blog-server/scripts/ncNotify.sh
0 * * * * /bin/bash /home/sak03/blog-server/scripts/ncNotify.sh
sudo crontab -e
nano /home/USERNAME/.bashrc
nano /home/sak03/.bashrc
echo "new_notifications 🔔 New blog from author1" >> ~/notifications.log
source ~/.bashrc
nano blog-server/scripts/approveAuthor.sh
cd ~/blog-server/config
nano userpref.yaml
nano users.yaml
exit
tree ~/blog-server
cd ~/blog-server/config
echo -e "user1: g_user\nuser2: g_author\nuser3: g_admin" > users.yaml
cat users.yaml
exit 
mkdir ~/bs
cd ~/bs
sudo apt update
sudo apt install curl jq -y
curl -LO https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
chmod +x yq_linux_amd64
sudo mv yq_linux_amd64 /usr/local/bin/yq
yq --version  # ✅ Check it works
mkdir blogs users config
touch config/users.yaml config/userpref.yaml config/subscriptions.yaml config/blacklist.txt config/requests.yaml
touch initUsers.sh manageBlogs.sh blogFilter.sh userFY.sh subscriptionModel.sh ncNotify.sh adminPanel.sh rolePromotion.sh
chmod +x *.sh
nano initUsers.sh
nano manageBlogs.sh
nano #!/bin/bash
# Only moderators can run this
MODERATOR=$(whoami)
CONFIG="/config/users.yaml"
BLACKLIST="/home/mods/$MODERATOR/blacklist.txt"
LOGFILE="/tmp/censor_log.txt"
if [ ! -f "$BLACKLIST" ]; then     echo "Blacklist not found in $BLACKLIST";     exit 1; fi
cd ~/bs
tree ~/bs
sudo passwd author1
sudo nano /home/sak03/blog-server/config/blacklist.txt
echo "inappropriate" >> /home/sak03/blog-server/config/blacklist.txt
bash /home/sak03/blog-server/scripts/blogFilter.sh
cat /home/sak03/blog-server/config/users.yaml
sudo mkdir -p /home/sak03/authors/author1/public
sudo chown -R author1:author1 /home/sak03/authors/author1
sudo chown -R sak03:sak03 /home/sak03/authors/author1
echo "This blog is about science and tech." > /home/sak03/authors/author1/public/blog1.txt
echo "This blog contains badword1 which should be flagged." > /home/sak03/authors/author1/public/blog2.txt
cat /home/sak03/blog-server/config/blacklist.txt
bash /home/sak03/blog-server/scripts/blogFilter.sh
yq 'keys' /home/sak03/blog-server/config/users.yaml
cat /home/sak03/blog-server/config/users.yaml
/home/sak03/authors/author1/public
ls -ld /home/sak03/authors/author1/public
echo "Tech is great. But badword1 is bad." > /home/sak03/authors/author1/public/blog1.txt
cat /home/sak03/blog-server/config/blacklist.txt
bash /home/sak03/blog-server/scripts/blogFilter.sh
ls -ld /home/sak03/authors
ls -ld /home/sak03/authors/author1
ls -ld /home/sak03/authors/author1/public
echo "This article contains badword1 and some good stuff." > /home/sak03/authors/author1/public/blog1.txt
echo -e "badword1\nbadword2" > /home/sak03/blog-server/config/blacklist.txt
bash /home/sak03/blog-server/scripts/blogFilter.sh
echo "Authors in users.yaml:"
yq 'keys' /home/sak03/blog-server/config/users.yaml
echo "Checking for author1 role:"
yq '.author1.role' /home/sak03/blog-server/config/users.yaml
nano /home/sak03/blog-server/config/users.yaml
yq '.author1.role' /home/sak03/blog-server/config/users.yaml
bash /home/sak03/blog-server/scripts/blogFilter.sh
ls -l /home/sak03/authors/author1/public/
ls -ld /home/sak03/authors/author1/public
author_dirs=$(yq e 'select(.[] | .role == "author") | keys' /home/sak03/blog-server/config/users.yaml)
yq 'keys' /home/sak03/blog-server/config/users.yaml
yq '.author1.role' /home/sak03/blog-server/config/users.yaml
echo "Tech blog sample" > /home/sak03/authors/author1/public/blog1.txt
bash /home/sak03/blog-server/scripts/blogFilter.sh
nano /home/sak03/blog-server/scripts/blogFilter.sh
bash ~/blog-server/scripts/blogFilter.sh author1
echo "🔍 Checking directory: $TARGET"
ls -ld /full/path/printed/in/target
/home/sak03/authors/author1/public
ls /home/sak03/authors/author1/public
nano ~/blog-server/scripts/blogFilter.sh
bash ~/blog-server/scripts/blogFilter.sh author1
ls -ld /home/sak03/authors/author1/public
bash ~/blog-server/scripts/blogFilter.sh author1
nano ~/blog-server/scripts/blogFilter.sh
bash ~/blog-server/scripts/blogFilter.sh author1
nano ~/blog-server/scripts/blogFilter.sh
bash ~/blog-server/scripts/blogFilter.sh author1
chmod -R o+rx /home/sak03/authors
bash ~/blog-server/scripts/blogFilter.sh author1
if [ ! -d "$TARGET" ]; then   echo "❌ Author's public directory not found";   exit 1; fi
