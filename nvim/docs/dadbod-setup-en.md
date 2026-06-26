# Neovim Database Connections (dadbod)

Dynamic database connections via `vim-dadbod-ui` with SSH tunnel support and 1Password credential management.

***Language***
- 🇺🇸 English
- [🇪🇸 Español](./dadbod-setup-es.md)

## Usage

Press `<leader>dc` to open the server picker. Select a server — connection opens automatically.

- `<leader>D` → toggle DBUI panel directly
- `<leader>dc` → open server picker → connect

Servers with an SSH host show a `󰣀` icon; direct connections show `󰋁`.

## Adding a Server

Edit `~/.config/nvim/db-connections.json`. This file is safe to commit — it contains no passwords.

### SSH tunnel server (remote)

```json
{
  "name": "staging",
  "ssh_host": "10.0.0.5",
  "ssh_port": "22",
  "ssh_user": "ubuntu",
  "ssh_key": "~/.ssh/staging_key.pem",
  "db_type": "postgresql",
  "db_name": "app_staging",
  "db_user": "dbadmin",
  "db_port": "5432",
  "op_ref": "op://Private/staging-db/password"
}
```

`ssh_key` is optional — omit it to use the SSH agent.  
`ssh_port` is optional — defaults to `22`.

### Direct connection (local or VPN)

```json
{
  "name": "local",
  "db_host": "127.0.0.1",
  "db_type": "postgresql",
  "db_name": "myapp_dev",
  "db_user": "postgres",
  "db_port": "5432",
  "op_ref": "op://Private/local-db/password"
}
```

`db_host` is optional — defaults to `127.0.0.1`. Set it for remote DBs without SSH (e.g., via VPN).  
Omit `ssh_host` entirely for direct connections.

### Supported `db_type` values

`postgresql`, `mysql`, `sqlite`, `mssql`, `redis` — anything dadbod supports.

## Credential Resolution

Passwords are resolved in this order:

1. **1Password** — `op read <op_ref>` via the `op` CLI. Must be signed in (`op signin`).
2. **`.db-secrets.json`** — fallback file at `~/.config/nvim/.db-secrets.json`.

If 1Password fails, a warning notification appears and the fallback is tried.

### Setting up 1Password

Store the DB password as a Login or Password item in 1Password. The `op_ref` format is:

```
op://VaultName/ItemName/FieldName
```

Example: `op://Private/prod-db/password`

Sign in before using Neovim:

```bash
eval $(op signin)
```

### Setting up the fallback secrets file

`~/.config/nvim/.db-secrets.json` is gitignored and has `600` permissions. Keys must match server `name` fields:

```json
{
  "prod": "your-prod-password",
  "local": "postgres"
}
```

## SSH Tunnels

Tunnels use local port `5433`. Only one tunnel can be active at a time — connecting to a second SSH server kills the first tunnel automatically.

Tunnels are killed automatically when Neovim exits.

## File Reference

| File | Purpose | Committed |
|---|---|---|
| `lua/plugins/dadbod.lua` | Plugin config + all connection logic | Yes |
| `db-connections.json` | Server metadata (no passwords) | Yes |
| `.db-secrets.json` | Password fallback | No (gitignored) |

## Troubleshooting

**"No password found"** — Either `op_ref` is missing/wrong, or server name is not in `.db-secrets.json`.

**"1Password failed"** — Run `eval $(op signin)` in your terminal before opening Neovim.

**"Failed to start SSH tunnel"** — Check that `ssh` is in your PATH and the SSH key path exists.

**SSH stderr warnings** — Check notifications; SSH errors surface via `[dadbod] SSH: ...` warnings.

**DBUI shows old connection** — DBUI is closed and reopened on each connect to force a refresh.
