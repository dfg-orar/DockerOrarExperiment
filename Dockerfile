FROM ubuntu:14.04
ENV DEBIAN_FRONTEND noninteractive
ENV JAVA_HOME       /usr/lib/jvm/java-8-oracle
ENV LANG            en_US.UTF-8
ENV LC_ALL          en_US.UTF-8

RUN apt-get update && \
  apt-get install -y --no-install-recommends locales && \
  locale-gen en_US.UTF-8 && \
  apt-get dist-upgrade -y && \
  apt-get --purge remove openjdk* && \
  echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
  echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" > /etc/apt/sources.list.d/webupd8team-java-trusty.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 && \
  apt-get update && \
  apt-get install -y --no-install-recommends oracle-java8-installer oracle-java8-set-default && \
  apt-get clean all
#Install required lib for Pagoda
RUN         apt-get update \
                && apt-get install -y \
                    software-properties-common \
                && add-apt-repository -y ppa:ubuntu-toolchain-r/test \
                && apt-get update \
                && apt-get install -y g++-4.9
#Install lib for Konclude
RUN apt-get update && \
    apt-get -y install libglib2.0-0
#Install package for killall command
RUN apt-get update && \
    apt-get install -y psmisc
#Install zip and unzip
RUN apt-get update && \
    apt-get install -y zip \
    unzip    
WORKDIR /workingdir
COPY . /workingdir/
EXPOSE 4040
CMD java -jar -Xmx512G /workingdir/app/Orar_server.jar



