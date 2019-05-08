setup:
	@[ -d 'venv/' ] || virtualenv -p /usr/bin/python2 venv
	@./venv/bin/pip2 install -r requirements.txt
	@gunzip -k data/*.gz
.PHONY: setup


run:
	./venv/bin/python2 server.py --glove data/sgram.txt  --port 8080
.PHONY: run


## build docker image
dbuild:
	docker build -t embedding-demo:latest .
.PHONY: dbuild


## run docker container in background
drun:
	@make -s dstop
	@myport=$$(./freeportfinder.sh) ; \
		if [ -z "$${myport}" ] ; then echo 'ERROR: no free port' ; exit 1 ; fi ; \
		docker run --name embeddingdemo -p $${myport}:8080 --rm -d embedding-demo:latest ; \
		echo "OK: embeddingdemo run on port $${myport}" ;
.PHONY: drun


# connect container that is already running
dconnect:
	@if [ "$$(docker container ls -f name=embeddingdemo -q)" ] ; then \
		docker exec -it embeddingdemo /bin/sh ; \
	else \
		echo 'no running embeddingdemo container' ; \
	fi
.PHONY: dconnect


## stop running container
dstop:
	@if [ "$$(docker container ls -f name=embeddingdemo -q)" ] ; then \
		docker container stop embeddingdemo ; \
	else \
		echo 'no running embeddingdemo container' ; \
	fi
.PHONY: dstop


## delete unnecessary containers and images
dclean:
	@docker container prune -f
	@docker image prune -f
.PHONY: dclean
