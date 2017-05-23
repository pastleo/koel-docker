Koel docker image
===================

This example is used with a caddy server

## How to use?

Clone this repo 

```
git clone https://github.com/pastleo/koel-docker.git koel
cd koel
```

and the koel source if you want to build own your own
visit https://koel.phanan.net/docs/#/?id=installation for more info

```
git clone https://github.com/phanan/koel.git app 
cd app
git checkout v3.4.0
```

Copy the example config

```
cp .env.example .env
cp docker-compose.example.yml docker-compose.yml # and 
```

edit it on your own choice, then you should be good to go:

```
docker-compose up
```

## Sync media

Remember to set the `KOEL_MEDIA_PATH` in the `.env`, then:

```
docker-compose exec koel sync_media.sh
```

