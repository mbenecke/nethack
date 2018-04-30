FROM alpine

RUN \
  apk --no-cache add byacc curl flex gcc groff linux-headers make musl-dev ncurses-dev util-linux && \
  curl -sL http://nethack.org/download/3.6.1/nethack-361-src.tgz | tar zxf - && \
  ( \
    cd nethack-3.6.1 && \
    sed -i -e 's/cp -n/cp/g' -e '/^PREFIX/s:=.*:=/usr:' sys/unix/hints/linux && \
    sh sys/unix/setup.sh sys/unix/hints/linux && \
    make all && \
    make install \
  ) && \
  rm -rf nethack-3.6.1

# for backup

VOLUME ["/data"]
CMD ["/usr/games/nethack"]
