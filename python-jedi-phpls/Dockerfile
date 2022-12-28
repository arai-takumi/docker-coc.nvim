FROM python:3.7-slim as build-stage

RUN pip3 install jedi-language-server

FROM python:3.7-slim

RUN groupadd --gid 1000 node \
    && useradd --uid 1000 --gid node --shell /bin/bash --create-home node

COPY --from=build-stage /usr/local/lib/python3.7/site-packages /root/.local/lib/python3.7/site-packages

COPY --from=kansaipg/docker-coc.nvim /usr/local/bin/vimdiff /usr/local/bin/vimdiff
COPY --from=kansaipg/docker-coc.nvim /usr/local/bin/vim /usr/local/bin/vim
COPY --from=kansaipg/docker-coc.nvim /usr/local/bin/vimtutor /usr/local/bin/vimtutor
COPY --from=kansaipg/docker-coc.nvim /usr/local/share/vim/ /usr/local/share/vim/
COPY --from=kansaipg/docker-coc.nvim /root/.vim /home/node/.vim
COPY --from=kansaipg/docker-coc.nvim /root/.vimrc /home/node/.vimrc

#https://zenn.dev/jrsyo/articles/e42de409e62f5d
COPY --from=kansaipg/docker-coc.nvim /usr/local/include/ /usr/local/include/
COPY --from=kansaipg/docker-coc.nvim /usr/local/lib/ /usr/local/lib/
COPY --from=kansaipg/docker-coc.nvim /usr/local/bin/ /usr/local/bin/
RUN corepack disable && corepack enable

RUN apt-get update && apt-get install -y git

COPY ./python-jedi-phpls/coc-settings.json /home/node/.vim/coc-settings.json

COPY ./python-jedi-phpls/coc_global_extensions.txt /home/node/coc_global_extensions.txt

RUN cat /home/node/coc_global_extensions.txt >> /home/node/.vimrc

RUN rm /home/node/coc_global_extensions.txt

RUN chown node: -R /home/node

WORKDIR /home/node

USER node

#https://stackoverflow.com/questions/50382603/how-to-timeout-with-exit0-from-bash

RUN (timeout 90s /usr/local/bin/vim; exit 0)
