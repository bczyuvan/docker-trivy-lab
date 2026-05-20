FROM debian:13-slim

# Instalar únicamente lo necesario y limpiar caché
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        python3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Crear usuario no-root
RUN useradd \
    --create-home \
    --uid 1001 \
    --shell /usr/sbin/nologin \
    appuser

# Directorio de trabajo
WORKDIR /app

# Copiar contenido
COPY --chown=appuser:appuser index.html .

# Ejecutar como usuario no-root
USER appuser

# Healthcheck simple
HEALTHCHECK CMD python3 -c "import socket; s=socket.socket(); s.connect(('127.0.0.1',8080)); s.close()"

# Exponer puerto
EXPOSE 8080

# Servidor HTTP legítimo
CMD ["python3", "-m", "http.server", "8080"]