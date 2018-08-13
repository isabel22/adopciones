class Request < ApplicationRecord
  validates :status, inclusion: { in: %w(pending approved disapproved) }
  validates :uid, :first_name, :last_name, :birthdate, :email, presence: true
  validates :address, :home_phone, :country, :job_position, presence: true
  validates :job_address, :job_phone, presence: true
  validates :puppy, :family_members, presence: true
  validates :all_agree, :type_of_home, :own_home, presence: true
  validates :place_to_be, :place_to_sleep, :has_garden, presence: true
  validates :can_escape, presence: true
  validates :animal_id, presence: true
  validate :date_cannot_be_in_the_future, :has_different_pet

  has_many :references

  private

  def date_cannot_be_in_the_future
    if birthdate.present?

      if birthdate > Date.today
        errors.add(:birthdate, "can't be in the future")
      end

      if birthdate < Date.today - 100
        errors.add("You don't apply to adopt.")
      end
    end
  end

  def has_different_pet
    if other_pets.present?
      if other_pets && different_pet.nil?
        errors.add(:different_pet, "You need to select the other type of pets that you have.")
      end
    end
  end
end
