FROM python:2.7.16-alpine3.9

RUN apk --no-cache add \
    build-base \
    gfortran \
    openblas-dev \
    ;

RUN pip install --no-cache-dir numpy
RUN pip install --no-cache-dir scipy
RUN pip install --no-cache-dir scikit-learn
RUN pip install --no-cache-dir annoy

WORKDIR /app
COPY . /app/

CMD ["python", "server.py", "--glove", "data/sgram.txt", "--port", "8080"]
# CMD python server.py --glove data/sgram.txt --port 8080