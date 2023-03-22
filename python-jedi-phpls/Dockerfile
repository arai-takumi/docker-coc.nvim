FROM python:3.7-slim as build-stage

RUN pip3 install jedi-language-server

FROM python:3.7-slim

COPY --from=build-stage /usr/local/lib/python3.7/site-packages /root/.local/lib/python3.7/site-packages

COPY --from=ghcr.io/kansai-pg/docker-coc.nvim:latest /usr/local/bin/vimdiff /usr/local/bin/vimdiff
COPY --from=ghcr.io/kansai-pg/docker-coc.nvim:latest /usr/local/bin/vim /usr/local/bin/vim
COPY --from=ghcr.io/kansai-pg/docker-coc.nvim:latest /usr/local/bin/vimtutor /usr/local/bin/vimtutor
COPY --from=ghcr.io/kansai-pg/docker-coc.nvim:latest /usr/local/share/vim/ /usr/local/share/vim/
COPY --from=ghcr.io/kansai-pg/docker-coc.nvim:latest /root/.vim /home/node/.vim
COPY --from=ghcr.io/kansai-pg/docker-coc.nvim:latest /root/.vimrc /home/node/.vimrc

#https://zenn.dev/jrsyo/articles/e42de409e62f5d
COPY --from=ghcr.io/kansai-pg/docker-coc.nvim:latest /usr/local/include/ /usr/local/include/
COPY --from=ghcr.io/kansai-pg/docker-coc.nvim:latest /usr/local/lib/ /usr/local/lib/
COPY --from=ghcr.io/kansai-pg/docker-coc.nvim:latest /usr/local/bin/ /usr/local/bin/

COPY ./coc-settings.json /home/node/.vim/coc-settings.json
COPY ./coc_global_extensions.txt /home/node/coc_global_extensions.txt


RUN groupadd --gid 1000 node \
    && useradd --uid 1000 --gid node --shell /bin/bash --create-home node \
&& corepack disable && corepack enable \
&& apt-get update && apt-get install -y git \
&& cat /home/node/coc_global_extensions.txt >> /home/node/.vimrc \
&& rm /home/node/coc_global_extensions.txt && chown node: -R /home/node \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /home/node

USER node

#https://stackoverflow.com/questions/50382603/how-to-timeout-with-exit0-from-bash

RUN (timeout 90s /usr/local/bin/vim; exit 0)
