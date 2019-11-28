class Accomplishment < ApplicationRecord
  belongs_to :accomplishment_type

  delegate :name, to: :accomplishment_type, prefix: true
end
