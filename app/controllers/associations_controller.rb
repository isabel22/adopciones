# frozen_string_literal: true

class AssociationsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    authorize! :read, Animal
    @association = Association.find_by(uid: params[:id])
    puts "params: #{params}"
    @animals = @association&.animals&.order(created_at: :desc) || []
  end
end
