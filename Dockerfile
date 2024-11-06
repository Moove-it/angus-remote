FROM ruby:3.3.0

ARG SSH_PRV_KEY
ARG SSH_PUB_KEY
ARG SSH_KNOWN_HOSTS

RUN mkdir /root/.ssh \
  && echo "$SSH_PRV_KEY" > /root/.ssh/id_rsa \
  && echo "$SSH_PUB_KEY" > /root/.ssh/id_rsa.pub \
  && echo "$SSH_KNOWN_HOSTS" > /root/.ssh/known_hosts \
  && chmod 600 /root/.ssh/id_rsa \
  && chmod 600 /root/.ssh/id_rsa.pub

WORKDIR /home/angus-remote

COPY . ./

RUN bundle install

CMD ["/bin/bash"]
