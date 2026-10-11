resource "oci_ai_vision_stream_source" "ai_vision_stream_sources" {
  for_each = var.ai_vision_stream_sources

  compartment_id = each.value.compartment_id
  defined_tags   = each.value.defined_tags
  display_name   = each.value.display_name
  freeform_tags  = each.value.freeform_tags

  stream_source_details {
    camera_url  = each.value.stream_source_details.camera_url
    secret_id   = each.value.stream_source_details.secret_id
    source_type = each.value.stream_source_details.source_type
    stream_network_access_details {
      private_endpoint_id = each.value.stream_source_details.stream_network_access_details.private_endpoint_id
      stream_access_type  = each.value.stream_source_details.stream_network_access_details.stream_access_type
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

