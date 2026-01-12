// Copyright (c) 2026 Robin Mordasiewicz. MIT License.

//go:build ignore
// +build ignore

// This tool queries the F5 Distributed Cloud catalog API to generate
// subscription tier metadata for resources. This metadata is used by
// documentation generators and the MCP server to indicate which resources
// require Advanced subscription tiers.
//
// Usage:
//   F5XC_API_URL="https://..." F5XC_P12_FILE="..." F5XC_P12_PASSWORD="..." go run tools/generate-subscription-metadata.go
//
// Environment Variables:
//   F5XC_API_URL      - F5 XC API URL (e.g., https://console.ves.volterra.io)
//   F5XC_P12_FILE     - Path to P12 certificate file
//   F5XC_P12_PASSWORD - Password for P12 file
//   F5XC_API_TOKEN    - API token (alternative to P12 auth)
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"time"

	"github.com/f5xc/terraform-provider-f5xc/internal/client"
)

// CatalogListRequest is the request body for the catalog API
type CatalogListRequest struct {
	// Empty request to get full catalog
}

// CatalogListResponse is the response from the catalog API
type CatalogListResponse struct {
	AddonServices map[string]AddonServiceInfo `json:"addon_services"`
	Services      map[string]ServiceInfo      `json:"services"`
	Workspaces    map[string]WorkspaceInfo    `json:"workspaces"`
	UseCases      map[string]UseCaseInfo      `json:"use_cases"`
}

// AddonServiceInfo contains addon service details from catalog
type AddonServiceInfo struct {
	Tier                    string `json:"tier"`
	DisplayName             string `json:"display_name"`
	AddonServiceGroupName   string `json:"addon_service_group_name"`
}

// ServiceInfo contains service details from catalog
type ServiceInfo struct {
	Name                   string   `json:"name"`
	DisplayName            string   `json:"display_name"`
	Description            string   `json:"description"`
	Tier                   string   `json:"tier"`
	AccessStatus           string   `json:"access_status"`
	AddonServiceStatus     string   `json:"addon_service_status"`
	AddonServiceGroupStatus string   `json:"addon_service_group_status"`
	Tags                   []string `json:"tags"`
}

// WorkspaceInfo contains workspace details from catalog
type WorkspaceInfo struct {
	Name             string   `json:"name"`
	DisplayName      string   `json:"display_name"`
	Services         []string `json:"services"`
	RequiredServices []string `json:"required_services"`
	OptionalServices []string `json:"optional_services"`
}

// UseCaseInfo contains use case details from catalog
type UseCaseInfo struct {
	Name        string   `json:"name"`
	DisplayName string   `json:"display_name"`
	Workspaces  []string `json:"workspaces"`
	Order       int      `json:"order"`
}

// SubscriptionMetadata is the output format for subscription tier metadata
type SubscriptionMetadata struct {
	GeneratedAt string                       `json:"generated_at"`
	Source      string                       `json:"source"`
	Services    map[string]ServiceMetadata   `json:"services"`
	Resources   map[string]ResourceMetadata  `json:"resources"`
}

// ServiceMetadata contains metadata about an addon service
type ServiceMetadata struct {
	Tier        string `json:"tier"`
	DisplayName string `json:"display_name"`
	GroupName   string `json:"group_name,omitempty"`
}

// ResourceMetadata contains subscription metadata for a Terraform resource
type ResourceMetadata struct {
	Service         string   `json:"service"`
	MinimumTier     string   `json:"minimum_tier"`
	AdvancedFeatures []string `json:"advanced_features,omitempty"`
}

func main() {
	// Get credentials from environment
	apiURL := os.Getenv("F5XC_API_URL")
	p12File := os.Getenv("F5XC_P12_FILE")
	p12Password := os.Getenv("F5XC_P12_PASSWORD")
	apiToken := os.Getenv("F5XC_API_TOKEN")

	if apiURL == "" {
		fmt.Fprintln(os.Stderr, "Error: F5XC_API_URL environment variable is required")
		os.Exit(1)
	}

	var apiClient *client.Client
	var err error

	// Try P12 authentication first, then fall back to token
	if p12File != "" && p12Password != "" {
		apiClient, err = client.NewClientWithP12(apiURL, p12File, p12Password)
		if err != nil {
			fmt.Fprintf(os.Stderr, "Error creating client with P12: %v\n", err)
			os.Exit(1)
		}
		fmt.Println("Using P12 certificate authentication")
	} else if apiToken != "" {
		apiClient = client.NewClient(apiURL, apiToken)
		fmt.Println("Using API token authentication")
	} else {
		fmt.Fprintln(os.Stderr, "Error: Either F5XC_P12_FILE+F5XC_P12_PASSWORD or F5XC_API_TOKEN is required")
		os.Exit(1)
	}

	// Query the catalog API
	ctx, cancel := context.WithTimeout(context.Background(), 60*time.Second)
	defer cancel()

	var catalogResp CatalogListResponse
	err = apiClient.Put(ctx, "/api/web/namespaces/system/catalogs", CatalogListRequest{}, &catalogResp)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error querying catalog API: %v\n", err)
		os.Exit(1)
	}

	fmt.Printf("Retrieved catalog with %d addon services, %d services, %d workspaces\n",
		len(catalogResp.AddonServices), len(catalogResp.Services), len(catalogResp.Workspaces))

	// Build subscription metadata
	metadata := buildSubscriptionMetadata(catalogResp)

	// Write output file
	outputPath := "tools/subscription-tiers.json"

	// Check if existing file has same content (ignoring timestamp)
	// to avoid unnecessary changes during pre-commit hooks
	if existingData, err := os.ReadFile(outputPath); err == nil {
		var existingMeta SubscriptionMetadata
		if json.Unmarshal(existingData, &existingMeta) == nil {
			// Compare content without timestamps
			existingMeta.GeneratedAt = ""
			metadataCompare := metadata
			metadataCompare.GeneratedAt = ""

			existingJSON, _ := json.Marshal(existingMeta)
			newJSON, _ := json.Marshal(metadataCompare)

			if string(existingJSON) == string(newJSON) {
				fmt.Printf("No changes detected in %s (keeping existing file)\n", outputPath)
				fmt.Printf("Existing file has %d services and %d resources\n",
					len(existingMeta.Services), len(existingMeta.Resources))
				return
			}
		}
	}

	outputData, err := json.MarshalIndent(metadata, "", "  ")
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error marshaling metadata: %v\n", err)
		os.Exit(1)
	}

	// Add trailing newline for POSIX compliance
	outputData = append(outputData, '\n')

	if err := os.WriteFile(outputPath, outputData, 0644); err != nil {
		fmt.Fprintf(os.Stderr, "Error writing output file: %v\n", err)
		os.Exit(1)
	}

	fmt.Printf("Generated %s with %d services and %d resources\n",
		outputPath, len(metadata.Services), len(metadata.Resources))
}

func buildSubscriptionMetadata(catalog CatalogListResponse) SubscriptionMetadata {
	metadata := SubscriptionMetadata{
		GeneratedAt: time.Now().UTC().Format(time.RFC3339),
		Source:      "F5 XC Catalog API",
		Services:    make(map[string]ServiceMetadata),
		Resources:   make(map[string]ResourceMetadata),
	}

	// Extract service tier information from catalog
	for name, svc := range catalog.AddonServices {
		metadata.Services[name] = ServiceMetadata{
			Tier:        svc.Tier,
			DisplayName: svc.DisplayName,
			GroupName:   svc.AddonServiceGroupName,
		}
	}

	// Also extract from services if addon_services is empty
	for name, svc := range catalog.Services {
		if _, exists := metadata.Services[name]; !exists {
			metadata.Services[name] = ServiceMetadata{
				Tier:        svc.Tier,
				DisplayName: svc.DisplayName,
			}
		}
	}

	// Note: V2 specs are domain-organized; resource-to-service mapping
	// is derived from x-f5xc-* extensions in the v2 domain specs.
	// Resource metadata from V2 specs is populated during provider generation.

	return metadata
}
