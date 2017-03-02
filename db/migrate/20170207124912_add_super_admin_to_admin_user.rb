class AddSuperAdminToAdminUser < ActiveRecord::Migration
  def change
    add_column :admin_users, :super, :boolean, default: false
  end
end
