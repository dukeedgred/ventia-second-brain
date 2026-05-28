---
type: entity
topic: Ventia
sources: ["raw/DAII Monthly Meeting Transcript.md"]
date-created: 2026-05-28
date-updated: 2026-05-28
tags: [ai-agent, data-engineering, databricks, enterprise-data-warehouse]
---

# EDW Ernie

EDW Ernie is an AI agent demonstrated by Kevin Lu for enterprise data warehouse design and remediation. It is connected to Databricks metadata and is intended to understand how bronze, silver, and gold data assets connect across a large warehouse estate.

## Capabilities Demonstrated

- Peer review a poorly designed view against naming conventions, hash-key expectations, and other warehouse standards.
- Produce a corrected version of SQL or view logic for a data engineer to refine.
- Search Databricks metadata to find reusable dimensions, tables, and views for a specific SAP table or column.
- Recommend design patterns for new facts and views while avoiding duplicated data assets.
- Draft SQL aligned with the existing gold-layer standards.
- Potentially create views in a Databricks test environment, run jobs, test output, and debug issues.

## Intended Value

The agent is expected to save time and cost by doing bulk search and first-pass design work that would otherwise be repetitive for data engineers. The team described it as capable of doing roughly 60 to 70 percent of some tasks before a data engineer refines and validates the result.

## Future Direction

The team wants EDW Ernie to support BW replatforming as SAP BW is decommissioned and enterprise reporting centralises in Databricks. Future users may include reporting sector leads and report builders, not only data engineers. A further aspiration is for Ernie to monitor research logs and suggest optimisations or fixes.

## Related Pages

- [[Ventia Data Platform Modernisation]]
- [[Ventia AI and Innovation Portfolio]]
- [[DAII Monthly Meeting Transcript]]
