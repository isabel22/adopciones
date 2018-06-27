class AnimalsController < ApplicationController

  def index
    @animals = Animal.order(created_at: :desc)
  end

  def show
    @animal = Animal.find(params[:animal_id])
  end

  def delete
    animal = Animal.find(params[:animal_id])
    animal.destroy

    redirect_to(animals_path, alert: "Animal deleted")
  end

  def edit
    @animal = Animal.find(params[:animal_id])
  end

  def update
    animal = Animal.find(params[:animal_id])
    animal.update!(safe_params)

    redirect_to(animals_path, notice: "Animal updated")
  end

  def new
    @animal_breeds = AnimalBreed.all
  end

  def create
    Animal.create!(safe_params)

    redirect_to(animals_path, notice: "Animal created")
  end

  private

  def safe_params
    params.require(:animal).permit!
  end
end
