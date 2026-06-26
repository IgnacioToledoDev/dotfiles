# Conexiones de Base de Datos en Neovim (dadbod)

Conexiones dinámicas a bases de datos via `vim-dadbod-ui` con soporte de túnel SSH y gestión de credenciales con 1Password.

***Idioma***
- [🇺🇸 English](./dadbod-setup-en.md)
- 🇪🇸 Español

## Uso

Presioná `<leader>dc` para abrir el selector de servidores. Seleccioná un servidor — la conexión se abre automáticamente.

- `<leader>D` → abrir/cerrar panel DBUI directamente
- `<leader>dc` → abrir selector de servidores → conectar

Los servidores con host SSH muestran el ícono `󰣀`; las conexiones directas muestran `󰋁`.

## Agregar un Servidor

Editá `~/.config/nvim/db-connections.json`. Este archivo es seguro para commitear — no contiene contraseñas.

### Servidor con túnel SSH (remoto)

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

`ssh_key` es opcional — si se omite, usa el agente SSH.  
`ssh_port` es opcional — por defecto es `22`.

### Conexión directa (local o VPN)

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

`db_host` es opcional — por defecto es `127.0.0.1`. Configurarlo para DBs remotas sin SSH (ej: via VPN).  
Omitir `ssh_host` completamente para conexiones directas.

### Valores válidos de `db_type`

`postgresql`, `mysql`, `sqlite`, `mssql`, `redis` — cualquier tipo que soporte dadbod.

## Resolución de Credenciales

Las contraseñas se resuelven en este orden:

1. **1Password** — `op read <op_ref>` via la CLI `op`. Debe estar logueado (`op signin`).
2. **`.db-secrets.json`** — archivo fallback en `~/.config/nvim/.db-secrets.json`.

Si 1Password falla, aparece una notificación de advertencia y se intenta el fallback.

### Configurar 1Password

Guardá la contraseña de la DB como un item de Login o Password en 1Password. El formato de `op_ref` es:

```
op://NombreVault/NombreItem/NombreCampo
```

Ejemplo: `op://Private/prod-db/password`

Iniciá sesión antes de abrir Neovim:

```bash
eval $(op signin)
```

### Configurar el archivo de secretos fallback

`~/.config/nvim/.db-secrets.json` está en el gitignore y tiene permisos `600`. Las claves deben coincidir con los campos `name` de los servidores:

```json
{
  "prod": "tu-password-de-prod",
  "local": "postgres"
}
```

## Túneles SSH

Los túneles usan el puerto local `5433`. Solo puede estar activo un túnel a la vez — al conectarse a un segundo servidor SSH, el primer túnel se cierra automáticamente.

Los túneles se cierran automáticamente al salir de Neovim.

## Referencia de Archivos

| Archivo | Propósito | Commiteado |
|---|---|---|
| `lua/plugins/dadbod.lua` | Config del plugin + toda la lógica de conexión | Sí |
| `db-connections.json` | Metadata de servidores (sin contraseñas) | Sí |
| `.db-secrets.json` | Fallback de contraseñas | No (gitignored) |

## Solución de Problemas

**"No password found"** — El `op_ref` falta o es incorrecto, o el nombre del servidor no está en `.db-secrets.json`.

**"1Password failed"** — Ejecutá `eval $(op signin)` en la terminal antes de abrir Neovim.

**"Failed to start SSH tunnel"** — Verificá que `ssh` esté en el PATH y que la ruta de la clave SSH exista.

**Advertencias SSH en notificaciones** — Los errores SSH aparecen como notificaciones `[dadbod] SSH: ...`.

**DBUI muestra conexión vieja** — DBUI se cierra y reabre en cada conexión para forzar el refresco.
