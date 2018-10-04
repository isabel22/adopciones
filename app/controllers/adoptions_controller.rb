# frozen_string_literal: true

class AdoptionsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @animals = Animal.where(adopted: false).order(created_at: :desc)
  end
end
