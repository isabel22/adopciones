class AssociationsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def index
    @associations = Association.active
  end

  def show
    @association = Association.find_by(uid: params[:id])
    @animals = @association&.animals&.order(created_at: :desc) || []
  end

  def new
    @association = Association.new(active: true)
  end

  def create
    @association = Association.create(safe_params)

    if @association.valid?
      redirect_to(associations_path, notice: 'Association created')
    else
      flash[:alert] = @association.errors.full_messages.join('<br/>').html_safe
      render :edit
    end
  end

  def edit
    @association = Association.find_by(uid: params[:id])
  end

  def update
    @association = Association.find(params[:id])
    @association.update(safe_params)

    if @association.valid?
      redirect_to(associations_path, notice: 'Association updated')
    else
      flash[:alert] = @association.errors.full_messages.join('<br/>').html_safe
      render :edit
    end
  end

  def destroy
    association = Association.find_by(uid: params[:id])
    association.destroy

    redirect_to(associations_path, alert: 'Association deleted')
  end

  private

  def safe_params
    params.require(:association).permit(
      :uid, :name, :email, :address, :home_phone, :description, :url,
      :photo_url, :extra_description, :donation_link, :active
    )
  end
end
