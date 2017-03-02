# Api module
module Api
  # Main Api Controller
  class ApiController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :check_json

    private

    def check_geo_params(lat, lng)
      return error_with(
        404, ['No lat or lng information provided']
      ) if !lat || !lng
    end

    def check_json
      return error_with(
        401, ['Not a JSON request']
      ) if request.format != :json
    end

    def error_with(stat_code, error_messages)
      render status: stat_code, json: { errors: error_messages }.to_json
    end
  end
end
