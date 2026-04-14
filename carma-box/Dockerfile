ARG BUILD_FROM
FROM ${BUILD_FROM}

# Base image has Python 3.12. Install git for clone.
RUN apk add --no-cache git tzdata \
    && echo "cache-bust-2026-04-14T20:45"

# Clone application from GitHub (cache-bust via BUILD_DATE)
ARG BUILD_DATE=unknown
WORKDIR /opt
RUN git clone --depth 1 --branch master \
    https://github.com/11z4t/carma-box-v2.git carma-box \
    && echo "Built: ${BUILD_DATE}"

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
