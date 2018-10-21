# ATC_DOH
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)  

## Overview
ATC_DOH is a containter which implements DNS over HTTPS proxy to ActiveTrust Cloud. It can be user with [Intra](https://play.google.com/store/apps/details?id=app.intra&hl=en) DOH client for Android.
<p align="center"><img src="https://github.com/Homas/ATC_DOH/blob/master/ATC_DOH_arch.png"></p>
<p align="center"><img src="https://github.com/Homas/ATC_DOH/blob/master/android_protection.png"></p>
<p align="center"><img src="https://github.com/Homas/ATC_DOH/blob/master/ATC_sreport.png"></p>

## How to intall
### GitHub
```
git clone https://github.com/Homas/ATC_DOH.git
cd ATC_DOH
sudo docker build -t pvmdel/atc_doh:latest .
```

### DockerHub
```
sudo docker pull pvmdel/atc_doh
```

## How to run

https://letsencrypt.org/
***DOMAIN***
***EMAIL***
***CERT_PATH***


```
sudo docker run -d --name atc_doh --log-driver=syslog --restart always --mount type=bind,source=***CERT_PATH***,target=/opt/doh/ssl -p80:80 -p443:443 --log-opt tag="{{.ID}}/{{.Name}}" --env HOST="***DOMAIN***" --env EMAIL="***EMAIL***" pvmdel/atc_doh:latest
```

## Debug

```https://***DOMAIN***/atc?name=google.com```
hosts syslog
verbose
```sudo docker exec -it atc_doh bash```


# DOH Server
https://github.com/m13253/dns-over-https/

Tutorial  
https://www.aaflalo.me/2018/10/tutorial-setup-dns-over-https-server/

# License
Copyright 2018 Vadim Pavlov ioc2rpz[at]gmail[.]com

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
You may obtain a copy of the License at  
  
    http://www.apache.org/licenses/LICENSE-2.0  
  
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
