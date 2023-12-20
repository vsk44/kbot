FROM golang:1.20 as builder

ENV TELE_TOKEN="6501274149:AAFzdI-BOYo8-KDyB4evgMDsV_r2ElTHB-4"
WORKDIR /go/src/app
COPY . .
RUN make get
#works for linux, windows, darwin
RUN make linux 

FROM scratch
WORKDIR /
COPY --from=builder /go/src/app/kbot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
# ENTRYPOINT ["./kbot"]