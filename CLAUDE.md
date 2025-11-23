# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Community-driven Terraform provider for F5 Distributed Cloud (F5XC) built using the HashiCorp Terraform Plugin Framework. The provider implements F5's public OpenAPI specifications to manage F5XC resources via Terraform.

## Build & Development Commands

```bash
# Build the provider binary
go build -o terraform-provider-f5xc

# Run all tests
go test ./...

# Run acceptance tests (requires F5XC_API_TOKEN)
TF_ACC=1 go test ./... -v -timeout 120m

# Generate documentation (requires terraform CLI)
go generate ./...

# Install locally for testing
mkdir -p ~/.terraform.d/plugins/registry.terraform.io/robinmordasiewicz/f5xc/0.1.0/darwin_arm64
cp terraform-provider-f5xc ~/.terraform.d/plugins/registry.terraform.io/robinmordasiewicz/f5xc/0.1.0/darwin_arm64/
```

## Architecture

### Directory Structure

- `main.go` - Provider entry point with version injection via goreleaser
- `internal/provider/` - All Terraform resources and data sources
- `internal/client/` - F5XC API client (HTTP client with CRUD operations and type definitions)
- `tools/` - Code generation utilities for scaffolding new resources from OpenAPI specs
- `docs/` - Auto-generated provider documentation for Terraform Registry
- `examples/` - Example Terraform configurations

### Resource Implementation Pattern

Each resource follows the Terraform Plugin Framework pattern:

1. **Resource struct** implementing `resource.Resource`, `resource.ResourceWithConfigure`, `resource.ResourceWithImportState`
2. **Model struct** with `tfsdk` tags for state management
3. **CRUD methods**: `Create`, `Read`, `Update`, `Delete`
4. **Registration** in `provider.go` via `Resources()` function

Example reference: `internal/provider/namespace_resource.go`

### Client Architecture

`internal/client/client.go` contains:

- HTTP client wrapper for F5XC API (`Client` struct)
- Type definitions for all F5XC resources (e.g., `Namespace`, `HTTPLoadBalancer`)
- CRUD methods for each resource type following pattern: `Create{Resource}`, `Get{Resource}`, `Update{Resource}`, `Delete{Resource}`

API authentication uses Bearer token: `Authorization: APIToken {token}`

### Code Generation

The `tools/` directory contains generators for scaffolding resources from F5 OpenAPI specs:

- `generate-resources.go` - Generates resource files from OpenAPI specs
- `generate-client-types.go` - Generates client type definitions
- `batch-generate.sh` - Batch generation script

## Environment Variables

- `F5XC_API_TOKEN` - Required API token for F5 Distributed Cloud
- `F5XC_API_URL` - Optional API URL (defaults to `https://console.ves.volterra.io/api`)
- `TF_ACC=1` - Enable acceptance tests

## Key Dependencies

- `github.com/hashicorp/terraform-plugin-framework` - Core Terraform provider SDK
- `github.com/hashicorp/terraform-plugin-log` - Structured logging

## Release Process

Releases are automated via GoReleaser on tag push (`v*`). The workflow:

1. Builds cross-platform binaries
2. Signs checksums with GPG
3. Publishes to GitHub Releases with Terraform Registry manifest
