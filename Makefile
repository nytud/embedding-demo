setup:
	@[ -d 'venv/' ] || virtualenv -p /usr/bin/python2 venv
	@./venv/bin/pip2 install -r requirements.txt
	@gunzip -k data/*.gz
.PHONY: setup


run:
	./venv/bin/python2 server.py --glove data/sgram.txt  --port 8080
.PHONY: run
