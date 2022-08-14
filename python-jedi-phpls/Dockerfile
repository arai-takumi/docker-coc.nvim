FROM kansaipg/docker-coc.nvim

RUN mkdir /home/build

WORKDIR /home/build

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python3 get-pip.py --force-reinstall && rm get-pip.py && pip3 install jedi-language-server

COPY ./python-jedi/coc-settings.json /root/.vim/coc-settings.json

COPY ./python-jedi/.vimrc /root/.vimrc

WORKDIR /home/

#https://stackoverflow.com/questions/50382603/how-to-timeout-with-exit0-from-bash
#--preserve-status�~I~K�~E~C�~A��~R��~C�~A| �~A��~J��~A~K�~A��~A~D

RUN (timeout 90s /usr/local/bin/vim; exit 0)
