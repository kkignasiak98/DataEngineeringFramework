# ADR: Terragrunt vs Terramate

**Status**: Accepted

## Context

We evaluated **Terragrunt** and **Terramate** as orchestration tools for our Terraform-based Infrastructure as Code.

## Decision

Use **Terragrunt** for IaC orchestration.

## Comparison

| | Terragrunt | Terramate |
|----------|------------|-----------|
| **Maturity** | Battle-tested, widely adopted by large organizations | Newer, less proven |
| **Approach** | Framework (enforces structure) | Utility (flexible) |
| **Environment Support** | Mature, versatile, well-documented | Recently added, poorly documented |
| **File Generation** | Minimal additional files | Generates many files  |
| **Complexity** | Excellent for complex IaC | Better for simpler setups |

## Rationale

Terragrunt's framework approach provides the structure and maturity required for our complex infrastructure needs. Terramate, while useful, lacks mature environment support and generates excessive files.
