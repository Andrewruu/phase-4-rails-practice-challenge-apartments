class ApartmentsController < ApplicationController

    def index
        render json: Apartment.all, status: :ok
    end

    def show
        apartment = Apartment.find_by(id: params[:id])
        if apartment.nil?
            render json: {error: "apartment not found"}, status: :not_found
        else
            render json: apartment, status: :ok
        end
    end

    def update
        apartment = Apartment.find_by(id: params[:id])

        if apartment.update(apt_params)
            render json: apartment, status: :ok
        else
            rentder json: {error: "faild to update"}, status: :unprocessable_entity
        end
    end

    def create
        apartment = Apartment.create!(apt_params)
        render json: apartment, status: :created
    end

    def destroy
        apartment = Apartment.find_by(id: params[:id])

        if apartment.nil?
            render json: {error: "apartment not found"}, status: :not_found
        else
            apartment.leases.destroy_all
            apartment.destroy
            render json: {message: "apartment removed"}, status: :ok
        end

    end

    private

    def apt_params
        params.permit(:number)
    end
end
