from python:3.9
RUN set -ex;\
    apt-get update;\
    apt-mark hold keyboard-configuration;\
    apt-get install git tightvncserver expect websockify qemu-system-x86 xfce4 dbus-x11 -y
ENV DISPLAY=:0
RUN pip3 install websockify pyngrok
#OPSIONAL
RUN apt-get install nodejs npm xfce4-terminal byobu sqlitebrowser firefox-esr geany feh openssh-server php busybox neofetch htop tmate tmux -y
#----------------------
RUN mkdir /work
RUN cd /work&&git clone https://github.com/novnc/noVNC/
COPY . /work
WORKDIR /work
CMD rm /work/Dockerfile&& Xvnc :0 -geometry 1280x720&startxfce4&python3 ngrok_.py&cd /work/noVNC && ./utils/novnc_proxy --vnc :5900 --listen ${PORT}
