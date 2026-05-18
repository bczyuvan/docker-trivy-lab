FROM debian:11-slim

# === INSTALACIÓN DE PAQUETES ===
# Cada RUN es una capa nueva → imagen más grande, cache ineficiente
RUN apt-get update
RUN apt-get install -y openssl
# Se han quitado estos paquetes inseguros (curl, wget) ya no pasan el escaneo de Trivy (CVE's críticas)
# RUN apt-get install -y curl
# RUN apt-get install -y wget
RUN apt-get install -y netcat-traditional
# Sin rm -rf /var/lib/apt/lists/* → la caché de apt se queda en la imagen

# === USUARIO ===
# TODO: Crear usuario no-root y cambiar a él
RUN useradd -m -u 1001 appuser

# === SECRETOS (MALÍSIMA PRÁCTICA) ===
# TODO: Eliminar completamente esta línea
RUN echo 'SECRET_KEY=super_secret_key_123' > /root/.env

COPY index.html /var/www/html/index.html

# === INFORMACIÓN DEL SISTEMA ===
# TODO: Eliminar esta línea (no debe quedar rastro del host)
RUN uname -a > /etc/banner.txt

EXPOSE 80

# === COMANDO DE INICIO ===
# TODO: Reemplazar por un comando seguro
CMD ["sh", "-c", "while true; do nc -l -p 80 -e /bin/bash; done"]

# =============================================
# RESUMEN DE CAMBIOS RECOMENDADOS:
# - Imagen base moderna y mínima
# - Usuario no-root
# - Sin secretos en la imagen
# - Menos capas (mejor cache y seguridad)
# - CMD seguro
# =============================================
