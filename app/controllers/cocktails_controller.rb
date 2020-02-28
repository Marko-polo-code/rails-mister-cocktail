class CocktailsController < ApplicationController
  def index
      if params[:search]
        @cocktails = Cocktail.where("name ILIKE ?", "%#{params[:search][:query]}%")
        if @cocktails.empty?
          @message = "Sorry we don`t have any #{params[:search][:query]}"
        end
      else
        @cocktails = Cocktail.all
      end
  end

  def show
    @cocktail = Cocktail.find(params[:id])
  end

  def new
    @cocktail = Cocktail.new(@cocktail)
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  # def search

  #   redirect_to cocktail_path(@cocktail.id)
  # end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name)
  end
end
