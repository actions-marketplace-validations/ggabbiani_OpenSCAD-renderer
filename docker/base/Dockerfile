# Usiamo l'immagine ufficiale Fedora 42 (o l'ultima stabile disponibile)
FROM fedora:42

# System tools
# Usiamo --nodocs per mantenere l'immagine più snella.
RUN dnf install -y --nodocs \
    python3 \
    python3-pip \
    python3-devel \
    bash \
    git \
    openssh-clients \
    curl \
    gcc \
    gcc-c++ \
    graphviz \
    ImageMagick \
    make \
    meson \
    openscad \
    wget \
    xorg-x11-server-Xvfb \
    && dnf clean all

# Crea la directory, scarica l'AppImage e imposta i permessi di esecuzione
RUN mkdir -p /opt/OpenSCAD-nightly && \
    wget -O /opt/OpenSCAD-nightly/OpenSCAD.AppImage https://files.openscad.org/snapshots/OpenSCAD-2026.06.10-x86_64.AppImage && \
    chmod +x /opt/OpenSCAD-nightly/OpenSCAD.AppImage && \
    ls -l /opt/OpenSCAD-nightly/

# ambiente di lavoro
WORKDIR /app

# dipendenze Python
# Nota: In Fedora, è buona norma usare un virtualenv o --break-system-packages
# se installi via pip globale, ma in un container isolato per una Action
# possiamo procedere direttamente.
COPY requirements.txt .
RUN pip install --root-user-action ignore --no-cache-dir -r requirements.txt
