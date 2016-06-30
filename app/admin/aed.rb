ActiveAdmin.register Aed do
  permit_params do
    [
      :aed_type,
      :facility_name,
      :address_line_1,
      :address_line_2,
      :post_code,
      :ward,
      :aed_count,
      :aed_location,
      :latitude,
      :longitude,
      :phone,
      :validated?
    ]
  end

  filter :aed_type
  filter :facility_name
  filter :address_line_1
  filter :address_line_2
  filter :post_code
  filter :ward
  filter :aed_count, label: 'Count'
  filter :latitude, label: 'Lat'
  filter :longitude, label: 'Lon'
  filter :phone
  filter :validated?

  index do
    selectable_column
    column 'Type', :aed_type
    column :facility_name
    column :post_code
    column :ward
    column 'Count', :aed_count
    column 'Lat', :latitude
    column 'Lon', :longitude
    column :phone
    column :created_at
    column :validated?
    actions
  end

  show do
    attributes_table do
      row 'Type', :aed_type
      row :facility_name
      row :address_line_1
      row :address_line_2
      row :post_code
      row :ward
      row 'Count' do
        aed.aed_count
      end
      row 'Lat' do
        aed.latitude
      end
      row 'Lon' do
        aed.longitude
      end
      row :phone
      row :created_at
      row :validated?
      active_admin_comments
    end
  end

  sidebar 'Location', only: :show do
    div do
      link_to(
        'Map Preview',
        "http://maps.google.com/maps?q=loc:#{aed.latitude},#{aed.longitude}",
        target: '_blank'
      )
    end
  end

  form partial: 'form'

  controller do
    def geo_distance_client
      @geo_distance_client ||= GeoCoderDistance.new
    end
  end

  collection_action :validate_distance do
    addr_1 = params[:addr_1]
    addr_2 = params[:addr_2]
    post_code = params[:post_code]
    lat = params[:lat]
    lon = params[:lon]
    distance_limit, suggested = geo_distance_client.over_max_range?(
      addr_1, addr_2, post_code, lat, lon
    )
    respond_to do |format|
      format.json do
        render json: {
          over_limit: distance_limit,
          suggested: suggested
        }
      end
    end
  end
end
