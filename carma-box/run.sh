#!/usr/bin/with-contenv bashio

CONFIG_DIR="/config"
SITE_CONFIG="${CONFIG_DIR}/site.yaml"
EXAMPLE_CONFIG="/opt/carma-box/addon-config/site.yaml.example"

# Copy example config if none exists
if [ ! -f "${SITE_CONFIG}" ]; then
    bashio::log.warning "No site.yaml found — copying example to ${SITE_CONFIG}"
    cp "${EXAMPLE_CONFIG}" "${SITE_CONFIG}"
    bashio::log.info "Edit ${SITE_CONFIG} with your entity IDs before restarting"
fi

# Supervisor token → CARMA_HA_TOKEN
# Read from s6 container environment file if env var is empty
if [ -z "${SUPERVISOR_TOKEN:-}" ]; then
    export CARMA_HA_TOKEN="$(cat /run/s6/container_environment/SUPERVISOR_TOKEN 2>/dev/null)"
else
    export CARMA_HA_TOKEN="${SUPERVISOR_TOKEN}"
fi

# Log level from add-on config
LOG_LEVEL=$(bashio::config 'log_level')

bashio::log.info "CARMA Box v2.0.0 starting"
bashio::log.info "Config: ${SITE_CONFIG}"

cd /opt/carma-box
exec python3 -m main --config "${SITE_CONFIG}"
