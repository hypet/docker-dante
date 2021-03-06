FROM alpine:3.7 AS builder

ENV DANTE_VERSION 1.4.2

RUN apk add --no-cache curl gcc g++ make

RUN mkdir -p /usr/src

RUN cd /usr/src \
    && curl -O http://www.inet.no/dante/files/dante-$DANTE_VERSION.tar.gz \
    && tar xvfz dante-$DANTE_VERSION.tar.gz

RUN cd /usr/src/dante-$DANTE_VERSION \
    && ac_cv_func_sched_setscheduler=no ./configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --disable-client \
    --without-libwrap \
    --without-bsdauth \
    --without-gssapi \
    --without-krb5 \
    --without-upnp \
    --without-pam \
    && make && make install

FROM alpine:3.7

COPY --from=builder /usr/sbin/sockd  /usr/sbin/

COPY sockd.conf /etc/

RUN printf 'password\npassword\n' | adduser user

EXPOSE 1080

CMD ["sockd", "-N", "8"]
