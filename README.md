# ATC_DOH

https://ipvm.biz/atc?name=google.com

```
sudo docker build -t pvmdel/atc_doh:latest .
sudo docker run -d --name doh.ioc2rpz.com --log-driver=syslog --restart always --mount type=bind,source=/opt_data/doh,target=/opt/doh/ssl -p80:80 -p443:443 --log-opt tag="{{.ID}}/{{.Name}}" --env HOST="doh.ioc2rpz.net" --env EMAIL="pvm_job@mail.ru" pvmdel/atc_doh:latest	
sudo docker exec -it doh.ioc2rpz.com bash
sudo docker stop doh.ioc2rpz.com
sudo docker rm doh.ioc2rpz.com

sudo docker run -it --entrypoint=bash -p80:80 -p443:443 --env HOST="doh.ioc2rpz.net" --env EMAIL="pvm_job@mail.ru" pvmdel/atc_doh
```

# DOH Server
https://github.com/m13253/dns-over-https/

Tutorial  
https://www.aaflalo.me/2018/10/tutorial-setup-dns-over-https-server/