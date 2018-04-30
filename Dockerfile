FROM debian:jessie
RUN apt-get update && apt-get install -y --no-install-recommends \
                        bison \
                        flex \
                        gcc \
                        less \
                        make \
                        man \
                        ncompress \
                        ncurses-dev \
                        wget && \
        apt-get clean && rm -rf /var/lib/apt/lists/*


COPY docker.hints /tmp/docker.hints

RUN wget -O - http://nethack.org/download/3.6.1/nethack-361-src.tgz | \
        tar zxv -C /tmp && \
        cd /tmp/nethack-3.6.1 && \
        mv -i /tmp/docker.hints . && \
        sh sys/unix/setup.sh docker.hints && \
        sed -i -e 's:\(#define SYSCF\>\):/* \1 */:' include/config.h && \
        sed -i -e '/^MANDIR/s:=.*:= /usr/share/man/man6:' doc/Makefile && \
        mkdir -p /usr/share/man/man6 && \
        make all && \
        make install && \
        make manpages && \
        cd /tmp && rm -rf nethack-3.6.1


# for backup
VOLUME ["/data"]
CMD ["/usr/games/nethack"]
