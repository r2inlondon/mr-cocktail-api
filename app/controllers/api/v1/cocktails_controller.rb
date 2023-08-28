module Api
  module V1
    class CocktailsController < ApplicationController
      def index
        cocktails = Cocktail.all

        newCocktails = cocktails.map do |cocktail|
          cocktail_ingredients = cocktail.ingredients.map do |ingredient|
            { id: ingredient.id, description: ingredient.description, cocktail_id: ingredient.cocktail_id }
          end

          # cocktail_ingredients = Cocktail.find(cocktail.id).ingredients

          {
            id: cocktail.id,
            name: cocktail.name,
            image: cocktail.image,
            ingredients: cocktail_ingredients
          }
        end

        if cocktails
          render json: { status: 'SUCCESS', message: 'Loaded cocktails', data: newCocktails }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Cocktails not found', data: cocktails }, status: :not_found
        end
      end

      def create
        cocktail = Cocktail.new(cocktail_params)

        if cocktail.save
          render json: { status: 'SUCCESS', message: 'Saved cocktail', data: cocktail }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Cocktail not saved', data: cocktail.errors },
                 status: :unprocessable_entity
        end
      end

      def show
        cocktail = Cocktail.find(params[:id])

        if cocktail
          render json: { status: 'SUCCESS', message: 'Loaded cocktail', data: cocktail }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Cocktail not found' }, status: :not_found
        end
      end

      def update
        cocktail = Cocktail.find(params[:id])

        if cocktail.update(cocktail_params)
          render json: { status: 'SUCCESS', message: 'Updated cocktail', data: cocktail }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Cocktail not updated', data: cocktail.errors }
        end
      end

      def destroy
        cocktail = Cocktail.find(params[:id])

        if cocktail.destroy
          render json: { status: 'SUCCESS', message: 'Deleted cocktail', data: cocktail }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Cocktail not deleted', data: cocktail.errors }
        end
      end

      private

      def cocktail_params
        params.require(:cocktail).permit(:name, :image).tap do |element|
          element[:name] = params[:cocktail][:name].strip.capitalize
        end
      end
    end
  end
end
