# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  after_create :set_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def can_be_removed?
    Request.where(email: email).count.zero?
  end

  private

  def set_default_role
    add_role(:requester) if roles.blank?
  end
end
