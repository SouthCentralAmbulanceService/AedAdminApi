# Api Module
module Api
  # Manage access to AED JSON object
  class AedManagerController < ApiController
    def aed_data
      @data = obtain_aed_data
      expires_in(expire_time, public: true)
      render json: {
        data: @data
      }.to_json
    end

    def aed_data_geo
      check_geo_params(lat, lng)
      expires_in(expire_time, public: true)
      render json: {
        data: obtain_aed_data_geo(lat, lng)
      }.to_json
    end

    private

    def lat
      params[:lat]
    end

    def lng
      params[:lng]
    end

    def radius
      params[:radius].to_s.empty? ? default_radius : params[:radius]
    end

    def default_radius
      5
    end

    def expire_time
      1.hour
    end

    def exceptions
      [:id, :updated_at, :created_at, :validated?, :admin_user_id]
    end

    def obtain_aed_data
      Rails.cache.fetch('aed_data', expires_in: expire_time) do
        Aed.validated.as_json except: exceptions
      end
    end

    def obtain_aed_data_geo(lat, lng)
      Aed.geo_search(lat, lng, radius).as_json except: exceptions
    end
  end
end
