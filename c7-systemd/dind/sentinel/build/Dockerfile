FROM openjdk:8u282-jre-buster
MAINTAINER zhoutaoo "zhoutaoo@foxmail.com"

ARG SENTINEL_DASHBOARD_VERSION=1.6.3
ARG SENTINEL_SERVER_PORT=8021

# set environment
ENV BASE_DIR="/home/sentinel" \
    SENTINEL_DASHBOARD_VERSION=${SENTINEL_DASHBOARD_VERSION} \
    SENTINEL_SERVER_PORT=${SENTINEL_SERVER_PORT} \
    DASHBOARD_SERVER="localhost:${SENTINEL_SERVER_PORT}" \
    PROJECT_NAME="sentinel-dashboard" \
    JAVA_OPTS="" \
    TIME_ZONE="Asia/Shanghai"

WORKDIR /$BASE_DIR

RUN set -x \
    && apt-get install -y ca-certificates wget \
    && update-ca-certificates \
    && wget https://github.com/alibaba/Sentinel/releases/download/${SENTINEL_DASHBOARD_VERSION}/sentinel-dashboard-${SENTINEL_DASHBOARD_VERSION}.jar -P $BASE_DIR \
    && ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo '$TIME_ZONE' > /etc/timezone

ADD bin/docker-entrypoint.sh bin/docker-entrypoint.sh

# set startup log dir
RUN mkdir -p logs \
	&& cd logs \
	&& touch start.out \
	&& ln -sf /dev/stdout start.out \
	&& ln -sf /dev/stderr start.out
RUN chmod +x bin/docker-entrypoint.sh

ENTRYPOINT ["bin/docker-entrypoint.sh"]
