class AnimalBreedsController < ApplicationController
  def index
    animal_specy_id = params[:animal_specy_id]
    @animal_breeds = AnimalBreed.where(animal_species_id: animal_specy_id).order(name: :asc)
    @animal_species_name = AnimalSpecy.where(id: animal_specy_id).first.name
  end
end
