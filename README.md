# Dev Environment


### Prerequisites

What things you need to install the software and how to install them

Install ansible 2.4.0.0
Make sure that `/etc/ansible/ansible.cfg` has roles_path

```
pip install ansible==2.4.0.0 # This should do most of the time.
```

Install Vagrant 1.9.1

```
sudo apt-get remove --auto-remove vagrant
rm -r ~/.vagrant.d
wget https://releases.hashicorp.com/vagrant/1.9.1/vagrant_1.9.1_x86_64.deb
sudo dpkg -i vagrant_1.9.1_x86_64.deb
vagrant version
```

## Deployment

Once you have taken care of the above mentioned prerequisites,
you will find a file `setup.sh` in the directory you pulled.
Make sure the file is executable by issuing the following command.
```sudo chmod +x setup.sh ```

Now all you have to do in execute this script.
```./setup.sh```

This will
	1. Download `ubuntu/trusty64` vagrant box
	2. Provision the vagrant box with ansible script.
	3. Install Java, Jenkins, Docker in the Vagrant box.
	4. Trigger the first build of the Jenkins, which will pull `https://github.com/nagrifetchr/fetchr.git` and launch a docker container on `localhost:8090`
	5. After this on every push that happens on `https://github.com/nagrifetchr/fetchr.git` master branch will trigger a build in Jenkins and replace the running container with the new container.
	
## Authors

* **Hussain Nagri**

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details


## Acknowledgments

* https://github.com/geerlingguy/ansible-vagrant-examples