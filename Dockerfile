FROM node

RUN git clone https://github.com/vim/vim.git 

WORKDIR /vim/src

RUN make && make install

RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

COPY .vimrc /root/.vimrc

RUN vim -c PlugInstall -c q -c q

WORKDIR /
