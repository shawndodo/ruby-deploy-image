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
    cron \
    libxrender1 \
    libfontconfig \
    libxext-dev \
    locales \
    postgresql-client && \
    rm -rf /var/lib/apt/lists/*

RUN localedef -c -f UTF-8 -i zh_CN zh_CN.utf8

ENV LANG zh_CN.utf8

#定义变量
ENV HOME /app

#创建目录
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime && \
    mkdir $HOME && \
    mkdir -p $HOME/tmp/pids && \
    chmod -R 755 $HOME/tmp && \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

CMD echo "Hello ruby deploy"