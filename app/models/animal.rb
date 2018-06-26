class Animal < ApplicationRecord
  # TODO: add different status instead of only set adopted / have control of
  # the animals history.
  has_one :animal_breed
end
