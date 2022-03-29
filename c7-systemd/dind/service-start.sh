#!/bin/sh
set -e

docker-compose -f ./fastdfs/docker-compose.yml up -d
docker-compose -f ./mongo/docker-compose.yml up -d
docker-compose -f ./mysql/docker-compose.yml up -d
docker-compose -f ./redis/docker-compose.yml up -d
docker-compose -f ./kafka/docker-compose.yml up -d
docker-compose -f ./nacos/docker-compose.yml up -d
docker-compose -f ./sentinel/docker-compose.yml up -d
docker-compose -f ./sonarqube/docker-compose.yml up -d
docker-compose -f ./storm/docker-compose.yml up -d