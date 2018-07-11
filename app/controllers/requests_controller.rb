class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]

  def index
    @requests = Request.all
  end

  def show
  end

  def new
    @request = Request.new
    animal_id = params[:animal_id]
    animal = Animal.find(animal_id)
    @other_types = animal.other_types
  end

  def edit
    animal_id = params[:animal_id]
    animal = Animal.find(animal_id)
    @other_types = animal.other_types
  end

  def create
    @request = Request.new(request_params)

    if @request.save
      redirect_to requests_url, notice: 'Request was successfully created.'
    else
      render :new
    end
  end

  def update
    if @request.update(request_params)
      redirect_to requests_url, notice: 'Request was successfully updated.'
    else
      render :edit
    end
  end

  def delete
    request = Request.find(params[:request_id])
    request.destroy

    redirect_to requests_url, notice: 'Request was successfully destroyed.'
  end

  private

  def set_request
    @request = Request.find(params[:request_id])
  end

  def request_params
    params.fetch(:request, {})
  end
end
