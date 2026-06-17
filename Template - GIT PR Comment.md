## PR Review — required changes before merge

### Azure Policy — Key Vault deny constraints

All policies below are enforced at `mg-sd-landing-zones` and inherited by the `Non-Production - Data Services` subscription. Any `deny` not satisfied will fail the apply with `RequestDisallowedByPolicy`.

| Policy | Requirement | Current status |
| :--- | :--- | :--- |
| `deny-kv-naming-convention` | Name must match `kv-sd-*` | ✅ `kv-${var.prefix}-${var.environment}` → `kv-sd-data-svc-dev` |
| `deny-kv-no-rbac` | `enableRbacAuthorization = true` | ❌ Missing — will deny |
| `deny-kv-public-network` | `publicNetworkAccess = "Disabled"` | ❌ Missing — will deny |
| `deny-kv-no-firewall` | Firewall with default-deny required | ❌ Missing — will deny |
| `deny-kv-soft-delete` | Soft delete enabled, retention ≥ 90 days | ✅ `soft_delete_retention_days = 90` |
| `deny-kv-purge-protection` | Purge protection enabled | ✅ `purge_protection_enabled = true` |

Audit-only (non-compliant but won't block apply): `audit-kv-diagnostics` (deferred — Log Analytics disabled), `audit-kv-secret-expiry` (must set `expiration_date` on every secret added in future PRs).

---

### 1. Fix wrong data source provider name — `azure_key_vault/main.tf`

```hcl
# Wrong — will error at plan
data "azure_rm_client_config" "current" {}

# Correct
data "azurerm_client_config" "current" {}
```

---

### 2. Add missing policy-required settings — `azure_key_vault/main.tf`

```hcl
resource "azurerm_key_vault" "this" {
  name                = "kv-${var.prefix}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  enable_rbac_authorization     = true       # deny-kv-no-rbac
  public_network_access_enabled = false      # deny-kv-public-network
  soft_delete_retention_days    = var.soft_delete_retention_days
  purge_protection_enabled      = true

  network_acls {                             # deny-kv-no-firewall
    default_action = "Deny"
    bypass         = ["AzureServices"]
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = var.tags
}
```

---

### 3. Remove unused `tenant_id` variable — three places

The module uses `data.azurerm_client_config.current.tenant_id` so `var.tenant_id` is never referenced. Remove it from:

- `azure_key_vault/variables.tf` — delete the `variable "tenant_id"` block
- `environments/dev/main.tf` — remove `tenant_id = var.tenant_id` from the module call
- `environments/dev/variables.tf` — delete the `variable "tenant_id"` block

---

### 4. Remove unused `key_vault_name` variable — three places

`main.tf` hardcodes `kv-${var.prefix}-${var.environment}` and never references `var.key_vault_name`. Remove it from:

- `azure_key_vault/variables.tf` — delete the `variable "key_vault_name"` block
- `environments/dev/main.tf` — remove `key_vault_name = var.key_vault_name` from the module call
- `environments/dev/variables.tf` — delete the `variable "key_vault_name"` block

---

### 5. Fix missing EOF newlines

All modified files are missing a trailing newline. Run `pre-commit run --all-files` locally before pushing — the `fix end of files` hook will correct them automatically.