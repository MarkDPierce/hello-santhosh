# Notice the AS builder
# This defines this layer for later use
# https://hub.docker.com/_/golang
FROM golang:1.22.2-alpine AS builder

WORKDIR /workspace
ADD . .
RUN go build -o /bin/hello-santhosh

##################################################
# I am doing it this way to help demonstrate docker image layering
##################################################
FROM gcr.io/distroless/static
COPY --from=builder /bin/hello-santhosh /bin/hello-santhosh
USER nonroot
EXPOSE 8080
ENTRYPOINT ["/bin/hello-santhosh"]