class AddValidatedToAed < ActiveRecord::Migration
  def change
    add_column :aeds, :validated?, :boolean, default: false
  end
end
