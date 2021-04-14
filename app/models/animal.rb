# frozen_string_literal: true

class Animal < ApplicationRecord
  # TODO: add different status instead of only set adopted / have control of
  # the animals history.
  has_one :animal_breed
  has_many :requests, dependent: :destroy
  validates :name, presence: true
  validates :gender, inclusion: { in: %w[female male], message: '%{value} is not a valid gender' }, presence: true
  validates :birthdate_rescuedate, presence: true
  validates :rescued, :adopted, inclusion: { in: [true, false], message: '%{value} is not valid' }
  validates :rescued, :adopted, exclusion: { in: [nil] }
  validates :animal_breeds_id, presence: true
  validates :profile_picture, presence: true
  validate :date_cannot_be_in_the_future, :valid_url, :animal_breed_exists

  def other_types
    breed = AnimalBreed.find(animal_breeds_id)
    AnimalSpecy.where.not(id: breed.animal_specy_id).pluck(:id, :name)
  end

  def female?
    gender == 'female'
  end

  def male?
    gender == 'male'
  end

  private

  def date_cannot_be_in_the_future
    if birthdate_rescuedate.present? && birthdate_rescuedate > Date.today
      errors.add(:birthdate_rescuedate, "can't be in the future")
    end

    errors.add(:adoption_date, "can't be in the future") if adoption_date.present? && adoption_date > Date.today
  end

  def animal_breed_exists
    breed_does_not_exist = animal_breeds_id.present? && AnimalBreed.find(animal_breeds_id).blank?
    errors.add(:animal_breeds_id, 'does not exists') if breed_does_not_exist
  end

  def valid_url
    return unless profile_picture.present?

    uri = URI.parse(profile_picture)
    errors.add(:profile_picture, 'is not valid') unless uri.is_a?(URI::HTTP) && !uri.host.nil?
  end
end
