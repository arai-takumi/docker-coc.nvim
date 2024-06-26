FROM debian:11 as build-stage

RUN apt-get update && apt-get install -y git make curl gcc libncurses-dev \
&& git clone https://github.com/vim/vim.git 

WORKDIR /vim/src

RUN make -j$(grep '^processor' /proc/cpuinfo | wc -l) && make install \
&& curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

FROM node:bullseye-slim 

COPY --from=build-stage /usr/local/bin/vimdiff /usr/local/bin/vimdiff
COPY --from=build-stage /usr/local/bin/vim /usr/local/bin/vim
COPY --from=build-stage /usr/local/bin/vimtutor /usr/local/bin/vimtutor
COPY --from=build-stage /usr/local/share/vim/ /usr/local/share/vim/ 
COPY --from=build-stage /root/.vim /root/.vim 

RUN apt-get update && apt-get install -y git

COPY ./.vimrc /root/.vimrc

RUN vim -c PlugInstall -c q -c q && chmod -R 777 /root \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /home/node

USER node
