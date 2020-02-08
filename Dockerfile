FROM ubuntu:16.04

RUN apt-get update -y && \
    apt-get install -y python3-pip python3

# We copy just the requirements.txt first to leverage Docker cache
COPY ./requirements.txt /app/requirements.txt

WORKDIR /app

RUN pip3 install -r requirements.txt

COPY . /app

ENV PORT 8080
EXPOSE 5000

ENTRYPOINT [ "python" ]

CMD [ "server.py" ]