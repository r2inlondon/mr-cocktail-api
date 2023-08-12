module Api
  module V1
    class IngredientsController < ApplicationController
      def index
        cocktail = Cocktail.find(params[:cocktail_id])
        ingredients = cocktail.ingredients

        if ingredients.any?
          render json: { status: 'SUCCESS', message: 'Loaded ingredients', data: ingredients }, status: :ok
        else
          render json: { status: 'ERROR', message: 'No ingredients found', data: ingredients }, status: :not_found
        end
      end

      def create
        ingredient = Ingredient.new(ingredient_params)
        if ingredient.save
            render json: { status: 'SUCCESS', message: 'Saved ingredient', data: ingredient }, status: :ok
        else
            render json: { status: 'ERROR', message: 'Ingredient not saved', data: ingredient.errors }, status: :bad_request
        end
      end

      private

      def ingredient_params
        params.permit(:description, :cocktail_id)
      end
    end
  end
end
