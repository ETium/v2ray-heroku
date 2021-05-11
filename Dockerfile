FROM alpine:3.5
RUN apk add --no-cache ca-certificates curl unzip wget
ADD configure.sh /configure.sh
RUN chmod +x /configure.sh
CMD /configure.sh
