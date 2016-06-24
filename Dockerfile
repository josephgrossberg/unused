FROM ubuntu:16.04

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 575159689BEFB442
RUN echo 'deb http://download.fpcomplete.com/ubuntu xenial main'|tee /etc/apt/sources.list.d/fpco.list
RUN apt-get update
RUN apt-get install stack -y
RUN apt-get install silversearcher-ag

ENV APP_HOME /myapp
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD stack.yaml $APP_HOME/
RUN stack setup

ADD unused.cabal $APP_HOME
RUN stack install --only-dependencies

ADD . $APP_HOME
RUN stack install

ENV PATH="/root/.local/bin/:$PATH"
