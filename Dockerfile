FROM golang:alpine AS build-env
COPY . /welcome-app
RUN cd /welcome-app && go build .

FROM alpine
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk*
WORKDIR /app
COPY --from=build-env /welcome-app/welcome-app /app
COPY --from=build-env /welcome-app/templates /app/templates
COPY --from=build-env /welcome-app/static /app/static

EXPOSE 8080
ENTRYPOINT [ "./welcome-app" ]