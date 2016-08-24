FROM alpine:3.4
MAINTAINER Janis Meybohm <meybohm@traum-ferienwohnungen.de>

ENV GOPATH /go

RUN apk add --update -t .build-deps go git make \
    && mkdir /logs \
    && git clone https://github.com/google/mtail.git $GOPATH/src/github.com/google/mtail \
    && cd $GOPATH/src/github.com/google/mtail && make \
    && cp $GOPATH/bin/mtail /bin/mtail \
    && cp -r $GOPATH/src/github.com/google/mtail/examples /progs \
    && apk del --purge .build-deps \
    && rm -rf /go /var/cache/apk/*

COPY progs/* /progs/

EXPOSE 3903

ENTRYPOINT [ "/bin/mtail", "-logtostderr" ]
