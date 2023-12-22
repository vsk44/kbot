FROM golang:1.20 as builder

WORKDIR /go/src/app
COPY . .
RUN make get
#works for linux, windows, darwin
RUN make linux 

FROM alpine:latest
WORKDIR /
COPY --from=builder /go/src/app/kbot .
# COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT ["./kbot", "start"]