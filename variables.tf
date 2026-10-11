variable "ai_vision_stream_sources" {
  description = <<EOT
Map of ai_vision_stream_sources, attributes below
Required:
    - compartment_id
    - stream_source_details (block):
        - camera_url (required)
        - secret_id (optional)
        - source_type (required)
        - stream_network_access_details (required, block):
            - private_endpoint_id (required)
            - stream_access_type (required)
Optional:
    - defined_tags
    - display_name
    - freeform_tags
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    compartment_id = string
    defined_tags   = optional(map(string))
    display_name   = optional(string)
    freeform_tags  = optional(map(string))
    stream_source_details = object({
      camera_url  = string
      secret_id   = optional(string)
      source_type = string
      stream_network_access_details = object({
        private_endpoint_id = string
        stream_access_type  = string
      })
    })
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.ai_vision_stream_sources : (
        contains([for v in ["RTSP"] : lower(v)], lower(v.stream_source_details.source_type))
      )
    ])
    error_message = "must be one of: \"RTSP\""
  }
  validation {
    condition = alltrue([
      for k, v in var.ai_vision_stream_sources : (
        contains([for v in ["PRIVATE"] : lower(v)], lower(v.stream_source_details.stream_network_access_details.stream_access_type))
      )
    ])
    error_message = "must be one of: \"PRIVATE\""
  }
}

