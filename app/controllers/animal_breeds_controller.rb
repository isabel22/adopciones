class AnimalBreedsController < ApplicationController
  def index
    animal_specy_id = params[:animal_specy_id]
    @animal_breeds = AnimalBreed.where(animal_species_id: animal_specy_id).order(name: :asc)
    @animal_species = AnimalSpecy.where(id: animal_specy_id).first
  end

  def new
    animal_specy_id = params[:animal_specy_id]
    @animal_species = AnimalSpecy.where(id: animal_specy_id).first
  end

  def create
    AnimalBreed.create!(safe_params)

    redirect_to(animal_specy_animal_breeds_path(params[:animal_specy_id]), notice: "Created successfully")
  end

  private

  def safe_params
    params.require(:animal_breed).permit!
  end
end
