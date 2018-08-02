class User < ApplicationRecord
  rolify
  after_create :set_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def can_be_removed?
    Request.where(email: self.email).count == 0
  end

  private

  def set_default_role
    self.add_role(:requester) if self.roles.blank?
  end
end
