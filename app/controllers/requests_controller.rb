class RequestsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_request, only: [:show, :edit, :update, :destroy, :approve, :disapprove]

  def index
    @requests = Request.all
  end

  def show
    @animal = Animal.find(@request.animal_id)
    @other_types = @animal.other_types
  end

  def new
    @request = Request.new
    animal_id = params[:animal_id]
    animal = Animal.find(animal_id)
    @other_types = animal.other_types
  end

  def edit
    animal = Animal.find(@request.animal_id)
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

  def approve
    @request.update(status: 'approved')
    redirect_to requests_url, notice: 'Request approved successfully'
  end

  def disapprove
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
