# frozen_string_literal: true

json.extract! accomplishment_type, :id, :name, :description_template, :created_at, :updated_at
json.url accomplishment_type_url(accomplishment_type, format: :json)
