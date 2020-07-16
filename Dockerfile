FROM golang:alpine AS build-env
WORKDIR /go/src
COPY . /go/src/welcome-app
RUN cd /go/src/welcome-app && go build .

FROM alpine
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk*
WORKDIR /app
COPY --from=build-env /go/src/welcome-app/welcome-app /app
COPY --from=build-env /go/src/welcome-app/templates /app/templates
COPY --from=build-env /go/src/welcome-app/static /app/static

EXPOSE 8080
ENTRYPOINT [ "./welcome-app" ]