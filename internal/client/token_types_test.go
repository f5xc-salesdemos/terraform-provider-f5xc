package client

import (
	"context"
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestTokenClientSendsNumericEnumAndDecodesSymbolicResponse(t *testing.T) {
	t.Parallel()

	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		defer r.Body.Close()
		var request Token
		if err := json.NewDecoder(r.Body).Decode(&request); err != nil {
			t.Errorf("decode token request: %v", err)
			http.Error(w, "invalid request", http.StatusBadRequest)
			return
		}
		if got, ok := request.Spec["type"].(float64); !ok || got != 1 {
			t.Errorf("request type = %#v (%T), want numeric 1", request.Spec["type"], request.Spec["type"])
		}
		w.Header().Set("Content-Type", "application/json")
		_, _ = w.Write([]byte(`{"metadata":{"name":"jwt-test","namespace":"system"},"spec":{"type":"JWT","content":"server-issued"}}`))
	}))
	defer server.Close()

	c := NewClient(server.URL, "test-api-token", WithMaxRetries(0))
	got, err := c.CreateToken(context.Background(), &Token{
		Metadata: Metadata{Name: "jwt-test", Namespace: "system"},
		Spec:     map[string]interface{}{"type": int64(1), "site_name": "test-site"},
	})
	if err != nil {
		t.Fatalf("CreateToken returned error: %v", err)
	}
	if got.Spec["type"] != "JWT" {
		t.Fatalf("response type = %#v, want symbolic JWT", got.Spec["type"])
	}
}
