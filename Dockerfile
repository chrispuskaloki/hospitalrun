FROM ubuntu 16.04
LABEL maintainer Sammy Juma <awscloudacademy>

#Get required applications
#ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y git

#Create App Directory
WORKDIR /usr/src/hospitalrun

#Install Dependencies
COPY package.json /usr/src/hospitalrun
RUN npm install --loglevel silent

COPY . /usr/src/hosptialrun
COPY conf/entrypoint.sh .
#Setup the DB with initial user
RUN chmod +x conf/initcouch.sh entrypoint.sh
COPY config-example.js config.js

EXPOSE 3000

ENTRYPOINT ./entrypoint.sh
