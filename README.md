# docker-dante

Copied from https://github.com/ofkindness/docker-dante and modified a bit.

Don't forget to change user name and password in Dockerfile.

To build:
```
docker build -t dante-socks .
```

And then to run:
```
docker run -d -p 1080:1080 dante-socks
```
