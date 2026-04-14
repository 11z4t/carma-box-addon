ARG BUILD_FROM
FROM ${BUILD_FROM}

# Base image has Python 3.12. Install git for clone.
RUN apk add --no-cache git

# Clone application from GitHub
WORKDIR /opt
RUN git clone --depth 1 --branch v2.0.0 \
    https://github.com/11z4t/carma-box-v2.git carma-box

WORKDIR /opt/carma-box

# Install Python dependencies
RUN pip3 install --no-cache-dir --break-system-packages \
    pydantic>=2.6 \
    aiohttp>=3.9 \
    pyyaml>=6.0 \
    aiosqlite>=0.19 \
    structlog>=24.1

# Copy add-on specific files
COPY run.sh /
RUN chmod +x /run.sh

# Copy example config
RUN mkdir -p /opt/carma-box/addon-config
COPY site.yaml.example /opt/carma-box/addon-config/

CMD ["/run.sh"]
