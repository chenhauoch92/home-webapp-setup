FROM centos:latest

# Update the YUM repository URLs
RUN sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo \
    && sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/*.repo \
    && sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/*.repo

# Install dependencies
RUN yum install -y httpd zip unzip \
    && yum clean all

# Download and unzip the file with retries
RUN curl -O https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip \
    && unzip photogenic.zip -d /var/www/html/ \
    && cp -rvf /var/www/html/photogenic/* /var/www/html/ \
    && rm -rf /var/www/html/photogenic /var/www/html/photogenic.zip

# Set working directory
WORKDIR /var/www/html/

# Expose ports
EXPOSE 80 22

# Start the HTTPD server
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
