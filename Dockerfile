FROM alpine:3.11 as base

FROM base AS builder

RUN apk add --no-cache \
    build-base \
    git

WORKDIR /usr/src
ADD Makefile *.c ./
RUN make

FROM base
COPY --from=builder /usr/src/mdns-repeater /usr/bin/
ENTRYPOINT [ "/usr/bin/mdns-repeater" ]