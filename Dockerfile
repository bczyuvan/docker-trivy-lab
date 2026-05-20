FROM debian:13-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends python3-minimal && \
    useradd \
        --create-home \
        --uid 1001 \
        --shell /usr/sbin/nologin \
        appuser && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --chown=appuser:appuser index.html .

USER appuser

EXPOSE 8080

CMD ["python3", "-m", "http.server", "8080", "--bind", "0.0.0.0"]