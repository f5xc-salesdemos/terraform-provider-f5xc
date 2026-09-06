package provider

import (
	"encoding/json"
	"strings"
	"testing"

	"github.com/hashicorp/terraform-plugin-framework/types"

	"github.com/f5-sales-demo/terraform-provider-xcsh/internal/client"
)

func TestNormalizeTokenType(t *testing.T) {
	t.Parallel()

	tests := []struct {
		name    string
		value   interface{}
		want    int64
		wantErr bool
	}{
		{name: "symbolic NORMAL", value: "NORMAL", want: tokenTypeNormal},
		{name: "symbolic JWT", value: "JWT", want: tokenTypeJWT},
		{name: "decoded zero", value: float64(0), want: tokenTypeNormal},
		{name: "decoded one", value: float64(1), want: tokenTypeJWT},
		{name: "int zero", value: 0, want: tokenTypeNormal},
		{name: "int64 one", value: int64(1), want: tokenTypeJWT},
		{name: "json number one", value: json.Number("1"), want: tokenTypeJWT},
		{name: "numeric string", value: "1", wantErr: true},
		{name: "lowercase JWT", value: "jwt", wantErr: true},
		{name: "mixed-case NORMAL", value: "Normal", wantErr: true},
		{name: "fractional float", value: 1.5, wantErr: true},
		{name: "fractional json number", value: json.Number("1.5"), wantErr: true},
		{name: "unknown symbolic name", value: "API_TOKEN", wantErr: true},
		{name: "unsupported negative", value: float64(-1), wantErr: true},
		{name: "unsupported positive", value: int64(2), wantErr: true},
		{name: "boolean", value: true, wantErr: true},
	}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			t.Parallel()
			got, err := normalizeTokenType(test.value)
			if test.wantErr {
				if err == nil {
					t.Fatalf("normalizeTokenType(%T) unexpectedly succeeded with %d", test.value, got)
				}
				if strings.Contains(err.Error(), "JWT") || strings.Contains(err.Error(), "NORMAL") || strings.Contains(err.Error(), "1.5") {
					t.Fatalf("normalization error exposed rejected wire value: %v", err)
				}
				return
			}
			if err != nil {
				t.Fatalf("normalizeTokenType(%T) returned error: %v", test.value, err)
			}
			if got != test.want {
				t.Fatalf("normalizeTokenType(%T) = %d, want %d", test.value, got, test.want)
			}
		})
	}
}

func TestTokenCredentialNormalUsesSystemMetadataUID(t *testing.T) {
	t.Parallel()
	resource := &client.Token{
		Spec:           map[string]interface{}{"type": float64(tokenTypeNormal)},
		SystemMetadata: &client.TokenSystemMetadata{UID: "normal-credential"},
	}

	credential, content, err := tokenCredential(resource, tokenTypeJWT)
	if err != nil {
		t.Fatalf("tokenCredential returned error: %v", err)
	}
	if credential != "normal-credential" {
		t.Fatalf("credential = %q, want normal credential", credential)
	}
	if content != "" {
		t.Fatalf("content = %q, want empty for NORMAL token", content)
	}
}

func TestTokenCredentialJWTUsesSpecContent(t *testing.T) {
	t.Parallel()
	resource := &client.Token{
		Spec: map[string]interface{}{
			"type":    float64(tokenTypeJWT),
			"content": "jwt-credential",
		},
		SystemMetadata: &client.TokenSystemMetadata{UID: "object-uid"},
	}

	credential, content, err := tokenCredential(resource, tokenTypeNormal)
	if err != nil {
		t.Fatalf("tokenCredential returned error: %v", err)
	}
	if credential != "jwt-credential" || content != "jwt-credential" {
		t.Fatalf("JWT credential selection did not use spec.content")
	}
}

func TestTokenCredentialAcceptsSymbolicResponseKinds(t *testing.T) {
	t.Parallel()

	tests := []struct {
		name       string
		resource   *client.Token
		fallback   int64
		credential string
		content    string
	}{
		{
			name: "NORMAL",
			resource: &client.Token{
				Spec:           map[string]interface{}{"type": "NORMAL"},
				SystemMetadata: &client.TokenSystemMetadata{UID: "normal-credential"},
			},
			fallback: tokenTypeJWT, credential: "normal-credential",
		},
		{
			name: "JWT",
			resource: &client.Token{
				Spec: map[string]interface{}{"type": "JWT", "content": "jwt-credential"},
			},
			fallback: tokenTypeNormal, credential: "jwt-credential", content: "jwt-credential",
		},
	}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			t.Parallel()
			credential, content, err := tokenCredential(test.resource, test.fallback)
			if err != nil {
				t.Fatalf("tokenCredential returned error: %v", err)
			}
			if credential != test.credential || content != test.content {
				t.Fatalf("tokenCredential = (%q, %q), want (%q, %q)", credential, content, test.credential, test.content)
			}
		})
	}
}

func TestTokenCredentialUsesConfiguredJWTKindWhenResponseOmitsType(t *testing.T) {
	t.Parallel()
	resource := &client.Token{
		Spec: map[string]interface{}{"content": "jwt-credential"},
	}

	credential, _, err := tokenCredential(resource, tokenTypeJWT)
	if err != nil {
		t.Fatalf("tokenCredential returned error: %v", err)
	}
	if credential != "jwt-credential" {
		t.Fatal("configured JWT fallback did not select spec.content")
	}
}

func TestTokenCredentialFailsClosedWithoutJWTContent(t *testing.T) {
	t.Parallel()
	resource := &client.Token{
		Spec:           map[string]interface{}{"type": float64(tokenTypeJWT)},
		SystemMetadata: &client.TokenSystemMetadata{UID: "must-not-be-used"},
	}

	_, _, err := tokenCredential(resource, tokenTypeNormal)
	if err == nil || !strings.Contains(err.Error(), "missing spec.content") {
		t.Fatalf("tokenCredential error = %v, want missing content diagnostic", err)
	}
	if strings.Contains(err.Error(), "must-not-be-used") {
		t.Fatal("token credential diagnostic exposed a credential")
	}
}

func TestTokenCredentialRejectsUnsupportedKindWithoutEchoingValues(t *testing.T) {
	t.Parallel()
	resource := &client.Token{
		Spec: map[string]interface{}{
			"type":    float64(7),
			"content": "must-not-appear",
		},
	}

	_, _, err := tokenCredential(resource, tokenTypeNormal)
	if err == nil || !strings.Contains(err.Error(), "unsupported token type") {
		t.Fatalf("tokenCredential error = %v, want unsupported type diagnostic", err)
	}
	if strings.Contains(err.Error(), "must-not-appear") {
		t.Fatal("token credential diagnostic exposed credential content")
	}
}

func TestTokenCredentialRejectsMalformedObservedKindInsteadOfFallingBack(t *testing.T) {
	t.Parallel()
	for name, kind := range map[string]interface{}{
		"string":     "1",
		"fractional": 1.5,
	} {
		t.Run(name, func(t *testing.T) {
			t.Parallel()
			resource := &client.Token{
				Spec: map[string]interface{}{
					"type":    kind,
					"content": "must-not-appear",
				},
			}

			_, _, err := tokenCredential(resource, tokenTypeJWT)
			if err == nil || !strings.Contains(err.Error(), "unsupported token type") {
				t.Fatalf("tokenCredential error = %v, want unsupported type diagnostic", err)
			}
			if strings.Contains(err.Error(), "must-not-appear") {
				t.Fatal("token credential diagnostic exposed credential content")
			}
		})
	}
}

func TestPopulateTokenCredentialStateSetsSensitiveOutputs(t *testing.T) {
	t.Parallel()
	data := TokenResourceModel{Type: types.Int64Value(tokenTypeJWT)}
	resource := &client.Token{
		Spec: map[string]interface{}{"content": "jwt-credential"},
	}

	if err := populateTokenCredentialState(&data, resource); err != nil {
		t.Fatalf("populateTokenCredentialState returned error: %v", err)
	}
	if data.Uid.ValueString() != "jwt-credential" {
		t.Fatal("uid did not expose the selected JWT credential")
	}
	if data.Content.ValueString() != "jwt-credential" {
		t.Fatal("content did not expose the JWT response field")
	}
}

func TestPopulateTokenCredentialStateNormalizesSymbolicType(t *testing.T) {
	t.Parallel()
	data := TokenResourceModel{Type: types.Int64Null()}
	resource := &client.Token{
		Spec: map[string]interface{}{
			"type":    "JWT",
			"content": "jwt-credential",
		},
	}

	if err := populateTokenCredentialState(&data, resource); err != nil {
		t.Fatalf("populateTokenCredentialState returned error: %v", err)
	}
	if data.Type.IsNull() || data.Type.ValueInt64() != tokenTypeJWT {
		t.Fatalf("type = %v, want normalized JWT integer", data.Type)
	}
}
