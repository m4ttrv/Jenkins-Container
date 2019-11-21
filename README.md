# Jenkins Instance on AWS


## Installing

1. Create AWS instance with storage.
   `Use t2.large`

2. Grab Public DNS name - you'll need later - eg. ec2-52-18-139-14.eu-west-1.compute.amazonaws.com

3. Connect to instance via bash
   1. Copy **pem** from laptop to workspace 
   2. Check file extension if you cannot find file, needs to be .pem

Example connection:  `ssh -i /d/Users/AccountAdmin/Documents/Linux_EC2.pem ec2-user@ec2-52-18-139-14.eu-west-1.compute.amazonaws.com`

If you haven't got a pem, follow
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html

4. Run the following:

`sudo yum update -y`

`sudo yum install -y docker`

`sudo yum install -y jenkinsjenkins :2.190.2` 

`sudo yum install -y portainer`

`sudo usermod -aG docker ec2-user`

`sudo service docker start`

5. logout of session to pick up new group. Ready for docker

6. SSH back into the Linux EC2

`sudo yum install git -y`

7. Save git creds so they persist

`git config --global credential.helper store`

8. Connect to CodeCommit

`git clone https://git-codecommit.eu-west-1.amazonaws.com/v1/repos/YOUR_REPO_NAME`

9. Install compose

`sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose`

`sudo chmod +x /usr/local/bin/docker-compose`


## Portainer Container Install

1. Start a Portainer Instance.

`docker volume create portainer_data`

`docker run -d -p 9000:9000 -p 8000:8000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer`

`docker logs portainer`

`sudo docker ps -a`

Portainer container should now be started on port 9000 - you may need to view it via IP on you Instance in AWS


## Basic Jenkins Container Install

1. Install Basic Jenkins with the following command, to get to grips with it, or install plugin rich version below.

`docker pull jenkins`
`docker run -d --name=Jenkins -p 8080:8080 -p 50000:50000 -v /var/jenkins_home jenkins/jenkins:2.190.2`

2. Check it's up via

`sudo docker ps`

or 	`sudo docker ps -a`  - to list all containers on Instance  

3. Jenkins container should now be started on port 8080 - you may need to view it via IP on you Instance in AWS
4. Find Admin Password should be available with the following command

`docker exec Jenkins bash -c "cat /var/jenkins_home/secrets/initialAdminPassword"`


## Full Jenkins Container Install

1. Make sure your in the correct location in order to start your compose command.  Should be something similar to 

   `cd home/ec2-user/MattRV/`

   Within this folder there should be the following files;

   `docker-compose.yml`

   `Dockerfile`

   `plugins.txt`

   and these instructions.

2. Install the fuller version of Jenkins with the following command.

`docker compose up -d --build`

3. Check it's up via

`sudo docker ps`

or 	`sudo docker ps -a`  - to list all containers on Instance  

3. Jenkins container should now be started on port 8080 - you may need to view it via IP on you Instance in AWS
4. Find Admin Password should be available with the following command

`docker exec Jenkins bash -c "cat /var/jenkins_home/secrets/initialAdminPassword"`



## Tips

To take down an instance `docker-compose down -v`

To remove unneeded docker images `docker image prune`

To view logs `docker logs jenkins`
