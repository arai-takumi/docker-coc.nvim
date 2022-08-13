FROM kansaipg/docker-coc.nvim

RUN mkdir /home/build

WORKDIR /home/build

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python3 get-pip.py --force-reinstall && rm get-pip.py && pip3 install jedi-language-server

COPY ./python-jedi/coc-settings.json /root/.vim/coc-settings.json

COPY ./python-jedi/.vimrc /root/.vimrc

WORKDIR /home/

RUN (timeout 90s /usr/local/bin/vim; exit 0)
