 #!/bin/bash

 sudo apt-get update
 sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
Add Docker’s official GPG key:

 sudo mkdir -p /etc/apt/keyrings
 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
Use the following command to set up the repository:

 echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
Install Docker Engine
Update the apt package index, and install the latest version of Docker Engine, containerd, and Docker Compose, or go to the next step to install a specific version:

 sudo apt-get update
 sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
Receiving a GPG error when running apt-get update?

Your default umask may not be set correctly, causing the public key file for the repo to not be detected. Run the following command and then try to update your repo again: sudo chmod a+r /etc/apt/keyrings/docker.gpg.

To install a specific version of Docker Engine, list the available versions in the repo, then select and install:

a. List the versions available in your repo:

 apt-cache madison docker-ce
b. Install a specific version using the version string from the second column, for example, 5:20.10.16~3-0~ubuntu-jammy.

 sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io docker-compose-plugin
Verify that Docker Engine is installed correctly by running the hello-world image.

 sudo service docker start
 sudo docker run hello-world
This command downloads a test image and runs it in a container. When the container runs, it prints a message and exits.

Docker Engine is installed and running. The docker group is created but no users are added to it. You need to use sudo to run Docker commands. Continue to Linux postinstall to allow non-privileged users to run Docker commands and for other optional configuration steps.

Upgrade Docker Engine
To upgrade Docker Engine, first run sudo apt-get update, then follow the installation instructions, choosing the new version you want to install.

Install from a package
If you cannot use Docker’s repository to install Docker Engine, you can download the .deb file for your release and install it manually. You need to download a new file each time you want to upgrade Docker.

Go to https://download.docker.com/linux/ubuntu/dists/, choose your Ubuntu version, then browse to pool/stable/, choose amd64, armhf, arm64, or s390x, and download the .deb file for the Docker Engine version you want to install.

Install Docker Engine, changing the path below to the path where you downloaded the Docker package.

 sudo dpkg -i /path/to/package.deb
The Docker daemon starts automatically.

Verify that Docker Engine is installed correctly by running the hello-world image.

 sudo docker run hello-world
This command downloads a test image and runs it in a container. When the container runs, it prints a message and exits.

Docker Engine is installed and running. The docker group is created but no users are added to it. You need to use sudo to run Docker commands. Continue to Post-installation steps for Linux to allow non-privileged users to run Docker commands and for other optional configuration steps.

Upgrade Docker Engine
To upgrade Docker Engine, download the newer package file and repeat the installation procedure, pointing to the new file.

Install using the convenience script
Docker provides a convenience script at get.docker.com to install Docker into development environments quickly and non-interactively. The convenience script is not recommended for production environments, but can be used as an example to create a provisioning script that is tailored to your needs. Also refer to the install using the repository steps to learn about installation steps to install using the package repository. The source code for the script is open source, and can be found in the docker-install repository on GitHub.

Always examine scripts downloaded from the internet before running them locally. Before installing, make yourself familiar with potential risks and limitations of the convenience script:

The script requires root or sudo privileges to run.
The script attempts to detect your Linux distribution and version and configure your package management system for you, and does not allow you to customize most installation parameters.
The script installs dependencies and recommendations without asking for confirmation. This may install a large number of packages, depending on the current configuration of your host machine.
By default, the script installs the latest stable release of Docker, containerd, and runc. When using this script to provision a machine, this may result in unexpected major version upgrades of Docker. Always test (major) upgrades in a test environment before deploying to your production systems.
The script is not designed to upgrade an existing Docker installation. When using the script to update an existing installation, dependencies may not be updated to the expected version, causing outdated versions to be used.
Tip: preview script steps before running

You can run the script with the DRY_RUN=1 option to learn what steps the script will execute during installation:

 curl -fsSL https://get.docker.com -o get-docker.sh
 DRY_RUN=1 sh ./get-docker.sh
This example downloads the script from get.docker.com and runs it to install the latest stable release of Docker on Linux:

 curl -fsSL https://get.docker.com -o get-docker.sh
 sudo sh get-docker.sh
Docker is installed. The docker service starts automatically on Debian based distributions. On RPM based distributions, such as CentOS, Fedora, RHEL or SLES, you need to start it manually using the appropriate systemctl or service command. As the message indicates, non-root users cannot run Docker commands by default.

Use Docker as a non-privileged user, or install in rootless mode?

The installation script requires root or sudo privileges to install and use Docker. If you want to grant non-root users access to Docker, refer to the post-installation steps for Linux. Docker can also be installed without root privileges, or configured to run in rootless mode. For instructions on running Docker in rootless mode, refer to run the Docker daemon as a non-root user (rootless mode).

Install pre-releases
Docker also provides a convenience script at test.docker.com to install pre-releases of Docker on Linux. This script is equivalent to the script at get.docker.com, but configures your package manager to enable the “test” channel from our package repository, which includes both stable and pre-releases (beta versions, release-candidates) of Docker. Use this script to get early access to new releases, and to evaluate them in a testing environment before they are released as stable.

To install the latest version of Docker on Linux from the “test” channel, run:

 curl -fsSL https://test.docker.com -o test-docker.sh
 sudo sh test-docker.sh
Upgrade Docker after using the convenience script
If you installed Docker using the convenience script, you should upgrade Docker using your package manager directly. There is no advantage to re-running the convenience script, and it can cause issues if it attempts to re-add repositories which have already been added to the host machine.

Uninstall Docker Engine
Uninstall the Docker Engine, CLI, Containerd, and Docker Compose packages:

 sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-compose-plugin
Images, containers, volumes, or customized configuration files on your host are not automatically removed. To delete all images, containers, and volumes:

 sudo rm -rf /var/lib/docker
 sudo rm -rf /var/lib/containerd
