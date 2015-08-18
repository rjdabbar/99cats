class CatRentalRequestsController < ApplicationController
  def new
    @rental_request = CatRentalRequest.new
    @cats = Cat.all
  end

  def create
    @cats = Cat.all
    @rental_request = CatRentalRequest.new(request_params)
    
    if @rental_request.save
      redirect_to cat_url(@rental_request.cat_id)
    else
      render :new
    end
  end

  def show
    @rental_request = CatRentalRequest.find(params[:id])
  end


  private

  def request_params
    params.require(:cat_rental_request).permit(:cat_id,
                                               :start_date,
                                               :end_date,
                                               :status)
  end
end
