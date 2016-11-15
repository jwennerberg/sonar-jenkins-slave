FROM rhel7/rhel

MAINTAINER Johan Wennerberg <jwennerb@redhat.com>

ENV SONAR_SCANNER_URL=https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-2.8.zip \
    HOME=/var/lib/jenkins

RUN yum-config-manager --disable epel >/dev/null || : && \
    INSTALL_PKGS="atomic-openshift-clients bc gettext git java-1.8.0-openjdk-headless lsof nss_wrapper rsync tar unzip which zip" && \
    yum install -y $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y && \
    mkdir -p ${HOME}/tools && \
    curl -k -s -o /tmp/sonar-scanner.zip ${SONAR_SCANNER_URL} && \
    unzip /tmp/sonar-scanner.zip -d ${HOME}/tools && \
    mv ${HOME}/tools/sonar-scanner-* ${HOME}/tools/sonar && \
    chown -R 1001:0 $HOME && \
    chmod -R g+rw $HOME

ENV PATH="${PATH}:${HOME}/tools/sonar/bin"

USER 1001
