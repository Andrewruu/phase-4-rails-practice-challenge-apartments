class LeasesController < ApplicationController
    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :created
    end

    def destroy
        lease = Lease.find_by(id: params[:id])

        if lease.nil?
            render json: {error: "lease not found"}, status: :not_found
        else
            lease.destroy
            render json: {message: "lease removed"}, status: :ok
        end

    end
    private

    def lease_params
        params.permit(:rent, :apartment_id, :tenant_id)
    end
end
