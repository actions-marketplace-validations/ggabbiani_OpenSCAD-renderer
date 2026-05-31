# TODO: use the 'latest' tag instead
FROM ggabbiani/renderer-base:v1.0.0

# Copia del codice della Action
COPY app/functions.sh app/entry-point.sh app/ofl.py app/make-picture.py .

# Permessi e Entrypoint
RUN chmod +x /app/functions.sh /app/entry-point.sh /app/ofl.py /app/make-picture.py
WORKDIR /import

ENTRYPOINT ["/app/entry-point.sh"]