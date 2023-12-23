APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=vsk4
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
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
	CGO_ENABLED=0 GOOS=${TARGETOSLINUX} GOARCH=${TARGETARCHARM64} go build -v -o kbot -ldflags "-X="github.com/vsk44/kbot/cmd.appVersion=${VERSION}

linux-amd64: format get
	CGO_ENABLED=0 GOOS=${TARGETOSLINUX} GOARCH=${TARGETARCHAMD64} go build -v -o kbot -ldflags "-X="github.com/vsk44/kbot/cmd.appVersion=${VERSION}

darwin-arm64:
	CGO_ENABLED=0 GOOS=${TARGETOSMACOS} GOARCH=${TARGETARCHARM64} go build -v -o kbot -ldflags "-X="github.com/vsk44/kbot/cmd.appVersion=${VERSION}

darwin-amd64:
	CGO_ENABLED=0 GOOS=${TARGETOSMACOS} GOARCH=${TARGETARCHAMD64} go build -v -o kbot -ldflags "-X="github.com/vsk44/kbot/cmd.appVersion=${VERSION}

windows-arm64:
	CGO_ENABLED=0 GOOS=${TARGETOSWINDOWS} GOARCH=${TARGETARCHARM64} go build -v -o kbot -ldflags "-X="github.com/vsk44/kbot/cmd.appVersion=${VERSION}

windows-amd64:
	CGO_ENABLED=0 GOOS=${TARGETOSWINDOWS} GOARCH=${TARGETARCHAMD64} go build -v -o kbot -ldflags "-X="github.com/vsk44/kbot/cmd.appVersion=${VERSION}

#arm: CGO_ENABLED=0 GOARCH=${TARGETARCHARM64} go build -v -o kbot -ldflags "-X="github.com/vsk44/kbot/cmd.appVersion=${VERSION}


image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETOSLINUX}-${TARGETARCHAMD64}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETOSLINUX}-${TARGETARCHAMD64}

clean:
	docker rmi $$(docker images ${REGISTRY}/${APP} -a -q) -f