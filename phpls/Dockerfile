FROM kansaipg/docker-coc.nvim

COPY ./phpls/.vimrc /root/.vimrc

WORKDIR /home/

#https://stackoverflow.com/questions/50382603/how-to-timeout-with-exit0-from-bash
#--preserve-status手元の環境だと効かない
RUN (timeout 90s /usr/local/bin/vim; exit 0)  
