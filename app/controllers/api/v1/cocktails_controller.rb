module Api
  module V1
    class CocktailsController < ApplicationController
      def index
        # Your logic for fetching cocktails goes here
        # For example:
        cocktails = Cocktail.all
        render json: cocktails
      end

      # Other actions (show, create, update, destroy) could be added here
    end
  end
end
