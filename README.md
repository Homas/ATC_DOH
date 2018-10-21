# ATC_DOH
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)  

## Overview
ATC_DOH is a container which implements DNS over HTTPS proxy to ActiveTrust Cloud. It can be user with [Intra](https://play.google.com/store/apps/details?id=app.intra&hl=en) DOH client for Android. It may be installed on the same host with DFP (DNS Forwarding Proxy) to enable encryption layer between ATC_DOH host and ATC.
ATC_DOH uses [Let's Encrypt](https://letsencrypt.org/) service to obtain a valid encryption certificate. The certificate should be automatically updated.
<p align="center"><img src="https://github.com/Homas/ATC_DOH/blob/master/ATC_DOH_arch.png"></p>

Below you can see Intra client running on Android which uses ATC_DOH proxy to protect mobile device.
<p align="center"><img src="https://github.com/Homas/ATC_DOH/blob/master/android_protection.png"></p>

You can track blocked requests on the ATC security report.
<p align="center"><img src="https://github.com/Homas/ATC_DOH/blob/master/ATC_sreport.png"></p>

## How to install
To install ATC_DOH you may use prebuilt container available on Docker Hub or built the container yourself.
### GitHub
To built ATC_DOH container execute the following commands:
```
git clone https://github.com/Homas/ATC_DOH.git
cd ATC_DOH
sudo docker build -t pvmdel/atc_doh:latest .
```
### DockerHub
To pull a prebuilt container execute the following command:
```
sudo docker pull pvmdel/atc_doh
```
## How to run
To automatically generate certificates [Let's Encrypt](https://letsencrypt.org/) requires to provide a full domain name and an administrator's email. [Let's Encrypt](https://letsencrypt.org/) rates limit number of certificates generated/regenerated for a domain. Certificates are saved in ```{{{CERT_PATH}}}```. To prevent unauthorized access you may set ```PREFIX``` to an unique string. Before starting a container replace placeholders (```{{{DOMAIN}}}```, ```{{{EMAIL}}}```, ```{{{CERT_PATH}}}```, ```{{{PREFIX}}}```) with the relevant values.
```
sudo docker run -d --name atc_doh --log-driver=syslog --restart always --mount type=bind,source={{{CERT_PATH}}},target=/opt/doh/ssl -p80:80 -p443:443 --log-opt tag="{{.ID}}/{{.Name}}" --env HOST="{{{DOMAIN}}}" --env EMAIL="{{{EMAIL}}}" --env PREFIX="{{{PREFIX}}}" pvmdel/atc_doh:latest
```

## ATC Configuration
You need to add the public IP of your host into ATC Networks and assign a relevant policy. 

## (optional) Intra configuration
In the application settings chose a custom server URL and set it to ```https://{{{DOMAIN}}}/atc```, where ```{{{DOMAIN}}}``` is your domain.

## (optional) Advanced configurations
The advanced configuration can be done in the ```run_doh.sh``` startup script. After changing the startup script you will need to rebuild the container.

### Using DFP or any 3rd party DNS server
Upstream DNS servers are defined by ***upstream*** setting in the doh-server configuration file.

### Using own certificate
You may use your own certificate.  A full certificate chain should be provided in ```{{{CERT_PATH}}}/doh.crt```, a private key stored in ```{{{CERT_PATH}}}/doh.key```. You also may these settings in ```run_doh.sh```. If you are going to use your own certificate, please comment out cron job configuration in ```run_doh.sh```.

## Debug
To debug ATC_DOH you may use:
- Try to resolve a domain suing the following URL: ```https://{{{DOMAIN}}}/atc?name=google.com```
- Check syslog on the host
- To collect the request logs you may set ```verbose=true``` in the ```doh-server``` configuration.
- To access the container you may use the following command ```sudo docker exec -it atc_doh bash```

# DOH Server
ATC_DOH uses opensource [DOH Server](https://github.com/m13253/dns-over-https/)

# License
Copyright 2018 Vadim Pavlov ioc2rpz[at]gmail[.]com

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
You may obtain a copy of the License at  
  
    http://www.apache.org/licenses/LICENSE-2.0  
  
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
