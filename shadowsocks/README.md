## shadowsocks install



### required
> 需要开启母机 ip_forward 

`echo 1 > /proc/sys/net/ipv4/ip_forward`


### 构建容器
`docker build -t docker-shadows .`


### 跑起容器

` docker run -d --name shaodwsocks -p 8888:8888 -p 8889:8889 docker-shadows`
