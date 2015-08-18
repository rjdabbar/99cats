require 'byebug'
class CatsController < ApplicationController

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    @cat_requests = @cat.rental_requests.sort_by &:start_date
    render :show
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end

  def new
    @cat = Cat.new
    render :new
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end



  private
  def cat_params
    params.require(:cat).permit(:name, :color, :sex, :birth_date, :description)
  end
end
