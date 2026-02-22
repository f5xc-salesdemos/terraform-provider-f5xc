#!/usr/bin/env bash
# Repository-specific pre-commit hooks for the Terraform provider.
# Called by the managed .pre-commit-config.yaml escape hatch.
#
# These checks complement super-linter with Go/Terraform-specific
# validations that benefit from running locally before push.

set -euo pipefail

FAILED=0

echo "=== Go checks ==="

# golangci-lint (only if installed)
if command -v golangci-lint &>/dev/null; then
  echo "[run] golangci-lint"
  if ! golangci-lint run --timeout=5m ./internal/... .; then
    FAILED=1
  fi
else
  echo "[skip] golangci-lint not installed"
fi

# go vet
echo "[run] go vet"
if ! go vet ./...; then
  FAILED=1
fi

# go build
echo "[run] go build"
if ! go build -v .; then
  FAILED=1
fi

# go mod tidy check
echo "[run] go mod tidy check"
cp go.mod go.mod.bak
cp go.sum go.sum.bak
go mod tidy
if ! diff -q go.mod go.mod.bak &>/dev/null || ! diff -q go.sum go.sum.bak &>/dev/null; then
  echo "ERROR: go.mod or go.sum is not tidy — run 'go mod tidy' and commit"
  mv go.mod.bak go.mod
  mv go.sum.bak go.sum
  FAILED=1
else
  rm -f go.mod.bak go.sum.bak
fi

echo "=== Terraform checks ==="

# terraform fmt (only if terraform is installed and examples/ exists)
if command -v terraform &>/dev/null && [ -d examples ]; then
  echo "[run] terraform fmt -check"
  if ! terraform fmt -check -diff -recursive examples/; then
    FAILED=1
  fi
else
  echo "[skip] terraform not installed or no examples/ directory"
fi

echo "=== Generated file checks ==="

# Block commits of generated files
if [ -x scripts/check-no-generated-files.sh ]; then
  echo "[run] check-no-generated-files"
  if ! scripts/check-no-generated-files.sh; then
    FAILED=1
  fi
else
  echo "[skip] check-no-generated-files.sh not found"
fi

if [ "$FAILED" -ne 0 ]; then
  echo ""
  echo "Pre-commit local hooks FAILED"
  exit 1
fi

echo ""
echo "All local hooks passed"
