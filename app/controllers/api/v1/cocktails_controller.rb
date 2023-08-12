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
        params.require(:cocktail).permit(:name, :image).tap do |whitelisted|
          whitelisted[:name] = params[:cocktail][:name].strip
        end
      end
    end
  end
end
