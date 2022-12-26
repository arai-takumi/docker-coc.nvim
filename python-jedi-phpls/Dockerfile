FROM python:3.7-slim as build-stage

RUN pip3 install jedi-language-server

FROM python:3.7-slim

COPY --from=build-stage /usr/local/lib/python3.7/site-packages /root/.local/lib/python3.7/site-packages

COPY --from=kansaipg/docker-coc.nvim /usr/local/bin/vimdiff /usr/local/bin/vimdiff
COPY --from=kansaipg/docker-coc.nvim /usr/local/bin/vim /usr/local/bin/vim
COPY --from=kansaipg/docker-coc.nvim /usr/local/bin/vimtutor /usr/local/bin/vimtutor
COPY --from=kansaipg/docker-coc.nvim /usr/local/share/vim/ /usr/local/share/vim/
COPY --from=kansaipg/docker-coc.nvim /root/.vim /root/.vim
COPY --from=kansaipg/docker-coc.nvim /root/.vimrc /root/.vimrc

COPY ./python-jedi-phpls/coc-settings.json /root/.vim/coc-settings.json

COPY ./python-jedi-phpls/coc_global_extensions.txt /root/coc_global_extensions.txt

RUN cat /root/coc_global_extensions.txt >> /root/.vimrc && rm /root/coc_global_extensions.txt

WORKDIR /home/

#https://stackoverflow.com/questions/50382603/how-to-timeout-with-exit0-from-bash

RUN (timeout 90s /usr/local/bin/vim; exit 0)
