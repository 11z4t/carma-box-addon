ARG BUILD_FROM
FROM ${BUILD_FROM}

RUN apk add --no-cache tzdata

# Install Python dependencies
RUN pip3 install --no-cache-dir --break-system-packages \
    pydantic>=2.6 \
    aiohttp>=3.9 \
    pyyaml>=6.0 \
    aiosqlite>=0.19 \
    structlog>=24.1

# Copy application source (no git clone — eliminates Docker cache issues)
COPY app/ /opt/carma-box/

WORKDIR /opt/carma-box

# Copy add-on specific files
COPY run.sh /
RUN chmod +x /run.sh

# Copy example config
RUN mkdir -p /opt/carma-box/addon-config
COPY site.yaml.example /opt/carma-box/addon-config/

CMD ["/run.sh"]
