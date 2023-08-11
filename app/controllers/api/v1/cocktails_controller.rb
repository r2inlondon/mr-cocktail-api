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

      def create; end
    end
  end
end
