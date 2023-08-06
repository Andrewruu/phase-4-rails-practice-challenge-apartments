class TenantsController < ApplicationController
    
    def index
        render json: Tenant.all, status: :ok
    end

    def show
        tenant = Tenant.find_by(id: params[:id])
        if tenant.nil?
            render json: {error: "apartment not found"}, status: :not_found
        else
            render json: apartment, status: :ok
        end
    end

    def update
        tenant = Tenant.find_by(id: params[:id])

        if tenant.update(tenant_params)
            render json: tenant, status: :ok
        else
            rentder json: {error: "faild to update"}, status: :unprocessable_entity
        end
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    end

    def destroy
        tenant = Tenant.find_by(id: params[:id])

        if tenant.nil?
            render json: {error: "tenant not found"}, status: :not_found
        else
            tenant.leases.destroy_all
            tenant.destroy
            render json: {message: "tenant removed"}, status: :ok
        end

    end

    private

    def tenant_params
        params.permit(:name, :age)
    end
end
