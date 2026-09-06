package provider

import (
	"encoding/json"
	"errors"
	"strings"

	"github.com/hashicorp/terraform-plugin-framework/types"

	"github.com/f5-sales-demo/terraform-provider-xcsh/internal/client"
)

const (
	tokenTypeNormal int64 = 0
	tokenTypeJWT    int64 = 1
)

func tokenKindFromSpec(spec map[string]interface{}) (int64, bool, error) {
	value, ok := spec["type"]
	if !ok {
		return 0, false, nil
	}
	kind, err := normalizeTokenType(value)
	if err != nil {
		return 0, true, err
	}
	return kind, true, nil
}

// normalizeTokenType converts the two wire representations returned by XC into
// the provider's stable integer contract. Errors intentionally omit the rejected
// value so diagnostics cannot echo unexpected server data or credential material.
func normalizeTokenType(value interface{}) (int64, error) {
	var kind int64
	switch typed := value.(type) {
	case string:
		switch typed {
		case "NORMAL":
			return tokenTypeNormal, nil
		case "JWT":
			return tokenTypeJWT, nil
		default:
			return 0, errors.New("token response contains an unsupported token type")
		}
	case float64:
		switch typed {
		case 0:
			return tokenTypeNormal, nil
		case 1:
			return tokenTypeJWT, nil
		default:
			return 0, errors.New("token response contains an unsupported token type")
		}
	case int64:
		kind = typed
	case int:
		kind = int64(typed)
	case json.Number:
		parsed, err := typed.Int64()
		if err != nil {
			return 0, errors.New("token response contains an unsupported token type")
		}
		kind = parsed
	default:
		return 0, errors.New("token response contains an unsupported token type")
	}
	if kind != tokenTypeNormal && kind != tokenTypeJWT {
		return 0, errors.New("token response contains an unsupported token type")
	}
	return kind, nil
}

func tokenCredential(resource *client.Token, fallbackKind int64) (credential string, content string, err error) {
	if resource == nil {
		return "", "", errors.New("token response is missing")
	}

	kind := fallbackKind
	observed, ok, normalizeErr := tokenKindFromSpec(resource.Spec)
	if normalizeErr != nil {
		return "", "", normalizeErr
	}
	if ok {
		kind = observed
	}
	if kind != tokenTypeNormal && kind != tokenTypeJWT {
		return "", "", errors.New("token response contains an unsupported token type")
	}

	if kind == tokenTypeJWT {
		content, _ = resource.Spec["content"].(string)
		if strings.TrimSpace(content) == "" {
			return "", "", errors.New("JWT token response is missing spec.content")
		}
		return content, content, nil
	}

	if resource.SystemMetadata == nil || strings.TrimSpace(resource.SystemMetadata.UID) == "" {
		return "", "", errors.New("NORMAL token response is missing system_metadata.uid")
	}
	return resource.SystemMetadata.UID, "", nil
}

func populateTokenCredentialState(data *TokenResourceModel, resource *client.Token) error {
	fallbackKind := tokenTypeNormal
	if !data.Type.IsNull() && !data.Type.IsUnknown() {
		fallbackKind = data.Type.ValueInt64()
	}
	kind := fallbackKind
	observed, ok, normalizeErr := tokenKindFromSpec(resource.Spec)
	if normalizeErr != nil {
		return normalizeErr
	}
	if ok {
		kind = observed
	}
	if kind != tokenTypeNormal && kind != tokenTypeJWT {
		return errors.New("token response contains an unsupported token type")
	}
	credential, content, err := tokenCredential(resource, fallbackKind)
	if err != nil {
		return err
	}
	data.Type = types.Int64Value(kind)
	data.Uid = types.StringValue(credential)
	if content == "" {
		data.Content = types.StringNull()
	} else {
		data.Content = types.StringValue(content)
	}
	return nil
}
