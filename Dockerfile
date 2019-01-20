FROM alpine as build-env

RUN apk update && apk add crystal shards build-base libressl-dev zlib-dev

ADD . /app
WORKDIR /app
ARG SHARDS_BUILD_OPTIONS
RUN shards build --link-flags="-static" $SHARDS_BUILD_OPTIONS


FROM alpine

COPY --from=build-env /app/bin/ss_property_catalogue /ss_property_catalogue

ENTRYPOINT ["/ss_property_catalogue"]
