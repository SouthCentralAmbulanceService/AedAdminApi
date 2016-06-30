ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }
  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel 'Info' do
          para 'Welcome to AED Admin panel.'
        end
      end
      column do
        panel 'Recent Additions' do
          ul do
            Aed.last(5).map do |aed|
              li link_to("Facility: #{aed.facility_name}", admin_aed_path(aed))
            end
          end
        end
      end
    end
  end
end
