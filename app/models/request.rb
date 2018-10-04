# frozen_string_literal: true

class Request < ApplicationRecord
  validates :status, inclusion: { in: %w[pending approved disapproved] }
  validates :uid, :first_name, :last_name, :birthdate, :email, presence: true
  validates :address, :home_phone, :country, :job_position, presence: true
  validates :job_address, :job_phone, presence: true
  validates :family_members, :type_of_home, :animal_id, presence: true
  validates :puppy, :other_pets, :all_agree, inclusion: { in: [true, false], message: '%{value} is not valid' }
  validates :own_home, :can_escape, :has_garden, inclusion: { in: [true, false], message: '%{value} is not valid' }
  validates :puppy, :other_pets, :all_agree, :own_home, :can_escape, :has_garden, exclusion: { in: [nil] }
  validates :place_to_be, :place_to_sleep, presence: true
  validate :date_cannot_be_in_the_future, :different_pet?

  has_many :references, dependent: :destroy

  private

  def date_cannot_be_in_the_future
    errors.add(:birthdate, "can't be in the future") if birthdate.present? && birthdate > Date.today
    errors.add("You don't apply to adopt.") if birthdate.present? && birthdate < Date.today - 100.years
  end

  def different_pet?
    has_different_pets = other_pets.present? && other_pets && different_pet.nil?
    errors.add(:different_pet, 'You need to select the other type of pets that you have.') if has_different_pets
  end
end
