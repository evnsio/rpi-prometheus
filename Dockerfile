FROM golang as build

RUN mkdir -p $GOPATH/src/github.com/prometheus && \
    cd $GOPATH/src/github.com/prometheus && \
    git clone https://github.com/prometheus/prometheus.git && \
    cd prometheus && \
    make build

FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=build /go/src/github.com/prometheus/prometheus/prometheus .
CMD ["./prometheus"]  