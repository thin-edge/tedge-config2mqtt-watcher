FROM ghcr.io/thin-edge/tedge-demo-main-systemd:20231221.1
 
# install plugins
COPY ./dist/*.deb /tmp/
RUN sudo apt-get install -y /tmp/*.deb \
    && rm -f /tmp/*.deb
