package provider_test

import (
	"regexp"
	"testing"

	"github.com/hashicorp/terraform-plugin-testing/helper/resource"
	"github.com/hashicorp/terraform-plugin-testing/plancheck"
	"github.com/hashicorp/terraform-plugin-testing/tfjsonpath"

	"github.com/f5-sales-demo/terraform-provider-xcsh/internal/acctest"
)

func TestMockTokenResource_basic(t *testing.T) {
	resourceName := "xcsh_token.test"

	acctest.SkipIfNoMockMode(t)
	mockCfg := acctest.SetupMockTest(t)
	defer mockCfg.Cleanup()

	resource.Test(t, resource.TestCase{
		ProtoV6ProviderFactories: mockCfg.ProtoV6ProviderFactories(),
		Steps: []resource.TestStep{
			{
				Config: `
				resource "xcsh_token" "test" {
					name      = "test-token"
					namespace = "system"
				}

				output "test_token" {
					value     = xcsh_token.test.uid
					sensitive = true
				}
				`,
				ConfigPlanChecks: resource.ConfigPlanChecks{
					PreApply: []plancheck.PlanCheck{
						// The uid should be completely masked in output (sensitive)
						plancheck.ExpectResourceAction(resourceName, plancheck.ResourceActionCreate),
						plancheck.ExpectSensitiveValue(resourceName, tfjsonpath.New("uid")),
					},
				},
				Check: resource.ComposeAggregateTestCheckFunc(
					resource.TestCheckResourceAttr(resourceName, "name", "test-token"),
					resource.TestCheckResourceAttr(resourceName, "namespace", "system"),
					resource.TestCheckResourceAttr(resourceName, "type", "0"),
					// Test that the uid output is generated (but we can't test tf's internal masking here easily,
					// so we just make sure we get *a* value and the resource applies cleanly)
					resource.TestMatchResourceAttr(resourceName, "uid", regexp.MustCompile(`(^[0-9a-fA-F-]+$|^mock-uid-[0-9]+$)`)),
				),
			},
			{
				// Prove that Terraform refuses to output the sensitive UID if the module author forgets `sensitive = true`
				Config: `
				resource "xcsh_token" "test" {
					name      = "test-token"
					namespace = "system"
				}

				output "unmasked_token" {
					value = xcsh_token.test.uid
				}
				`,
				ExpectError: regexp.MustCompile("Output refers to sensitive values"),
			},
		},
	})
}

func TestMockTokenResource_siteBoundJWT(t *testing.T) {
	resourceName := "xcsh_token.test"

	acctest.SkipIfNoMockMode(t)
	mockCfg := acctest.SetupMockTest(t)
	defer mockCfg.Cleanup()

	resource.Test(t, resource.TestCase{
		ProtoV6ProviderFactories: mockCfg.ProtoV6ProviderFactories(),
		Steps: []resource.TestStep{
			{
				Config: `
				resource "xcsh_token" "test" {
					name      = "test-token-jwt"
					namespace = "system"
					type      = 1
					site_name = "example-securemesh-site"
				}

				output "jwt_credential" {
					value     = xcsh_token.test.uid
					sensitive = true
				}
				`,
				ConfigPlanChecks: resource.ConfigPlanChecks{
					PreApply: []plancheck.PlanCheck{
						plancheck.ExpectResourceAction(resourceName, plancheck.ResourceActionCreate),
						plancheck.ExpectSensitiveValue(resourceName, tfjsonpath.New("uid")),
						plancheck.ExpectSensitiveValue(resourceName, tfjsonpath.New("content")),
					},
				},
				Check: resource.ComposeAggregateTestCheckFunc(
					resource.TestCheckResourceAttr(resourceName, "type", "1"),
					resource.TestCheckResourceAttr(resourceName, "site_name", "example-securemesh-site"),
					resource.TestCheckResourceAttr(resourceName, "uid", "mock-jwt-credential"),
					resource.TestCheckResourceAttr(resourceName, "content", "mock-jwt-credential"),
				),
			},
			{
				Config: `
				resource "xcsh_token" "test" {
					name      = "test-token-jwt"
					namespace = "system"
					type      = 1
					site_name = "example-securemesh-site"
				}

				output "jwt_credential" {
					value     = xcsh_token.test.uid
					sensitive = true
				}
				`,
				ConfigPlanChecks: resource.ConfigPlanChecks{
					PreApply: []plancheck.PlanCheck{plancheck.ExpectEmptyPlan()},
				},
			},
			{
				ResourceName:            resourceName,
				ImportState:             true,
				ImportStateId:           "system/test-token-jwt",
				ImportStateVerify:       true,
				ImportStateVerifyIgnore: []string{"timeouts"},
			},
			{
				Config: `
				resource "xcsh_token" "test" {
					name      = "test-token-jwt"
					namespace = "system"
					type      = 1
					site_name = "example-securemesh-site"
				}

				output "jwt_credential" {
					value     = xcsh_token.test.uid
					sensitive = true
				}
				`,
				ConfigPlanChecks: resource.ConfigPlanChecks{
					PreApply: []plancheck.PlanCheck{plancheck.ExpectEmptyPlan()},
				},
			},
		},
	})
}

func TestMockTokenResource_rejectsInvalidJWTConfiguration(t *testing.T) {
	acctest.SkipIfNoMockMode(t)
	mockCfg := acctest.SetupMockTest(t)
	defer mockCfg.Cleanup()

	resource.Test(t, resource.TestCase{
		ProtoV6ProviderFactories: mockCfg.ProtoV6ProviderFactories(),
		Steps: []resource.TestStep{
			{
				Config: `
				resource "xcsh_token" "test" {
					name      = "invalid-token-type"
					namespace = "system"
					type      = 2
				}
				`,
				ExpectError: regexp.MustCompile(`Token type must be 0 \(NORMAL\) or 1 \(JWT\)`),
			},
			{
				Config: `
				resource "xcsh_token" "test" {
					name      = "jwt-without-site"
					namespace = "system"
					type      = 1
				}
				`,
				ExpectError: regexp.MustCompile("site_name must identify the Secure Mesh Site v2"),
			},
		},
	})
}
