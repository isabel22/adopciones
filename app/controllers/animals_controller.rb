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

    redirect_to(animals_path, alert: "Animal deleted")
  end

  def edit
    @animal = Animal.find(params[:animal_id])
    authorize! :write, @animal
  end

  def update
    animal = Animal.find(params[:animal_id])
    authorize! :write, animal

    animal.update(safe_params)
    redirect_to(animals_path, notice: "Animal updated")
  end

  def new
    authorize! :write, Animal
    @animal_species = AnimalSpecy.all
    @animal_breeds = AnimalBreed.all
  end

  def create
    authorize! :write, Animal
    animal = Animal.create(safe_params)

    if animal.valid?
      redirect_to(animals_path, notice: "Animal created")
    else
      @errors = animal.errors
      @animal_species = AnimalSpecy.all
      @animal_breeds = AnimalBreed.all
      render action: 'new', params: animal
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
      :profile_picture
    )
  end
end
