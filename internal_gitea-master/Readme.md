# Hosting gitea + HTTPS(TLS) with docker-compose

## Summary
Hosting a private internal git repository with HTTPS (TLS)  
The git repository is gitea running in docker.  
It provides basic git operation.  

For TLS, we use NGINX reverse proxy setup to offer HTTPS protocol of our git repository service.  
This design can be reused in any other HTTP application for POC/unit testing.  

## Preparation
Install docker, docker-compose in a Ubuntu box  
Reference : https://docs.docker.com/engine/install/ubuntu/  
For other platforms, please check official docker page.
```
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update -y
sudo apt-get -y install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -a -G ssm-user
```


## Steps:
1) Setup the self signed certificate with easy-rsa
In the given script, we register a domain "internal.bcorp.com".  
git repository takes domain name of "gitea.internal.bcorp.com"
```
make create_self_signed_tls
```
You will find in folder ./cert:
- self signed certificate/key (gitea.internal.bcorp.com)
- local CA (internal.bcorp.com) 

Then, register ./cert/ca.crt to your local trusted CA bundle.  

2) Bring up the service
```
docker-compose up -d
```
3) Access the service
Open a browser, access https://gitea.internal.bcorp.com

3) Shutdown the service
```
docker-compose down
```