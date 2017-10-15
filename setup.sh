#!/bin/bash
JENKINS_REMOTE_TOKEN="RBs3NFqBp3sSLTC3gKBeYJIfvKbwmbAv"
echo "Make sure Vagrant is at Version: 1.9.1
Make sure you have ansible 2.4.0.0 Installed
make sure you have appended the path $(pwd)/provisioning/roles in file
/etc/ansible/ansible.cfg on variable roles_path.
This will take ~10-15 minutes. So sit back, relax. Maybe have some coffee.. :)
Provisioning Vagrant for you."
vagrant up --provision 
echo "Reloading Vagrant for you."
vagrant reload
JENKINS_STATUS=$(curl -I localhost:8080 2>/dev/null | head -n 1 | cut -d' ' -f2)
OK_STATUS=200
while [ "$OK_STATUS" != "$JENKINS_STATUS" ]
do
  sleep 30
  echo "Checking if Jenkins came up...."
  JENKINS_STATUS=$(curl -I localhost:8080 2>/dev/null | head -n 1 | cut -d' ' -f2)
done
echo "Jenkins came up."
echo "Initializing first container."
curl localhost:8080/job/fetchr-CI/build?token=$JENKINS_REMOTE_TOKEN
echo "Checking Status of application....."
STATUS=$(curl -I localhost:8090 2>/dev/null | head -n 1 | cut -d' ' -f2)
echo "You can visit http://localhost:8080/job/fetchr-CI/3/console for a more graphical view."
while [ "$OK_STATUS" != "$STATUS" ]
do
  sleep 30
  CASE_NUM=$(shuf -i 0-5 -n 1)
  case $CASE_NUM in
	1)
		echo "Still Checking..."
		;;
	2)
		echo "It is taking time. Please wait."
		;;
	3)
		echo "You can visit http://localhost:8080/job/fetchr-CI/3/console for a more graphical view."
		;;
	4)
		echo "Dont go anywhere. It will be done soon."
		;;
	*)
		echo "Just some more time."
		;;
  esac
  STATUS=$(curl -I localhost:8090 2>/dev/null | head -n 1 | cut -d' ' -f2)
done
echo "Docker container is up and runnning."
echo "You may want to check localhost:8090 to see your application runnning"
