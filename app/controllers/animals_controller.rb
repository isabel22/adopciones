# frozen_string_literal: true

class AnimalsController < ApplicationController
  def index
    authorize! :read, Animal
    @animals = Animal.order(created_at: :desc)
  end

  def show
    @animal = Animal.find(params[:animal_id])
    authorize! :read, @animal
  end

  def delete
    authorize! :manage, Animal
    animal = Animal.find(params[:animal_id])
    animal.destroy

    redirect_to(animals_path, alert: 'Animal deleted')
  end

  def edit
    @animal = Animal.find(params[:animal_id])
    authorize! :write, @animal
  end

  def update
    @animal = Animal.find(params[:animal_id])
    authorize! :write, @animal

    @animal.update(safe_params)

    if @animal.valid?
      redirect_to(animals_path, notice: 'Animal updated')
    else
      flash[:alert] = @animal.errors.full_messages.join('<br/>').html_safe
      render :edit
    end
  end

  def new
    authorize! :write, Animal
    @animal_species = AnimalSpecy.all
    @animal_breeds = AnimalBreed.all
    @animal = Animal.new
  end

  def create
    authorize! :write, Animal
    @animal = Animal.create(safe_params)

    if @animal.valid?
      redirect_to(animals_path, notice: 'Animal created')
    else
      @animal_species = AnimalSpecy.all
      @animal_breeds = AnimalBreed.all
      flash[:alert] = @animal.errors.full_messages.join('<br/>').html_safe
      render :new
    end
  end

  private

  def safe_params
    params.require(:animal).permit(
      :name,
      :gender,
      :birthdate_rescuedate,
      :rescued,
      :adopted,
      :adoption_date,
      :animal_breeds_id,
      :profile_picture,
      :description
    )
  end
end
