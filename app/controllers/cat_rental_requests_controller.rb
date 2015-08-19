class CatRentalRequestsController < ApplicationController
  before_action :check_owner, only: [:approve, :deny]
  before_action :check_signed_in

  def new
    @rental_request = CatRentalRequest.new
    @cats = Cat.all

    # @cat = params[:cat]
    @cat = Cat.find(params[:cat][:id])

  end

  def create
    @cats = Cat.all
    @rental_request = CatRentalRequest.new(request_params)
    @rental_request.user_id = current_user.id
    if @rental_request.save
      redirect_to cat_url(@rental_request.cat_id)
    else
      render :new
    end
  end

  def show
    @rental_request = CatRentalRequest.find(params[:id])
  end

  def approve
    @rental_request = CatRentalRequest.find(params[:request_id])
    @rental_request.approve!
    redirect_to cat_url(@rental_request.cat_id)
  end

  def deny
    @rental_request = CatRentalRequest.find(params[:request_id])
    @rental_request.deny!
    redirect_to cat_url(@rental_request.cat_id)
  end

  private

  def request_params
    params.require(:cat_rental_request).permit(:cat_id,
                                               :start_date,
                                               :end_date,
                                               :status)
  end

  def check_owner
    unless Cat.find(params[:id]).owner == current_user

      redirect_to cats_url(params[:id])
    end
  end

  def check_signed_in
    unless signed_in?
      redirect_to new_session_url
    end
  end
end
