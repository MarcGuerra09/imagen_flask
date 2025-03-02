FROM python:3.10-slim

# Instalar dependencias
RUN apt-get update && apt-get install -y \
    ssh \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

# Configurar SSH
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Configurar entorno Python
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install gunicorn

# Crear directorio para la aplicación web
RUN mkdir -p /app/web
WORKDIR /app/web

# Copiar la aplicación web Flask (la de la práctica anterior)
COPY ./web/ .

# Configurar supervisord para gestionar los servicios
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8000 22

CMD ["/usr/bin/supervisord"]