# frozen_string_literal: true

json.array! @accomplishments, partial: 'accomplishments/accomplishment', as: :accomplishment
