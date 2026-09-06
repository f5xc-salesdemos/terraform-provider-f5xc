package mocks

import (
	"bytes"
	"encoding/json"
	"net/http"
	"testing"
)

func TestTokenResponsesUseSymbolicEnums(t *testing.T) {
	t.Parallel()

	tests := []struct {
		name        string
		request     string
		wantType    string
		wantContent bool
	}{
		{name: "NORMAL", request: `{"metadata":{"name":"normal-token","namespace":"system"},"spec":{"type":0}}`, wantType: "NORMAL"},
		{name: "JWT", request: `{"metadata":{"name":"jwt-token","namespace":"system"},"spec":{"type":1,"site_name":"test-site"}}`, wantType: "JWT", wantContent: true},
	}

	for _, test := range tests {
		t.Run(test.name, func(t *testing.T) {
			t.Parallel()
			server := NewServer()
			defer server.Close()

			response, err := http.Post(server.URL()+"/api/register/namespaces/system/tokens", "application/json", bytes.NewBufferString(test.request)) //nolint:noctx // local test server
			if err != nil {
				t.Fatalf("create token: %v", err)
			}
			defer response.Body.Close()
			var body map[string]interface{}
			if err := json.NewDecoder(response.Body).Decode(&body); err != nil {
				t.Fatalf("decode token response: %v", err)
			}
			spec, ok := body["spec"].(map[string]interface{})
			if !ok {
				t.Fatalf("response spec = %#v", body["spec"])
			}
			if spec["type"] != test.wantType {
				t.Fatalf("response type = %#v, want %q", spec["type"], test.wantType)
			}
			_, hasContent := spec["content"]
			if hasContent != test.wantContent {
				t.Fatalf("response content presence = %t, want %t", hasContent, test.wantContent)
			}
		})
	}
}
