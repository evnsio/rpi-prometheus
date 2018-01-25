# Build stage
FROM golang as build
RUN mkdir -p $GOPATH/src/github.com/prometheus && \
    cd $GOPATH/src/github.com/prometheus && \
    git clone https://github.com/prometheus/prometheus.git && \
    cd prometheus

# This is a bit of hack to get the build working on arm64 architecture
# promu make target doesn't work so we pull in the binary and remove the
# reference to promu from the build target
COPY ./bin/promu $GOPATH/bin/promu
WORKDIR $GOPATH/src/github.com/prometheus/prometheus
RUN sed -i.bak 's/build\: promu/build\:/g' Makefile
RUN make build

# Final Image
FROM alpine:latest
WORKDIR /bin/
COPY --from=build /go/src/github.com/prometheus/prometheus/prometheus .
COPY --from=build /go/src/github.com/prometheus/prometheus/promtool .
ENTRYPOINT ["/bin/prometheus"]
