class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy, :approve, :disapprove]

  def index
    authorize! :read, Request

    if current_user.has_role? :requester
      @requests = Request.where(email: current_user.email)
    else
      @requests = Request.all
    end
  end

  def show
    authorize! :approve, @request
    @animal = Animal.find(@request.animal_id)
    @other_types = @animal.other_types
  end

  def new
    authorize! :write, Request
    @request = Request.new
    animal_id = params[:animal_id]
    @animal = Animal.find(animal_id)
    @other_types = @animal.other_types
  end

  def edit
    authorize! :write, Request
    animal = Animal.find(@request.animal_id)
    @other_types = animal.other_types
  end

  def create
    authorize! :write, Request

    @request = Request.new(request_params)
    if @request.save
      redirect_to requests_url, notice: 'Request was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize! :write, @request

    if @request.update(request_params)
      redirect_to requests_url, notice: 'Request was successfully updated.'
    else
      render :edit
    end
  end

  def approve
    authorize! :approve, @request

    @request.update(status: 'approved')
    redirect_to requests_url, notice: 'Request approved successfully'
  end

  def disapprove
    authorize! :approve, @request

    @request.update(status: 'disapproved')
    redirect_to requests_url, alert: 'Request disapproved successfully'
  end

  private

  def set_request
    @request = Request.find(params[:request_id])
  end

  def request_params
    params.require(:request).permit(
      :uid,
      :first_name,
      :last_name,
      :birthdate,
      :email,
      :address,
      :home_phone,
      :cellphone,
      :country,
      :job_position,
      :job_address,
      :job_phone,
      :references,
      :other_pets,
      :different_pet,
      :puppy,
      :family_members,
      :all_agree,
      :type_of_home,
      :own_home,
      :place_to_be,
      :place_to_sleep,
      :has_garden,
      :can_escape,
      :signature,
      :status,
      :animal_id
    )
  end
end
