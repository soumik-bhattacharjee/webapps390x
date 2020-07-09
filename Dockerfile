FROM docker.io/s390x/clefos:latest

#Update OS Packages
#RUN  rpmkeys --import "http://pool.sks-keyservers.net/pks/lookup?op=get&search=0x3fa7e0328081bff6a14da29aa6a19b38d3d831ef"
#RUN su -c 'curl https://download.mono-project.com/repo/centos7-stable.repo | tee /etc/yum.repos.d/mono-centos7-stable.repo'
RUN yum install mono-devel xsp -y

ADD index.aspx /usr/lib/xsp/test/index.aspx
ADD index.aspx.cs /usr/lib/xsp/test/index.aspx.cs

VOLUME /app
WORKDIR /usr/lib/xsp/test

RUN mcs /t:library /out:webapps390x.dll -r:System.Web -r:System.Data -r:System.Drawing index.aspx.cs

EXPOSE 9090
ENTRYPOINT [ "xsp4","--port","9090","--nonstop"]
