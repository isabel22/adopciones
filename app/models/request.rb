# frozen_string_literal: true

class Request < ApplicationRecord
  # validates :status, inclusion: { in: %w[pending approved disapproved] }
  # validates :uid, :first_name, :last_name, :birthdate, :email, presence: true, if: :active_or_personal?
  # validates :address, :home_phone, :country, :job_position, presence: true, if: :active_or_job? # I need to fix this validation
  # validates :job_address, :job_phone, presence: true, if: :active_or_job? # I need to fix this validation
  # validates :family_members, :type_of_home, :animal_id, presence: true, if: :active_or_family? # I need to fix this validation
  # validates :puppy, :other_pets, :all_agree, inclusion: { in: [true, false], message: '%{value} is not valid' }, if: :active_or_pets? # I need to fix this validation
  # validates :own_home, :can_escape, :has_garden, inclusion: { in: [true, false], message: '%{value} is not valid' }, if: :active_or_living_area? # I need to fix this validation
  # validates :puppy, :other_pets, :all_agree, :own_home, :can_escape, :has_garden, exclusion: { in: [nil] }, if: :active? # I need to fix this validation
  # validates :place_to_be, :place_to_sleep, presence: true, if: :active_or_living_area?
  # validate :date_cannot_be_in_the_future, :different_pet?, if: :active_or_pets? # I need to fix this validation

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

  def active?
    form_status == 'active'
  end

  def active_or_personal?
    form_status.include?('personal') || active?
  end

  def active_or_job?
    form_status.include?('job') || active?
  end

  def active_or_family?
    form_status.include?('family') || active?
  end

  def active_or_pets?
    form_status.include?('pets') || active?
  end

  def active_or_living_area?
    form_status.include?('living_area') || active?
  end
end
