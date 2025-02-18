
#!/bin/bash

# Update the system
sudo apt-get update -y
sudo apt-get upgrade -y

# Install dependencies for Jenkins
sudo apt-get install -y openjdk-11-jdk wget gnupg lsb-release

# Add Jenkins repository and key
wget -q -O - https://pkg.jenkins.io/jenkins-ci.org.key | sudo tee /usr/share/keyrings/jenkins.asc
echo "deb [signed-by=/usr/share/keyrings/jenkins.asc] https://pkg.jenkins.io/debian/ $(lsb_release -cs) main" | sudo tee -a /etc/apt/sources.list.d/jenkins.list

# Install Jenkins
sudo apt-get update -y
sudo apt-get install -y jenkins

# Start Jenkins service
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Install Java (OpenJDK 11)
sudo apt-get install -y openjdk-11-jdk

# Verify installations
java -version
jenkins --version

# Set Jenkins to use Java 11 if necessary
sudo update-alternatives --config java

# Open the necessary port for Jenkins (default is 8080)
sudo ufw allow 8080

# Set permissions for Jenkins to run smoothly
sudo chown -R jenkins:jenkins /var/lib/jenkins
sudo chmod -R 755 /var/lib/jenkins






