FROM docker.io/s390x/clefos:latest

#Update OS Packages
#RUN  rpmkeys --import "http://pool.sks-keyservers.net/pks/lookup?op=get&search=0x3fa7e0328081bff6a14da29aa6a19b38d3d831ef"
#RUN su -c 'curl https://download.mono-project.com/repo/centos7-stable.repo | tee /etc/yum.repos.d/mono-centos7-stable.repo'
RUN yum install mono-devel xsp -y

#Testing -1 
#RUN csharp -e 'new System.Net.WebClient ().DownloadString ("https://www.nuget.org")'

#Testing -2
#RUN mkdir -p scripts
#ADD Program.cs scripts/Program.cs
#RUN mcs scripts/Program.cs
#RUN mono scripts/Program.exe

ADD Index.aspx /usr/lib/xsp/test/Index.aspx
ADD Index.aspx.cs /usr/lib/xsp/test/Index.aspx.cs
ADD Index.aspx.cs /usr/lib/xsp/test/Index.aspx.designer.cs

VOLUME /app
WORKDIR /usr/lib/xsp/test
#ADD samp.aspx app/samp.aspx

RUN mcs /t:library /out:webapps390x.dll -r:System.Web -r:System.Data -r:System.Drawing Index.aspx.cs Index.aspx.designer.cs

EXPOSE 9090
ENTRYPOINT [ "xsp4","--port","9090","--nonstop"]