class AnimalSpeciesController < ApplicationController
  def index
    @animal_species = AnimalSpecy.order(name: :asc)
  end

  def new
    @animal_species = AnimalSpecy.order(name: :asc)
  end

  def create
    AnimalSpecy.create!(safe_params)

    redirect_to(animal_species_path, notice: "Created successfully")
  end

  def show
    @animal_species = AnimalSpecy.find(params[:animal_specy_id])
  end

  private

  def safe_params
    params.require(:animal_specy).permit!
  end
end
