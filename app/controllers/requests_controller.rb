# frozen_string_literal: true

class RequestsController < ApplicationController
  include Wicked::Wizard
  before_action :set_request, only: %i[show edit update destroy approve disapprove]
  steps :personal, :job, :family, :pets, :living

  def index
    authorize! :read, Request

    @requests = if current_user.has_role? :requester
                  Request.where(email: current_user.email)
                else
                  Request.all
                end
  end

  def show
    authorize! :approve, @request
    @animal_id = @request.animal_id
    default_values_for_request
  end

  def new
    authorize! :write, Request
    @request = Request.new(animal_id: params[:animal_id])

    @animal_id = params[:animal_id] || params[:request][:animal_id]
    default_values_for_request
    @current_country = country_from_current_location
    # setup_wizard
    # puts "123 pasando... #{step} - #{wizard_path}"
    case step
    when :personal
      render_wizard
      # @request = Request.new
      puts "456 pasando..."
      # if @request.save
        # next_wizard_path(@request.id)
    #   else
    #     flash[:alert] = @request.errors.full_messages.join("<br/>").html_safe
    #   end
    when :job
    #   @request = Request.find(params[:request_id])
      render_wizard
    when :family
    #   @request = Request.find(params[:request_id])
      render_wizard
    #
    when :pets
    #   @request = Request.find(params[:request_id])
      render_wizard
    #
    when :living
    #   @request = Request.find(params[:request_id])
      render_wizard
    #
    end
    # render_wizard(@request)
  end

  def edit
    authorize! :write, Request
    @animal_id = @request.animal_id
    default_values_for_request
  end

  def create
    authorize! :write, Request

    @request = Request.new(request_params)
    if @request.save
      redirect_to requests_url, notice: 'Request was successfully created.'
    else
      @animal_id = params[:animal_id] || params[:request][:animal_id]
      default_values_for_request
      flash[:alert] = @request.errors.full_messages.join('<br/>').html_safe
      render :new
    end
  end

  def update
    authorize! :write, @request

    case step
    when :personal
      puts "hey!!"
    when :job
      @request = Request.find(params[:request_id])
    when :family
      @request = Request.find(params[:request_id])
    when :pets
      @request = Request.find(params[:request_id])
    when :living
      @request = Request.find(params[:request_id])
    end
    render_wizard @request

    if @request.update(request_params)
      redirect_to requests_url, notice: 'Request was successfully updated.'
    else
      @animal_id = @request.animal_id
      default_values_for_request
      flash[:alert] = @request.errors.full_messages.join('<br/>').html_safe
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

  def finish_wizard_path
    requests_url
  end

  def personal
    @animal_id = params[:animal_id]
    set_request


  end

  private

  def set_request
    @request = Request.find(params[:request_id])
  end

  def request_params
    set_other_pets
    params.require(:request).permit(
      :uid, :first_name, :last_name, :birthdate, :email, :address, :home_phone,
      :cellphone, :country, :job_position, :job_address, :job_phone, :other_pets,
      :puppy, :family_members, :all_agree, :type_of_home, :own_home, :place_to_be,
      :place_to_sleep, :has_garden, :can_escape, :signature, :status, :animal_id,
      different_pet: []
    )
  end

  def all_countries
    YAML.load_file(Rails.root.join('db', 'seeds', 'countries.yml')).values
  end

  def localize_current_country
    Timeout.timeout(5) do
      Net::HTTP.get_response(URI.parse(
                               'http://api.hostip.info/country.php?ip=' + request.remote_ip
                             )).body
    end
  rescue StandardError
    'US'
  end

  def set_other_pets
    params[:request][:different_pet] = [] if params[:request][:other_pets] == 'false'
  end

  def default_values_for_request
    @animal = Animal.find(@animal_id)
    @other_types = @animal.other_types
    @countries = all_countries
    @current_country = @request.country
  end

  def country_from_current_location
    locale = localize_current_country
    locale = 'US' if locale == 'XX'
    YAML.load_file(Rails.root.join('db', 'seeds', 'countries.yml'))[locale]
  end

  def set_steps

    if params[:flow] == "twitter"
      self.steps = [:ask_twitter, :ask_email]
    elsif params[:flow] == "facebook"
      self.steps = [:ask_facebook, :ask_email]
    end
  end
end
