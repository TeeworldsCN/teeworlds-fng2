FROM sirius1242/bam:alpine3.4 AS builder
WORKDIR /teeworlds-fng2
COPY . .
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk update && apk upgrade && apk add mariadb-dev
RUN bam config && bam server_release

FROM alpine:3.4
WORKDIR /srv
COPY --from=builder /teeworlds-fng2/fng2_srv .
COPY --from=builder /teeworlds-fng2/data/maps/ maps
COPY --from=builder /usr/lib/libgcc_s.so.1 /usr/lib/libstdc++.so.6 /usr/lib/libmysqlclient.so.18 /lib/libssl.so.1.0.0 /lib/libcrypto.so.1.0.0 /usr/lib/
CMD ["./fng2_srv"]
