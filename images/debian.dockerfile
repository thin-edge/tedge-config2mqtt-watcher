FROM ghcr.io/thin-edge/tedge-demo-main-systemd:latest
 
# install plugins
COPY ./dist/*.deb /tmp/
RUN sudo apt-get install -y /tmp/*.deb \
    && rm -f /tmp/*.deb
