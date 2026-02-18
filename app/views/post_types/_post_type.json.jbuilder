# frozen_string_literal: true

# Used for rendering JSON format for the template selection dropdown in the post form.
json.extract! post_type, :id, :name, :description_template, :created_at, :updated_at
json.url post_type_url(post_type, format: :json)
