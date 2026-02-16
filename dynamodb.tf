# ============================================================
# dynamodb.tf
# ============================================================

resource "aws_dynamodb_table" "tab_manager" {
  name           = "${var.app_name}-table"
  billing_mode   = var.dynamodb_billing_mode
  hash_key       = "entity_type"
  range_key      = "id"

  attribute {
    name = "entity_type"
    type = "S"
  }

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "created_at"
    type = "S"
  }

  attribute {
    name = "tag_id"
    type = "S"
  }

  # GSI 1 - Query by entity_type and created_at (for sorting by date)
  global_secondary_index {
    name            = "entity_type_created_at_idx"
    hash_key        = "entity_type"
    range_key       = "created_at"
    projection_type = "ALL"
  }

  # GSI 2 - Query tab_tags by tag_id
  global_secondary_index {
    name            = "entity_type_tag_id_idx"
    hash_key        = "entity_type"
    range_key       = "tag_id"
    projection_type = "ALL"
  }

  ttl {
    attribute_name = "expire_at"
    enabled        = false
  }

  tags = merge(local.common_tags, {
    Name = "${var.app_name}-table"
  })
}