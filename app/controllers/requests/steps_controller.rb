class Requests
  class StepsController < ApplicationController
    include Wicked::Wizard
    steps :personal, :job, :family, :pets, :living_space

    def show
      request_id = params[:request_id]
      @request = Request.find(request_id)
      @animal_id =
        @request.animal_id || params['animal_id'] ||
        params.dig('request', 'animal_id')

      default_values_for_request
      render_wizard
    end

    def update
      request_id = params[:request_id]
      @request = Request.find(request_id)
      @animal_id = @request.animal_id

      if @request.update(request_params)
        render_wizard @request
      else
        flash[:alert] = @request.errors.full_messages.join('<br/>').html_safe
        render_wizard(step, request_id: @request.id)
      end
    end

    private

    def default_values_for_request
      @animal = Animal.find(@animal_id)
      @other_types = @animal.other_types
      @countries = all_countries
      @current_country = @request.country
    end

    def all_countries
      YAML.load_file(Rails.root.join('db', 'seeds', 'countries.yml')).values
    end

    def localize_current_country
      Timeout.timeout(5) do
        Net::HTTP.get_response(
          URI.parse("http://api.hostip.info/country.php?ip=#{request.remote_ip}")
        ).body
      end
    rescue StandardError
      'US'
    end

    def request_params
      set_other_pets
      params.require(:request).permit(
        :uid, :first_name, :last_name, :birthdate, :email, :address, :home_phone,
        :cellphone, :country, :job_position, :job_address, :job_phone, :other_pets,
        :puppy, :family_members, :all_agree, :type_of_home, :own_home, :place_to_be,
        :place_to_sleep, :has_garden, :can_escape, :signature, :status, :animal_id,
        :form_status, different_pet: []
      )
    end

    def set_other_pets
      params[:request][:different_pet] = [] if params[:request][:other_pets] == 'false'
    end
  end
end
