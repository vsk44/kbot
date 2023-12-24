APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=vsk4
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux
TARGETARCH=arm64
TARGETOSLINUX=linux
TARGETOSMACOS=darwin
TARGETOSWINDOWS=windows
TARGETARCHAMD64=amd64
TARGETARCHARM64=arm64

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get:
	go get

linux-arm64: format get
	TARGETOS=${TARGETOSLINUX} TARGETARCH=${TARGETARCHARM64} CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X=github.com/vsk44/kbot/cmd.appVersion=${VERSION}"

linux-amd64: format get
	TARGETOS=${TARGETOSLINUX} TARGETARCH=${TARGETARCHAMD64} CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X=github.com/vsk44/kbot/cmd.appVersion=${VERSION}"

darwin-arm64:
	TARGETOS=${TARGETOSMACOS} TARGETARCH=${TARGETARCHARM64} CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X=github.com/vsk44/kbot/cmd.appVersion=${VERSION}"

darwin-amd64:
	TARGETOS=${TARGETOSMACOS} TARGETARCH=${TARGETARCHAMD64} CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X=github.com/vsk44/kbot/cmd.appVersion=${VERSION}"

windows-arm64:
	TARGETOS=${TARGETOSWINDOWS} TARGETARCH=${TARGETARCHARM64} CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X=github.com/vsk44/kbot/cmd.appVersion=${VERSION}"

windows-amd64:
	TARGETOS=${TARGETOSWINDOWS} TARGETARCH=${TARGETARCHAMD64} CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X=github.com/vsk44/kbot/cmd.appVersion=${VERSION}"

build:
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X=github.com/vsk44/kbot/cmd.appVersion=${VERSION}"

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}

clean:
	docker rmi $$(docker images ${REGISTRY}/${APP} -a -q) -f
