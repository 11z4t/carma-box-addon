# CARMA Box — Home Assistant Add-on

Smart energy optimization for residential solar + battery systems.

## What it does

- Manages GoodWe ET inverters (charge/discharge/standby)
- Optimizes EV charging (Easee) with grid-aware ramp logic
- Dispatches surplus PV to consumers (heat pumps, pool, miner)
- Peak shaving against Ellevio weighted hourly average
- 8-scenario state machine with safety guards (G0-G7)

## Installation

1. In Home Assistant, go to **Settings → Add-ons → Add-on Store**
2. Click **⋮ → Repositories** and add:
   ```
   https://github.com/11z4t/carma-box-addon
   ```
3. Find **CARMA Box** in the store and click **Install**
4. Configure `site.yaml` (see below)
5. Start the add-on

## Configuration

Copy the example config and edit for your site:

```bash
cp /addon_configs/carma-box/site.yaml.example /addon_configs/carma-box/site.yaml
```

Edit entity IDs to match your HA installation. See [carma-box-v2](https://github.com/11z4t/carma-box-v2) for full documentation.

## Monitoring

- **Logs:** Add-on log tab in HA UI
- **Health:** `http://homeassistant.local:8412/health`
- **Metrics:** `http://homeassistant.local:8412/metrics` (Prometheus)
- **Dashboard sensors:** `sensor.carma_box_scenario`, `sensor.carma_box_decision_reason`

## Architecture

The add-on runs [CARMA Box v2](https://github.com/11z4t/carma-box-v2) as a standalone Python service alongside Home Assistant. It communicates via the Supervisor API — no long-lived tokens needed.

```
30s cycle: COLLECT → GUARD → SCENARIO → BALANCE → EXECUTE → PERSIST
```

## Hardware Requirements

- Home Assistant OS (RPi 4/5, x86, or VM)
- GoodWe ET inverter with HACS integration
- Easee EV charger (optional)
- 512MB free RAM

## Links

- [Application source](https://github.com/11z4t/carma-box-v2)
- [Changelog](https://github.com/11z4t/carma-box-v2/blob/master/CHANGELOG.md)
