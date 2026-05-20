FROM debian:13-slim

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        python3-minimal && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd \
    --create-home \
    --uid 1001 \
    --shell /usr/sbin/nologin \
    appuser

WORKDIR /app

COPY --chown=appuser:appuser index.html .

USER appuser

EXPOSE 8080

CMD ["python3", "-m", "http.server", "8080"]