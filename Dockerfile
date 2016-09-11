FROM ubuntu:14.04
MAINTAINER Ernestas Poskus <hierco@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       software-properties-common \
    && rm -Rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean

# Install/prepare Ansible
RUN mkdir -p /etc/ansible/
RUN mkdir -p /opt/ansible/roles
RUN printf '[local]\nlocalhost ansible_connection=local\n' > /etc/ansible/hosts

RUN add-apt-repository -y ppa:ansible/ansible \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
     ansible \
  && rm -rf /var/lib/apt/lists/* \
  && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
  && apt-get clean

RUN chmod +x initctl_faker && rm -fr /sbin/initctl && ln -s /initctl_faker /sbin/initctl
