APP=$(shell basename $(shell git remote get-url origin)1)
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

linux: format get
	CGO_ENABLED=0 GOOS=${TARGETOSLINUX} GOARCH=${TARGETARCHARM64} go build -v -o kbot -ldflags "-X="github.com/vsk44/kbot/cmd.appVersion=${VERSION}

darwin:
	CGO_ENABLED=0 GOOS=${TARGETOSMACOS} GOARCH=${TARGETARCHARM64} go build -v -o kbot -ldflags "-X="github.com/vsk44/kbot/cmd.appVersion=${VERSION}

windows:
	CGO_ENABLED=0 GOOS=${TARGETOSWINDOWS} GOARCH=${TARGETARCHARM64} go build -v -o kbot -ldflags "-X="github.com/vsk44/kbot/cmd.appVersion=${VERSION}

#arm: CGO_ENABLED=0 GOARCH=${TARGETARCHARM64} go build -v -o kbot -ldflags "-X="github.com/vsk44/kbot/cmd.appVersion=${VERSION}


imagearm:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCHARM64}
	
imageamd:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCHARM64}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCHARM64}

clean:
	docker rmi vsk4/kbot1:v1.0.5-807dc71-arm64