FROM ubuntu:focal

# Copy in requried files
RUN mkdir /default
COPY ./config.yml /default
COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

# Update and install utilities
RUN apt update && \
    apt install -y wget && \
    apt upgrade -y

RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && \
    apt install -y ./cloudflared-linux-amd64.deb

# Setup configuration
RUN useradd -u 10000 red
RUN mkdir /etc/cloudflared
RUN chown red:red /etc/cloudflared

EXPOSE 5053

USER red
ENTRYPOINT [ "/entrypoint.sh" ]