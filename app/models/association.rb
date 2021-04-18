# frozen_string_literal: true

class Association < ApplicationRecord
  has_many :animals, dependent: :destroy
end
