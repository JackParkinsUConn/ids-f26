# PM2.5 monitor datasets

This folder contains two ZIP archives of hourly PM2.5 data extracts for
air-quality analysis. Each archive contains one CSV. They cover June 1,
2023, through August 31, 2026, and retain the source-specific schemas so
they can be prepared for different research questions. The ZIP files can be
read directly with `pandas.read_csv(..., compression="zip")` or extracted.

## Files

- `nyccas.zip` contains `nyccas.csv` with 140,908 rows from six New York
  City Community Air Survey (NYCCAS) monitors. Fields are `SiteID`,
  `SiteName`, `Latitude`, `Longitude`, `ObservationTimeUTC`, and `Value`
  (µg/m³).
- `airnow.zip` contains `airnow.csv` with 102,037 rows from four regional
  AirNow monitoring sites. Fields are `aqs_id_full`, `site_name`,
  `site_agency`, `lat`, `lon`, `datetime`, `param`, `concentration`, and
  `unit`.

The AirNow sites are Flemington (Hunterdon County), Rutgers University
(Middlesex County), Chester (Morris County), and Paterson (Passaic County).
Chester has no records in the June–December 2023 portion of the extract, so
site availability varies over time.

## Coverage and missingness

The CSV members contain no null cells in their recorded rows. That does not
mean the monitoring record is complete. Monitors have different start dates and
there are gaps in the hourly observations between recorded times. Summarize
coverage by monitor and time period before analysis. An absent monitor-hour is
not a measured zero, and a missing daily estimate should not be filled with
zero without a defensible measurement model.

`ObservationTimeUTC` explicitly identifies UTC. AirNow's `datetime` values
have no offset in the CSV; the AirNow hourly data specification defines the
times as GMT (UTC), labeled at the beginning of each measurement hour.

AirNow includes `-999` concentration codes as well as valid zero readings.
Consult the source documentation and inspect the extract before deciding how
to classify special codes. Zero is an observed concentration, not a missing
value by definition. NYCCAS observations are preliminary and subject to
revision. The archive updated its historical correction factor in June 2024
and removed some records in May 2026 after sensor problems.

## Data provenance

The NYCCAS extract combines a public-archive snapshot for June 2023 through
December 2024 and June 2025 through August 2026 with a saved source file for
January through May 2025. The AirNow extract combines previously saved data
for January 2024 through May 2025 with API extracts for June–December 2023
and June 2025 through August 2026. These combined extracts were assembled on
October 14, 2026, but neither is a single frozen source release.

Use October 14, 2026, as the download date when citing the two distributed
extracts. This is their assembly date; the access dates of earlier saved
source components were not recorded. Preserve the source-period information
when sharing or updating the extracts.

## Sources

NYCCAS: New York City Department of Health and Mental Hygiene and Queens
College. *New York City Community Air Survey: Real-time PM2.5 Monitor Data*,
June 1, 2023–August 31, 2026. Date downloaded for this extract: October 14,
2026. [Archive and change log](https://github.com/nychealth/nyccas-data).

AirNow: U.S. Environmental Protection Agency. *AirNow Hourly Data*,
June 1, 2023–August 31, 2026. Date downloaded for this extract: October 14,
2026. [API documentation](https://docs.airnowapi.org/) and [hourly data
specification](https://docs.airnowapi.org/docs/HourlyDataFactSheet.pdf).

AirNow readings are preliminary and subject to change.
