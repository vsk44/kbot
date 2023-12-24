# syntax=docker/dockerfile:1.0.0-experimental

ARG TARGETOS
ARG TARGETARCH

FROM golang:1.20 as builder

WORKDIR /go/src/app
COPY . .
RUN make get

# Використовуйте ARG для визначення ОС та архітектури під час збірки
RUN make ${TARGETOS}-${TARGETARCH}

FROM alpine:latest
WORKDIR /
COPY --from=builder /go/src/app/kbot .
ENTRYPOINT ["./kbot", "start"]
