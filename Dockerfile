FROM debian:13-slim

# Instalar únicamente lo necesario y limpiar caché

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3 \
        openssl && \
    rm -rf /var/lib/apt/lists/*

# Crear usuario no-root
RUN useradd --create-home --uid 1001 --shell /usr/sbin/nologin appuser

# Directorio de trabajo
WORKDIR /app

# Copiar contenido
COPY --chown=appuser:appuser index.html ./index.html


# Cambiar a usuario no-root
USER appuser
HEALTHCHECK CMD true

EXPOSE 8080

# Comando seguro sin shell interactiva
CMD ["python3", "-m", "http.server", "8080"]