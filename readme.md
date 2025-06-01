# 🐧 Nagios Core Docker Image

Este repositorio contiene todo lo necesario para construir y ejecutar una imagen Docker de **Nagios Core** basada en **Ubuntu**.

---

## 📦 Requisitos

- Docker instalado en tu sistema.
- Acceso a línea de comandos (terminal).
- Conexión a internet para descargar dependencias.

---

## ⚙️ Construcción de la imagen

Clona este repositorio o descarga los archivos:
git clone https://github.com/tuusuario/nagios-docker.git
cd nagios-docker

## Construccion de la imagen
Construye la imagen docker:
docker build -t nagios-core .

## Ejecucion del contenedor
Ejecuta el contenedor con el siguiente comando
docker run -d --name nagios -p 8080:80 nagios-core

## Acceso a la interfaz Web
Abre tu navegador e ingresa a la siguiente URL 
http://localhost:8080/nagios

## Credenciales por defecto
Usuario: nagiosadmin
Contraseña: admin123
Puedes cambiar estas credenciales modificando las variables de entorno en el Dockerfile.

## 🛠️ Personalización
Puedes modificar el Dockerfile para:

Cambiar el usuario y contraseña.
Agregar plugins o configuraciones personalizadas.
Usar volúmenes para persistencia de datos.




