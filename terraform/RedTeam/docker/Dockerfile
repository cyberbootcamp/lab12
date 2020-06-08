FROM cyberxsecurity/ansible

RUN apt-get install -y sudo
RUN groupadd -g 1000 RedAdmin && useradd -rm -d /home/RedAdmin -s /bin/bash -g RedAdmin -G sudo -u 1000 RedAdmin

USER RedAdmin

CMD tail -f /dev/null