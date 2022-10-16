#! /bin/bash
#Installation of following tools (latest version) on ubuntu.
sudo apt update
#Jenkins Installation

# Install Java JDK 17
sudo apt install -y openjdk-17-jre

# Download and Install Jenkins
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get -y install jenkins

# Start Jenkins
sudo systemctl start jenkins

# Enable Jenkins to run on Boot
sudo systemctl enable jenkins
###########################################################
#Installation of docker engine.
sudo apt-get update
#install packages to allow apt to use a repository over HTTPS:
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
#add docker’s official GPG key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
#set up the stable repository.
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#update the packages
sudo apt-get update
#install the latest version of Docker Engine, containerd, and Docker Compose.
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
#Verify that Docker Engine is installed correctly by running the hello-world image.
sudo systemctl docker start
sudo docker run hello-world
#adds your username to the docker group
sudo usermod -aG docker ${USER}
docker version
echo "docker successfully installed"
#################################################################################
#Install kubectl binary with curl on Linux
#Download the latest release with the command:
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
#Validate the binary (optional)
#Download the kubectl checksum file:
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
#Validate the kubectl binary against the checksum file:
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
#Install kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
#If you do not have root access on the target system, you can still install kubectl to the ~/.local/bin directory:
#chmod +x kubectl
#mkdir -p ~/.local/bin
#mv ./kubectl ~/.local/bin/kubectl
# and then append (or prepend) ~/.local/bin to $PATH
#Verify the version you installed is up-to-date:
#kubectl version --client
#For detailed view of version:
kubectl version --client --output=yaml    
##########################################################
#HELM INSTALL
#Download the script.
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
#Providethe permission.
chmod 700 get_helm.sh
#Execute script to install.
./get_helm.sh
#Verify Installation.
helm version
###########################################################
#TERRAFORM INSTALLATION
#1.Ensure that your system is up to date, and you have the gnupg, software-properties-common, and curl packages installed.
#You will use these packages to verify HashiCorp's GPG signature, and install HashiCorp's Debian package repository.
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
#Install the HashiCorp GPG key.
wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
#Verify the key's fingerprint.
gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint

#Add the official HashiCorp repository to your system.
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list
#Download the package information from HashiCorp.
sudo apt update
#6.Install Terraform from the new repository.
sudo apt-get install terraform
#Check the version
terraform version
##############################################################
#Aws-cli Installation.
#Download the installation file
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
#If your Linux distribution doesn't have a built-in unzip command,Install it.
sudo apt install unzip
#Unzip the installer.
unzip awscliv2.zip
#Run the install program.By default, the files are all installed to /usr/local/aws-cli, and a symbolic link is created in /usr/local/bin.
sudo ./aws/install
#Confirm the installation with the following command. 
aws --version

