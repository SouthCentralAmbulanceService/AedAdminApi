class AddHasManyToAdminUser < ActiveRecord::Migration
  def change
    add_column :aeds, :admin_user_id, :integer
  end
end
