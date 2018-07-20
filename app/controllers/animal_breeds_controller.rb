class AnimalBreedsController < ApplicationController
  def index
    authorize! :read, AnimalBreed
    animal_specy_id = params[:animal_specy_id]
    @animal_breeds = AnimalBreed.where(animal_species_id: animal_specy_id).order(name: :asc)
    @animal_species = AnimalSpecy.find(animal_specy_id)
  end

  def new
    authorize! :write, AnimalBreed
    @animal_species = AnimalSpecy.find(params[:animal_specy_id])
  end

  def create
    authorize! :write, AnimalBreed

    AnimalBreed.create!(safe_params)
    redirect_to(animal_specy_animal_breeds_path(params[:animal_specy_id]), notice: "Created successfully")
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

    redirect_to(animal_specy_animal_breeds_path(params[:animal_specy_id]), alert: "Animal breed deleted")
  end

  def edit
    @animal_species = AnimalSpecy.find(params[:animal_specy_id])
    @animal_breed = AnimalBreed.find(params[:animal_breed_id])
    authorize! :read, @animal_breed
  end

  def update
    animal_breed = AnimalBreed.find(params[:animal_breed_id])
    authorize! :read, @animal_breed

    animal_breed.update!(safe_params)
    redirect_to(animal_specy_animal_breeds_path(params[:animal_specy_id]), notice: "Updated successfully")
  end

  private

  def safe_params
    params.require(:animal_breed).permit!
  end
end
