# frozen_string_literal: true

class AnimalBreedsController < ApplicationController
  def index
    authorize! :read, AnimalBreed
    animal_specy_id = params[:animal_specy_id]
    @animal_breeds = AnimalBreed.where(animal_specy_id: animal_specy_id).order(name: :asc)
    @animal_species = AnimalSpecy.find(animal_specy_id)
  end

  def new
    authorize! :write, AnimalBreed
    @animal_breed = AnimalBreed.new
    @animal_species = AnimalSpecy.find(params[:animal_specy_id])
  end

  def create
    authorize! :write, AnimalBreed
    @animal_breed = AnimalBreed.create(safe_params)

    if @animal_breed.valid?
      redirect_to(animal_specy_animal_breeds_path(params[:animal_specy_id]), notice: 'Created successfully')
    else
      @animal_species = AnimalSpecy.find(params[:animal_specy_id])
      flash[:alert] = @animal_breed.errors.full_messages.join('<br/>').html_safe
      render :new
    end
  end

  def show
    animal_breed_id = params[:animal_breed_id]
    @animal_breed = AnimalBreed.find(animal_breed_id)
    authorize! :read, @animal_breed
  end

  def delete
    authorize! :manage, AnimalBreed
    animal_breed = AnimalBreed.find(params[:animal_breed_id])
    animal_breed.destroy

    redirect_to(animal_specy_animal_breeds_path(params[:animal_specy_id]), alert: 'Animal breed deleted')
  end

  def edit
    authorize! :write, AnimalBreed
    @animal_species = AnimalSpecy.find(params[:animal_specy_id])
    @animal_breed = AnimalBreed.find(params[:animal_breed_id])
  end

  def update
    authorize! :write, AnimalBreed
    @animal_breed = AnimalBreed.find(params[:animal_breed_id])

    @animal_breed.update(safe_params)
    if @animal_breed.valid?
      redirect_to(animal_specy_animal_breeds_path(params[:animal_specy_id]), notice: 'Updated successfully')
    else
      @animal_species = AnimalSpecy.find(params[:animal_specy_id])
      flash[:alert] = @animal_breed.errors.full_messages.join('<br/>').html_safe
      render :edit
    end
  end

  private

  def safe_params
    params.require(:animal_breed).permit(:id, :name, :animal_specy_id)
  end
end
