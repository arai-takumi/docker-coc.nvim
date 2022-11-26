FROM kansaipg/docker-coc.nvim

RUN mkdir /home/build

WORKDIR /home/build

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python3 get-pip.py --force-reinstall && rm get-pip.py && pip3 install jedi-language-server

COPY ./python-jedi-phpls/coc-settings.json /root/.vim/coc-settings.json

COPY ./python-jedi-phpls/coc_global_extensions.txt /root/coc_global_extensions.txt

RUN cat coc_global_extensions.txt >> /root/.vimrc && rm /root/coc_global_extensions.txt

WORKDIR /home/

#https://stackoverflow.com/questions/50382603/how-to-timeout-with-exit0-from-bash

RUN (timeout 90s /usr/local/bin/vim; exit 0)
