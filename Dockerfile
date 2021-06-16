FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.utf8 
RUN apt-get update && apt-get install -y \
    locales nginx-light \
	curl jq less lsof net-tools sudo tmux nano \
	&& rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
	&& rm -rf /etc/nginx/sites-enabled/default \
    && ln -sf /etc/nginx/sites-available/grafana /etc/nginx/sites-enabled/grafana
COPY ./grafana /etc/nginx/sites-available
COPY ./startup.sh /
EXPOSE 80/tcp
CMD ["/startup.sh"]
