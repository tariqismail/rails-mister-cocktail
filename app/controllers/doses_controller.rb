class DosesController < ApplicationController
  before_action :set_cocktail, only: %i[new create]

  def new
    @dose = Dose.new
    # @ingredients = Ingredient.all
  end

  def create
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail
    # @dose.ingredient = dose_params[]
    if @dose.save
      redirect_to @cocktail
    else
      render :new
    end
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def dose_params
    params.require(:dose).permit(:description, 'ingredient_id')
  end
end
