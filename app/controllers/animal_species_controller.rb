class AnimalSpeciesController < ApplicationController
  def index
    @animal_species = AnimalSpecy.order(name: :asc)
  end
end
