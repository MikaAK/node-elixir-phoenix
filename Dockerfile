FROM mikaak/node:latest
MAINTAINER Mika Kalathil <mikakalathil@gmail.com>

RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

# Set ENV Variables
ENV MIX_ENV prod
ENV NODE_ENV production

# Install Erlang and Elixir
RUN curl http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb > erlang-solutions_1.0_all.deb \
    && dpkg -i erlang-solutions_1.0_all.deb \
    && apt-get update \
    && apt-get install -y erlang elixir \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* erlang-solutions_1.0_all.deb \
    && apt-get clean

RUN mix archive.install http://github.com/phoenixframework/phoenix/releases/download/v1.0.4/phoenix_new-1.0.4.ez --force \
    && mix local.rebar --force \
    && mix local.hex --force \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && apt-get clean
