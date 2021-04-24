class Association < ApplicationRecord
  has_many :animals, dependent: :destroy

  scope :active, -> { where(active: true) }
end
