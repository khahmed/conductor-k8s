# Build: docker build -t conductor-spark:2.2 .
# Run:   docker run -it --net=host --cap-add SYS_NICE --cap-add NET_BIND_SERVICE conductor-spark:2.2 
FROM centos:7
MAINTAINER Khalid Ahmed <khalida@ca.ibm.com>

ENV CLUSTERADMIN egoadmin
ENV CLUSTERNAME cws
ENV BASEPORT 7869
ENV DISABLESSL Y
ENV LANG en_CA.UTF-8
ENV CWS_INSTALL_PKG cwseval-2.2.0.0_x86_64.bin
ENV CWS_CLUSTER_TOP  /opt/ibm/spectrumcomputing
ENV REPO_URL http://9.29.133.27:9191

RUN useradd egoadmin
RUN yum install -y gettext net-tools gawk which sudo tar wget

RUN cd /;wget --quiet --no-proxy ${REP_URL}/${CWS_INSTALL_PKG};chmod 755 /${CWS_INSTALL_PKG};/${CWS_INSTALL_PKG} --quiet; rm -f /${CWS_INSTALL_PKG}

COPY bootstrap.sh /bootstrap.sh
RUN chmod 755 /bootstrap.sh

CMD /bootstrap.sh


