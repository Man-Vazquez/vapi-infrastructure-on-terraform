# 🪣 Terraform — VAPI S3 Setup

Template de Terraform para automatizar el aprovisionamiento de infraestructura AWS necesaria en cada despliegue de un agente de voz con VAPI.

## ¿Qué crea?

Por cada proyecto se generan automáticamente los siguientes recursos en AWS:

- **Bucket S3** con bloqueo total de acceso público, cifrado SSE-S3 y etiquetas de proyecto.
- **Política IAM** con permisos restringidos al bucket (`PutObject`, `GetObject`, `DeleteObject`, `ListBucket`).
- **Usuario IAM** con la política adjunta y credenciales de acceso programático listas para configurar en VAPI.

### Nomenclatura generada

| Recurso | Nombre |
|---|---|
| Bucket S3 | `{proyecto}-s3-vapi-grabaciones` |
| Política IAM | `{proyecto}-vapi-s3-policy` |
| Usuario IAM | `{proyecto}-vapi-s3-user` |

---

## Requisitos

- [Terraform CLI](https://developer.hashicorp.com/terraform/install) instalado
- [AWS CLI](https://aws.amazon.com/cli/) instalado y configurado
- Usuario IAM con permisos para crear recursos S3 e IAM

### Configurar credenciales AWS

```bash
aws configure
```

---

## Uso

### 1. Clonar el repositorio

```bash
git clone <url-del-repo>
cd terraform-vapi
```

### 2. Inicializar Terraform (solo la primera vez)

```bash
terraform init
```

### 3. Previsualizar los recursos a crear

```bash
terraform plan -var="proyecto=nombre-del-proyecto"
```

### 4. Crear la infraestructura

```bash
terraform apply -var="proyecto=nombre-del-proyecto"
```

Confirma con `yes` cuando se solicite.

### 5. Obtener las credenciales generadas

```bash
# Ver Access Key ID (visible en el output)
terraform output access_key_id

# Ver Secret Access Key
terraform output secret_access_key
```

---

## Ejemplo

```bash
terraform apply -var="proyecto=example"
```

Genera:
- `example-s3-vapi-grabaciones`
- `example-vapi-s3-policy`
- `example-vapi-s3-user`

---

## Estructura del proyecto

```
terraform-vapi/
├── main.tf          # Recursos: bucket S3, política IAM, usuario IAM
├── variables.tf     # Definición de variables
├── outputs.tf       # Outputs: bucket, usuario y credenciales
├── .gitignore       # Archivos excluidos del repositorio
└── README.md        # Este archivo
```