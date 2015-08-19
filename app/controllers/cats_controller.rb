require 'byebug'
class CatsController < ApplicationController
  before_action :check_owner, only: [:edit, :update]

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
    @cat.owner = current_user
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
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end



  private
  def cat_params
    params.require(:cat).permit(:name, :color, :sex, :birth_date, :description)
  end

  def check_owner
    unless Cat.find(params[:id]).owner == current_user
      redirect_to cats_url
    end
  end
end
