FROM nvidia/opencl:runtime-ubuntu16.04

ARG FAH_VERSION_MAJOR=7.5
ARG FAH_VERSION_MINOR=1

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
      && apt-get install --no-install-recommends -y \
        curl bzip2 ca-certificates \
        clinfo ocl-icd-opencl-dev ocl-icd-libopencl1 \
      && curl -o /tmp/fah.deb https://download.foldingathome.org/releases/public/release/fahclient/debian-stable-64bit/v${FAH_VERSION_MAJOR}/fahclient_${FAH_VERSION_MAJOR}.${FAH_VERSION_MINOR}_amd64.deb \
      && dpkg -i --force-depends /tmp/fah.deb \
      && rm -f /tmp/fah.deb \
      && apt-get autoremove -y \
      && rm --recursive --verbose --force /tmp/* /var/log/* /var/lib/apt/

RUN curl http://fah-web.stanford.edu/file-releases/public/GPUs.txt -o /var/lib/fahclient/GPUs.txt
COPY config.xml /etc/fahclient/config.xml

# Web viewer
EXPOSE 7396

ENV FAH_USER=Anonymous
ENV FAH_TEAM=243328
ENV FAH_GPU=true
ENV FAH_SMP=true
ENV FAH_POWER=full

ENTRYPOINT ["FAHClient", "--web-allow=0/0:7396", "--allow=0/0:7396"]
CMD ["--user=${FAH_USER}", "--team=${FAH_TEAM}", "--gpu=${FAH_GPU}", "--smp=${FAH_POWER}", "--power=FAH_POWER"]

