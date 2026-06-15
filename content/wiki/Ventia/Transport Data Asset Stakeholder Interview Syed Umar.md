---
type: source-summary
topic: Ventia
sources: ["raw/Transport Data Asset Stakeholder Interview-20260609_160356-Meeting Recording Syed Umar.md"]
date-created: 2026-06-15
date-updated: 2026-06-15
tags: [transport, data-asset, stakeholder-interview, maximo, tunnel, hand-back, systems, mobilization, source-summary]
---

# Transport Data Asset Stakeholder Interview Syed Umar

This source is a stakeholder interview transcript from 2026-06-09 with Syed Umar Anis, Yinlun Pan, and the Transport data asset discovery team. It covers Syed's asset-management systems role on North East Link, the distinction between client hand-back systems and Ventia corporate systems, D&C-to-operations data transition, Maximo integration choices, and reusable learnings from other tunnel projects.

## Summary

Syed Umar Anis is an Asset Management Specialist on North East Link. From Ventia's operations perspective the project is effectively pre-mobilization, although the contract itself is in design and construction. His role is to evaluate systems used by design and construction partners, decide whether the system or only its data should transition into operations, and work with Ventia engineers to set up systems that support asset management, lifecycle, maintenance, and operational requirements.

The interview adds a system-governance layer to [[Transport Data Landscape]]. Syed distinguished [[Transport Hand-Back Systems]] from Ventia corporate systems. Hand-back systems contain the tunnel data and operating processes that must stay with the tunnel or transfer to the client at contract end. Corporate systems such as SAP, Databricks, Excel, SharePoint, and Power BI can support Ventia's internal processes and analysis, but cannot be the only operational system where the contract requires a transferable tunnel system.

For North East Link, [[Maximo]] is the primary asset-management hand-back system. Syed said Ventia is responsible for choosing and configuring the system, but at contract end the hosting and licensing arrangements can be novated to the client and Ventia must sever corporate integrations. Some tunnel-local systems are not cloud-based and simply remain with the tunnel when the operator changes.

The data transition from D&C into operations includes asset data, asset attributes, manufacturer-supplied M&E information, maintenance requirements, spare parts, and consumables. D&C partners may provide this through spreadsheets, APIs, or system downloads; the operations team then transforms and uploads the data into the operational asset-management system. Syed framed this as a one-time or limited transition event rather than a major ongoing automation concern.

Syed also described likely overlap between tunnel systems and corporate systems. Inventory and procurement may begin from a Maximo or tunnel-system demand signal, then require SAP or corporate process entry for purchasing and financial control. Lean integrations may still leave some weekly or monthly double entry, while deep integrations can be costly, rigid, and difficult to maintain.

## Key Details

- Contract requirements ultimately determine which systems are hand-back systems, but interpretation may require discussion with the client.
- North East Link gives Ventia more administrative control over Maximo than some other tunnel contracts where the client procures and controls the system.
- Client-hosted or tunnel-local systems can limit Ventia's ability to provide access to others or extract data into corporate platforms.
- Databricks and Power BI are seen as standard Ventia building blocks, but new project teams may need to talk to many people before understanding which platforms to use for which purpose.
- Cross-project learning needs include the alarm journey from operational technology into IT work management, the systems used, data captured, reports built, failure modes, design life, inspection sheets, failure hierarchies, and asset-type-specific maintenance patterns.
- Similar tunnel assets such as jet fans can make another project's data useful, but differences in systems, contract obligations, and asset design still require project-to-project validation.
- Central documentation can help as guidance, especially for common artefacts such as asset management plans, but a single shared document-management system is unlikely because folder structures and document systems can be contractually agreed with clients.
- Syed noted governance and confidentiality constraints because North East Link is a consortium, T2D is an alliance, and other contracts may have different operating models.
- Syed could not speak from direct North East Link operational-phase experience because the project has not yet entered operations.
- The raw source contains no URLs.

## Connections

- [[Transport Hand-Back Systems]]
- [[Maximo]]
- [[Integrated Transport Data Asset]]
- [[Transport Data Landscape]]
- [[Transport Contract Portfolio]]
- [[Transport Asset Inventory Validation]]
- [[Transport Sector Reporting Opportunities]]
- [[Ventia Databricks Platform]]
- [[Engagement Team]]

## Open Questions

- Which North East Link systems are formally classified as hand-back systems versus Ventia corporate support systems?
- What level of integration will North East Link choose between Maximo, SAP, Databricks, and other corporate tools?
- Which inventory, procurement, demand, and financial fields will require manual double entry or lean integration between tunnel and corporate systems?
- Which alarm-to-maintenance workflow data should be standardised across tunnel projects for future bid and mobilisation reuse?
- Which central documentation artefacts can be reused safely across consortium, alliance, and client-controlled operating models?
