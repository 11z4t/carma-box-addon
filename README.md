# CARMA Box – tillägg för Home Assistant

Intelligent energioptimering för bostäder med solceller och batterilagring.

## Funktioner

- Styr GoodWe ET-växelriktare för laddning, urladdning och viloläge.
- Optimerar laddning av elfordon via Easee med hänsyn till elnätet och stegvis reglering.
- Fördelar överskottsel från solceller till förbrukare, exempelvis värmepumpar, pool och utrustning för kryptoutvinning.
- Begränsar effekttoppar utifrån Ellevios viktade timmedelvärde.
- Använder en tillståndsmaskin med åtta scenarier och säkerhetsspärrarna G0–G7.

## Installation

1. Öppna **Inställningar → Tillägg → Tilläggsbutiken** i Home Assistant.
2. Välj **⋮ → Arkiv** och lägg till:
   ```
   https://github.com/11z4t/carma-box-addon
   ```
3. Leta upp **CARMA Box** i butiken och välj **Installera**.
4. Konfigurera `site.yaml` enligt anvisningarna nedan.
5. Starta tillägget.

## Konfiguration

Kopiera exempelkonfigurationen och anpassa den till anläggningen:

```bash
cp /addon_configs/carma-box/site.yaml.example /addon_configs/carma-box/site.yaml
```

Ändra entitets-ID:na så att de motsvarar din Home Assistant-installation. Fullständig dokumentation finns i [carma-box-v2](https://github.com/11z4t/carma-box-v2).

## Övervakning

- **Loggar:** Tilläggets loggflik i Home Assistants gränssnitt.
- **Driftstatus:** `http://homeassistant.local:8412/health`.
- **Mätvärden:** `http://homeassistant.local:8412/metrics` i Prometheus-format.
- **Sensorer för översikten:** `sensor.carma_box_scenario` och `sensor.carma_box_decision_reason`.

## Arkitektur

Tillägget kör [CARMA Box v2](https://github.com/11z4t/carma-box-v2) som en fristående Python-tjänst vid sidan av Home Assistant. Kommunikationen sker via Supervisor-API:et, utan långlivade åtkomsttoken.

Varje 30-sekunderscykel omfattar insamling, säkerhetskontroll, scenarioval, balansering, verkställande och lagring. Motsvarande tekniska steg heter `COLLECT`, `GUARD`, `SCENARIO`, `BALANCE`, `EXECUTE` och `PERSIST`.

## Hårdvarukrav

- Home Assistant OS på Raspberry Pi 4 eller 5, x86-dator eller virtuell maskin.
- GoodWe ET-växelriktare med HACS-integration.
- Easee-laddbox, valfritt.
- 512 MB ledigt arbetsminne.

## Länkar

- [Applikationens källkod](https://github.com/11z4t/carma-box-v2)
- [Ändringshistorik](https://github.com/11z4t/carma-box-v2/blob/master/CHANGELOG.md)

## Språk

Se projektets [språkregler](LANGUAGE.md).
