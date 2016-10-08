### 

###need mkdir /disk/ssd1/falcon 

### docker build images

```
docker build -t falcon/query:0.1
```

### docker run  example:

```
docker run -d --name falcon-query \
           -h falcon-query \
           -p 8081:8081 \
           -p 5050:5050 \
           -p 9966:9966 \
           -v /disk/ssd1/falcon:/date/falcon \
           --link falcon-mysql:falcon-mysql \
           --link falcon-graph:falcon-graph \
           falcon/query:0.1

```
