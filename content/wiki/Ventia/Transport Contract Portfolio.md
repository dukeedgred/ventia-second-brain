---
type: concept
topic: Ventia
sources: ["raw/DB walkthrough with Pranav Kumar.md", "raw/SAP data walk-through (transport sector)-20260603_093206-Meeting.md", "raw/Transport Data Asset Stakeholder Interview-20260603_110443.md", "raw/Transport Data Asset Stakeholder Interview-20260604_130526-Toby Lin.md", "raw/Transport Data Asset Stakeholder Interview-20260609_111323-Meeting Recording.md", "raw/Transport Data Asset Stakeholder Interview-20260605_140612-Meeting Recording.md"]
date-created: 2026-06-01
date-updated: 2026-06-14
tags: [transport, contracts, portfolio, data-landscape, asset-data, queensland]
---

# Transport Contract Portfolio

The Transport contract portfolio is the set of Australian and New Zealand roads, tunnels, and related infrastructure contracts that shape the [[Transport Data Landscape]]. Pranav Kumar estimated the portfolio at roughly 15 to 20 contracts, with major work across Australia and New Zealand.

## Regional Shape

In Australia, Transport operates across New South Wales, Queensland, Victoria, Western Australia, and South Australia. New South Wales includes SRAPC, Sydney Harbour Tunnel, Western Harbour Tunnel, and a group of city motorway and tunnel contracts such as CCT, Western Distributor, M5 East, and LCT.

Queensland includes RAMC, also discussed as QSTC, plus Port of Brisbane and Brisbane Airport road maintenance. Victoria includes WRU and VRMC, with Grampians and Metro East being mobilized for a 2026-07-01 go-live. South Australia includes T2D, which is still under construction, and Western Australia includes Venture Smart, a joint venture where Ventia receives outputs rather than being deeply involved in the operating company.

The [[Transport Data Asset Stakeholder Interview Huy Nguyen]] adds current detail for North East Link in Victoria. Huy works within the Spark consortium during design and mobilisation, with operational phase expected around 2028 and a 25-year operating period from about 2029.

The [[Transport Data Asset Stakeholder Interview Anna Covell]] adds current-state detail for the Queensland cluster. Anna supports RAMCSC, BAC / Brisbane Airport, and Port of Brisbane as shared contracts. Port of Brisbane started around 2020, BAC around 2022 or 2023, and RAMCSC was still BAU while the Gen 3 bid or renewal process continued.

New Zealand includes Auckland West, Transmission Gully, and several smaller Transport projects. A New Zealand business engagement manager was described as working on reporting across contracts, but the source did not capture her name.

## Contract Types

Pranav described a practical distinction between open-road contracts and tunnel or closed-road contracts. Open-road contracts cover distributed GPS locations across wide areas, while tunnel contracts require structured location hierarchies such as buildings, levels, rooms, and assets.

This distinction matters for systems choices. [[Asset Vision]] is the lower-cost operational system used in open-road contexts, while tunnel contracts are expected to use [[Maximo]] because Asset Vision did not fit tunnel requirements. Sydney Harbour Tunnel is already on Maximo, while NZLNNO and T2D are expected to use Maximo as tunnel contracts.

The Rui Luan interview confirmed the same split from the Western Roads Upgrade perspective. Rui described Western Roads Upgrade as an open-road contract using Asset Vision, with open-road work centred on rapid geolocated response, and tunnel work centred on componentised asset hierarchies.

The Toby Lin interview adds that open-road contracts likely share similar road asset categories, including roads, kerb and channel, pits, line marking, and signage, even where the detailed KPI and condition standards differ by contract. This supports reuse of asset-category mapping while keeping [[Transport Asset Condition Inspections]] contract-specific.

The Huy Nguyen interview adds the brand-new tunnel lifecycle. Unlike a short takeover mobilisation where systems and processes already exist, North East Link has spent years defining business processes, management plans, as-built handover formats, metadata, hierarchy, and KPI logic before operations begin.

## Data And Reporting Maturity

The portfolio does not yet have a single centralized report that lists all contracts, dates, data feeds, and reporting status. Pranav recalled an older cross-contract report that included Transport data, but he was unsure whether it remains active.

Large contracts often have their own data people, while smaller contracts usually ask the shared Transport data team for help. WRU appears to have the most mature reporting footprint, while SRAPC appears more mature in technology practices and delivery approach. RAMC reporting uses Power BI dashboards as inputs to monthly PDF reports.

Anna's interview shows a different shared-resource pattern inside the Queensland cluster: she and other resources work across RAMCSC, BAC, and Port of Brisbane. That shared operating model creates an incentive to keep RAMCSC Gen 3 changes aligned with BAC and Port of Brisbane, even though each contract has different billing and KPI requirements.

Huy's interview shows a different tunnel reporting-maturity pattern. North East Link has Databricks and Power BI as intended reporting tools, but much of the current KPI work is synthetic or manually uploaded because Maximo is not yet live. He also noted that other tunnel Maximo data can be difficult to reuse because client-hosted Maximo instances were not historically connected to Ventia Databricks.

The SAP finance walkthrough adds that the [[Transport Financial Reporting]] Power BI filters are not a reliable source of truth for this portfolio. The report is filtered by whether cost appears in the selected month, so a contract may be visible one month and absent the next. Bhupesh Balani said separate Databricks or BW datasets should be used to list all contracts within a sector.

## Related Pages

- [[DB Walkthrough With Pranav Kumar]]
- [[SAP Data Walk-Through Transport Sector]]
- [[Transport Data Asset Stakeholder Interview]]
- [[Transport Data Asset Stakeholder Interview Toby Lin]]
- [[Transport Data Asset Stakeholder Interview Anna Covell]]
- [[Transport Data Asset Stakeholder Interview Huy Nguyen]]
- [[Transport Asset Inventory Validation]]
- [[Transport Asset Condition Inspections]]
- [[Transport Financial Reporting]]
- [[Transport Data Landscape]]
- [[Transport Sector Reporting Opportunities]]
- [[Asset Vision]]
- [[Maximo]]
- [[Ventia Databricks Platform]]
- [[Engagement Team]]
