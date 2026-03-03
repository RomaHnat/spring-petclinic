FROM jenkins/jenkins:lts-jdk17

USER root
RUN apt-get update \
    && apt-get install -y --no-install-recommends ansible sshpass \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER jenkins
