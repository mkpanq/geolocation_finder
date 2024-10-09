module Api::V1
  class LocationController < ApplicationController
    rescue_from Exception, with: :handle_error

    def initialize
      @location_data_service = LocationDataService.new
    end

    def save_location
      refresh_data = params[:refresh]&.downcase.to_s == "true" ? true : false
      saved_location = @location_data_service.add_geological_data(params[:query], refresh_data)

      render json: saved_location, status: :created
    end

    def get_location
      location = @location_data_service.get_geological_data(params[:query])

      render json: location, status: :ok
    end

    def delete_location
      deleted_location = @location_data_service.delete_geological_data(params[:query])

      render json: deleted_location, status: :ok
    end

    private

    def handle_error(exception)
      render json: { error: exception.message }, status: (exception.try(:status) || :internal_server_error)
    end
  end
end
