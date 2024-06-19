FROM registry.access.redhat.com/ubi9/go-toolset:1.21.10-1 AS build
COPY go.mod go.sum ./
RUN go mod download
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o ./docker-gs-ping

FROM registry.access.redhat.com/ubi9/ubi-minimal:9.4-1134
COPY --from=build /opt/app-root/src/docker-gs-ping .
USER 65532:65532
EXPOSE 8080
CMD ["/docker-gs-ping"]