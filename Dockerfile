FROM golang:alpine as builder
WORKDIR /burrow_exporter
COPY . /burrow_exporter
RUN go build -o /tmp/burrow-exporter

FROM alpine
COPY --from=builder /tmp/burrow-exporter ./
ENV BURROW_ADDR http://localhost:8000
ENV METRICS_ADDR 0.0.0.0:8080
ENV INTERVAL 30
ENV API_VERSION 3
CMD ./burrow-exporter --burrow-addr $BURROW_ADDR --metrics-addr $METRICS_ADDR --interval $INTERVAL --api-version $API_VERSION
