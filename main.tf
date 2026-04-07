terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# ── Bucket S3 ──────────────────────────────────────────
resource "aws_s3_bucket" "vapi" {
  bucket = "${var.proyecto}-s3-vapi-grabaciones"

  tags = {
    proyecto = var.proyecto
    servicio = "vapi"
    tipo     = "grabaciones"
  }
}

resource "aws_s3_bucket_public_access_block" "vapi" {
  bucket = aws_s3_bucket.vapi.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "vapi" {
  bucket = aws_s3_bucket.vapi.id

  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "vapi" {
  bucket = aws_s3_bucket.vapi.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}

# ── Política IAM ───────────────────────────────────────
resource "aws_iam_policy" "vapi" {
  name        = "${var.proyecto}-vapi-s3-policy"
  description = "Acceso restringido al bucket de grabaciones VAPI para ${var.proyecto}"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.vapi.arn,
          "${aws_s3_bucket.vapi.arn}/*"
        ]
      }
    ]
  })
}

# ── Usuario IAM ────────────────────────────────────────
resource "aws_iam_user" "vapi" {
  name = "${var.proyecto}-vapi-s3-user"

  tags = {
    proyecto = var.proyecto
    servicio = "vapi"
  }
}

resource "aws_iam_user_policy_attachment" "vapi" {
  user       = aws_iam_user.vapi.name
  policy_arn = aws_iam_policy.vapi.arn
}

resource "aws_iam_access_key" "vapi" {
  user = aws_iam_user.vapi.name
}