# sshとpython開発環境の入ったコンテナのdockerfile
# ビルド、起動、接続は下記で。
# ビルドの際は必要に応じて--build-arg (argname)=(value) オプションを指定のこと
# docker build -t centos7ssh ./
# docker run --privileged --rm -d -p 2222:22 -p 5000:80 --name centos7sshcontainer centos7ssh /sbin/init
# docker exec -it centos7sshcontainer bash

FROM centos:centos7

ARG USERNAME=hoge

RUN yum -y update && yum clean all
RUN yum install -y which
RUN yum install -y wget
RUN yum install -y tar
RUN yum install -y vim
RUN yum install -y git
RUN yum -y install openssh-server openssh-clients

RUN useradd -m $USERNAME

RUN mkdir  /home/$USERNAME/.ssh
RUN chmod 700 /home/$USERNAME/.ssh
RUN touch  /home/$USERNAME/.ssh/authorized_keys
RUN chmod 600  /home/$USERNAME/.ssh/authorized_keys
RUN chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh

RUN yum install -y https://repo.ius.io/ius-release-el7.rpm

RUN yum install -y python36u python36u-libs python36u-devel python36u-pip

RUN unlink  /usr/bin/python
RUN ln -s /usr/bin/python3.6 /usr/bin/python
RUN ln -s /usr/bin/pip3.6 /usr/local/bin/pip

RUN pip install pandas
RUN pip install flask
RUN pip install bs4
RUN pip install matplotlib

CMD /bin/bash
