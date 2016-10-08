#Example:
## 

```
docker run -d --name falcon-graph \
      -h falcon-graph \
      -v /disk/ssd1/:/disk/ssd1/falcon \
      -p 6070:6070 \
      -p 6080:6080 \ 
      -p 6030:6030 \ 
      -p 8433:8433 \
      --link falcon-mysql:db \
       falcon/graph:0.1
```
