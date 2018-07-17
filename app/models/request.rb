class Request < ApplicationRecord
  validates :status, inclusion: { in: %w(pending approved disapproved) }
end
