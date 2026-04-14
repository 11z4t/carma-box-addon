ARG BUILD_FROM
FROM ${BUILD_FROM}

# Install Python and dependencies
RUN apk add --no-cache \
    python3 \
    py3-pip \
    py3-aiohttp \
    py3-yaml \
    git

# Clone application from GitHub (pinned to v2.0.0)
WORKDIR /opt
RUN git clone --depth 1 --branch v2.0.0 \
    https://github.com/11z4t/carma-box-v2.git carma-box

WORKDIR /opt/carma-box

# Install Python dependencies
RUN pip3 install --no-cache-dir --break-system-packages \
    pydantic>=2.6 \
    aiosqlite>=0.19 \
    asyncpg>=0.29 \
    structlog>=24.1

# Copy add-on specific files
COPY run.sh /
RUN chmod +x /run.sh

# Copy example config
RUN mkdir -p /opt/carma-box/addon-config
COPY site.yaml.example /opt/carma-box/addon-config/

CMD ["/run.sh"]
