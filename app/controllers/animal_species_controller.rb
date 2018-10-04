# frozen_string_literal: true

class AnimalSpeciesController < ApplicationController
  def index
    authorize! :read, AnimalSpecy
    @animal_species = AnimalSpecy.order(name: :asc)
  end

  def new
    authorize! :write, AnimalSpecy
    @animal_species = AnimalSpecy.new
  end

  def create
    authorize! :write, AnimalSpecy

    @animal_species = AnimalSpecy.create(safe_params)

    if @animal_species.valid?
      redirect_to(animal_species_path, notice: 'Created successfully')
    else
      flash[:alert] = @animal_species.errors.full_messages.join('<br/>').html_safe
      render :new
    end
  end

  def show
    authorize! :read, AnimalSpecy
    @animal_species = AnimalSpecy.find(params[:animal_specy_id])
  end

  def edit
    authorize! :write, AnimalSpecy
    @animal_species = AnimalSpecy.find(params[:animal_specy_id])
  end

  def update
    authorize! :write, AnimalSpecy
    @animal_species = AnimalSpecy.find(params[:animal_specy_id])
    @animal_species.update(safe_params)

    if @animal_species.valid?
      redirect_to(animal_species_path, notice: 'Animal species updated')
    else
      flash[:alert] = @animal_species.errors.full_messages.join('<br/>').html_safe
      render :edit
    end
  end

  def delete
    authorize! :manage, AnimalSpecy
    animal_species = AnimalSpecy.find(params[:animal_specy_id])
    animal_species.destroy

    redirect_to(animal_species_path, alert: 'Animal species deleted')
  end

  private

  def safe_params
    params.require(:animal_specy).permit!
  end
end
