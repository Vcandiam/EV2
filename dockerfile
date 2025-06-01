# Imagen base
FROM ubuntu:22.04

# Mantenedor
LABEL maintainer="vi.candia@duocuc.cl"

# Variables de entorno para facilitar configuración
ENV NAGIOS_USER=nagiosadmin \
    NAGIOS_PASS=admin123 \
    DEBIAN_FRONTEND=noninteractive

# Instalación de dependencias
RUN apt-get update && \
    apt-get install -y \
    apache2 \
    php \
    libapache2-mod-php \
    build-essential \
    libgd-dev \
    unzip \
    wget \
    curl \
    openssl \
    libssl-dev \
    daemon \
    make \
    gcc \
    libapache2-mod-authnz-external \
    psmisc \
    sudo && \
    apt-get clean

# Crear usuario y grupos necesarios
RUN useradd nagios && \
    groupadd nagcmd && \
    usermod -a -G nagcmd nagios && \
    usermod -a -G nagcmd www-data

# Descargar y compilar Nagios Core
WORKDIR /tmp
RUN wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.5.1.tar.gz && \
    tar -zxvf nagios-4.5.1.tar.gz && \
    cd nagios-4.5.1 && \
    ./configure --with-command-group=nagcmd && \
    make all && \
    make install && \
    make install-init && \
    make install-commandmode && \
    make install-config && \
    make install-webconf

# Crear usuario para la interfaz web
RUN htpasswd -b -c /usr/local/nagios/etc/htpasswd.users $NAGIOS_USER $NAGIOS_PASS

# Habilitar módulos de Apache
RUN a2enmod rewrite cgi

# Exponer el puerto web
EXPOSE 80

# Comando de inicio: arranca Apache y Nagios
CMD ["bash", "-c", "service apache2 start && /usr/local/nagios/bin/nagios /usr/local/nagios/etc/nagios.cfg && tail -f /dev/null"]

