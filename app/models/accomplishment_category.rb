# frozen_string_literal: true

class AccomplishmentCategory < ApplicationRecord
  belongs_to :accomplishment
  belongs_to :category
end
