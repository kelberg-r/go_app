FROM golang:1.16

WORKDIR /goapp

ADD . /goapp

ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update
RUN apt upgrade -y

RUN apt install -y sqlite3 libsqlite3-dev
RUN go env -w GO111MODULE=auto

RUN go get -d -v ./...
RUN cat schema.sql | sqlite3 tasks.db
RUN go build
 
ENTRYPOINT ./goapp
