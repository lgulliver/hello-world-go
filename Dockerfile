FROM golang:alpine AS build-env
WORKDIR /hello-world-go
COPY . /hello-world-go
RUN cd /hello-world-go && go build . && ls

FROM alpine
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk*
WORKDIR /app
COPY --from=build-env /hello-world-go/hello-world-go /app
COPY --from=build-env /hello-world-go/templates /app/templates
COPY --from=build-env /hello-world-go/static /app/static

EXPOSE 8080
ENTRYPOINT [ "./hello-world-go" ]