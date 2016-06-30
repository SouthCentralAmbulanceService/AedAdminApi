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

    private

    def expire_time
      1.hour
    end

    def exceptions
      [:id, :updated_at, :created_at, :validated?]
    end

    def obtain_aed_data
      Rails.cache.fetch('aed_data', expires_in: expire_time) do
        Aed.validated.as_json except: exceptions
      end
    end
  end
end
