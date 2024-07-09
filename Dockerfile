FROM alpine:latest

ARG PCMS_VERSION=0.1.6

RUN apk add --no-cache \
    unzip \
    ca-certificates

# download and unzip PocketBase
ADD https://github.com/parkuman/pocketcms/releases/download/v${PCMS_VERSION}/pocketcms_${PCMS_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/

ENV HOST 0.0.0.0
ENV PORT 8080
ENV GCS_MOUNT /cloud/storage

# start PocketBase
EXPOSE 8080
CMD ["/bin/sh", "-c", "/pb/pocketbase serve --http=0.0.0.0:8080 --dir=${GCS_MOUNT}/pb_data --publicDir=${GCS_MOUNT}/pb_public --hooksDir=${GCS_MOUNT}/pb_hooks"]
