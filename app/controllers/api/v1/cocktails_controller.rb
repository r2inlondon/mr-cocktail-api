module Api
  module V1
    class CocktailsController < ApplicationController
      def index
        # Your logic for fetching cocktails goes here
        # For example:
        cocktails = Cocktail.all

        if cocktails
          render json: { status: 'SUCCESS', message: 'Loaded cocktails', data: cocktails }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Cocktails not found', data: cocktails }, status: :not_found
        end
      end

      def create
        cocktail = Cocktail.new(cocktail_params)

        if cocktail.save
          render json: { status: 'SUCCESS', message: 'Saved cocktail', data: cocktail }, status: :ok  
        else
          render json: { status: 'ERROR', message: 'Cocktail not saved', data: cocktail.errors }, status: :unprocessable_entity 
        end
      end
      
      private

      def cocktail_params
        params.require(:cocktail).permit(:name, :image )
      end
    end
  end
end
