FROM ruby:2.6.5-slim-buster

# 修改debian源
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free" >/etc/apt/sources.list && \
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free" >>/etc/apt/sources.list && \
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free" >>/etc/apt/sources.list && \
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free" >>/etc/apt/sources.list && \
    echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free" >>/etc/apt/sources.list && \
    echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free" >>/etc/apt/sources.list && \
    echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free" >>/etc/apt/sources.list && \
    echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free" >>/etc/apt/sources.list

# 安装必要套件
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends build-essential \
    openssh-server \
    git \
    nodejs \
    libpq-dev \
    libxrender1 \
    libfontconfig \
    libxext-dev \
    ttf-wqy-zenhei \
    libjpeg62 \
    curl \
    postgresql-client && \
    rm -rf /var/lib/apt/lists/*
    # locales \
    # cron \

# 中文字变方框的情况证实使用ttf-wqy-zenhei是有效的

# 一些字体 ttf-wqy-zenhei ttf-wqy-microhei ttf-arphic-ukai \
# 网上看到的ttf-arphic-uming和ttf-arphic-ukai都无法安装
# ttf-wqy-microhei无法证实有效
# ttf-mscorefonts-installer是想安装一些像arial的英文字体 但是也无法证实有效 相较于centos的行间距仍然比较小

# gem:wkhtmltopdf-binary 0.12.5.4版本需要新安装libjpeg62-dev


# RUN localedef -c -f UTF-8 -i zh_CN zh_CN.utf8

# ENV LANG zh_CN.utf8
ENV LANG C.UTF-8

#定义变量
ENV HOME /app

#创建目录
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime && \
    mkdir $HOME && \
    mkdir -p $HOME/tmp/pids && \
    chmod -R 755 $HOME/tmp && \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

CMD echo "Hello ruby deploy test"