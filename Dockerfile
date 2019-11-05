FROM centos

RUN yum upgrade -y \
    && yum install -y epel-release \
    && yum install -y \
      wget \
    && yum clean all

RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64
RUN chmod +x /usr/local/bin/dumb-init

RUN yum install -y http://files.freeswitch.org/freeswitch-release-1-6.noarch.rpm \
  && yum install -y \
    freeswitch \
    opus \
    ilbc2 \
    ilbc \
    g722_1 \
    freeswitch-xml-curl \
    freeswitch-xml-cdr \
    freeswitch-sounds-music-48000 \
    freeswitch-sounds-music-32000 \
    freeswitch-sounds-music-16000 \
    freeswitch-sounds-music-8000 \
    freeswitch-sounds-music \
    freeswitch-sounds-en-us-callie-all \
    freeswitch-sounds-en-ca-june-all \
    freeswitch-python \
    freeswitch-lua \
    freeswitch-lang-en \
    freeswitch-lang-de \
    freeswitch-format-tone-stream \
    freeswitch-format-native-file \
    freeswitch-format-local-stream \
    freeswitch-event-json-cdr \
    freeswitch-event-format-cdr \
    freeswitch-event-cdr-sqlite \
    freeswitch-endpoint-rtc \
    freeswitch-endpoint-dingaling \
    freeswitch-codec-theora \
    freeswitch-codec-passthru-g729 \
    freeswitch-codec-passthru-g723_1 \
    freeswitch-codec-passthru-amrwb \
    freeswitch-codec-passthru-amr \
    freeswitch-codec-opus \
    freeswitch-codec-mp4v \
    freeswitch-codec-isac \
    freeswitch-codec-ilbc \
    freeswitch-codec-h26x \
    freeswitch-codec-codec2 \
    freeswitch-application-voicemail-ivr \
    freeswitch-application-voicemail \
    freeswitch-application-valet_parking \
    freeswitch-application-translate \
    freeswitch-application-snom \
    freeswitch-application-limit \
    freeswitch-application-lcr \
    freeswitch-application-httapi \
    freeswitch-application-fifo \
    freeswitch-application-enum \
    freeswitch-application-easyroute \
    freeswitch-asrtts-flite \
    freeswitch-application-db \
    freeswitch-application-curl \
    freeswitch-application-conference \
    freeswitch-application-callcenter \
    freeswitch-application-blacklist \
  && yum clean all

RUN usermod -u 5060 freeswitch \
  && chown -R freeswitch /var/run/freeswitch

EXPOSE 5060/tcp 5060/udp 5061 5080/tcp 5081/udp
EXPOSE 64535-65535/udp

VOLUME ["/etc/freeswitch", "/var/lib/freeswitch"]

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
CMD ["/usr/bin/freeswitch", "-u freeswitch"]
