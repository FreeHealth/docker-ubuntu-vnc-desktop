FROM ubuntu:16.04
MAINTAINER Jerome Pinguet <jerome@jerome.cc>

ENV DEBIAN_FRONTEND noninteractive

# built-in packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends software-properties-common curl \
    && add-apt-repository ppa:fcwu-tw/ppa \
    && apt-get update \
    && apt-get install -y --no-install-recommends --allow-unauthenticated \
        supervisor
RUN apt-get install -y --no-install-recommends --allow-unauthenticated \
        openssh-server
RUN apt-get install -y --no-install-recommends --allow-unauthenticated \
        sudo
RUN apt-get install -y --no-install-recommends --allow-unauthenticated \
        vim-tiny
RUN apt-get install -y --no-install-recommends --allow-unauthenticated \
        net-tools
RUN apt-get install -y --no-install-recommends --allow-unauthenticated \
        lxde
RUN apt-get install -y --no-install-recommends --allow-unauthenticated \
        x11vnc
RUN apt-get install -y --no-install-recommends --allow-unauthenticated \
        xvfb
RUN apt-get install -y --no-install-recommends --allow-unauthenticated \        
        nginx
RUN apt-get install -y --no-install-recommends --allow-unauthenticated \
        python-pip
RUN apt-get install -y --no-install-recommends \
        python-dev
RUN apt-get install -y --no-install-recommends \
        build-essential
RUN apt-get install -y --no-install-recommends \
        mesa-utils
RUN apt-get install -y --no-install-recommends \
        libgl1-mesa-dri
RUN apt-get install -y --no-install-recommends --allow-unauthenticated \
        dbus-x11
RUN apt-get install -y --no-install-recommends \
        x11-utils
RUN apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*


# tini for subreap                                   
ENV TINI_VERSION v0.9.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /bin/tini
RUN chmod +x /bin/tini

ADD image /
RUN pip install setuptools wheel && pip install -r /usr/lib/web/requirements.txt

EXPOSE 80
WORKDIR /root
ENV HOME=/home/ubuntu \
    SHELL=/bin/bash
ENTRYPOINT ["/startup.sh"]
