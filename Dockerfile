FROM ghcr.io/gohugoio/hugo:latest AS hugo
USER root
ADD . /source
RUN hugo build -s /source -d /target

FROM nginx
COPY --from=hugo /target /usr/share/nginx/html
