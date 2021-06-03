FROM asciidoctor/docker-asciidoctor AS build
WORKDIR /build
COPY . .
RUN asciidoctor -b html5 -R . -D . '**/*.adoc'
RUN find . -name "*.adoc" -type f -delete

FROM nginx AS deploy
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /build/ /usr/share/nginx/html
