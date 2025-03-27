#!/bin/bash
sudo apt-get update 
yes | sudo apt install openjdk-17-jdk-headless

echo "Waiting for 30 seconds before installing the jenkins package..."
sleep 30

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update
yes | sudo apt-get install jenkins
sleep 30 

sudo chown -R jenkins:jenkins /var/lib/jenkins
sudo chmod -R 755 /var/lib/jenkins

sudo apt-get update

sudo systemctl start jenkins
sudo systemctl enable jenkins



