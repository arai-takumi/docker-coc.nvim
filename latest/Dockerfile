FROM debian:11 as build-stage

RUN apt-get update && apt-get install -y git make curl gcc libncurses-dev \
&& git clone https://github.com/vim/vim.git 

WORKDIR /vim/src

RUN make -j$(grep '^processor' /proc/cpuinfo | wc -l) && make install

FROM node:bullseye-slim 

COPY --from=build-stage /usr/local/bin/vimdiff /usr/local/bin/vimdiff
COPY --from=build-stage /usr/local/bin/vim /usr/local/bin/vim
COPY --from=build-stage /usr/local/bin/vimtutor /usr/local/bin/vimtutor
COPY --from=build-stage /usr/local/share/vim/ /usr/local/share/vim/ 

RUN apt-get update && apt-get install -y git curl \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

USER node

RUN mkdir -p ~/.vim/autoload/ \
&&  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

COPY ./.vimrc /home/node/.vimrc

RUN vim -c PlugInstall -c q -c q 

WORKDIR /home/node
