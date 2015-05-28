FROM ubuntu:latest
MAINTAINER Mika Kalathil <mikakalathil@gmail.com>

RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

# Set ENV Variables
ENV MIX_ENV prod
ENV NODE_ENV production

WORKDIR /root
ADD .env .env

# Update and Install
RUN apt-get update -y 
RUN apt-get install build-essential git wget nodejs nodejs-legacy npm -y

# Install Erlang and Elixir
RUN wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
RUN dpkg -i erlang-solutions_1.0_all.deb
RUN apt-get update
RUN apt-get install -y erlang elixir

# Install Phoenix
WORKDIR /root
RUN mix archive.install https://github.com/phoenixframework/phoenix/releases/download/v0.13.1/phoenix_new-0.13.1.ez --force

# Install Mix Components
RUN mix local.rebar --force
RUN mix local.hex --force
