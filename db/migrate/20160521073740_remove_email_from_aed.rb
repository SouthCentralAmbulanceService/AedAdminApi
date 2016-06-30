class RemoveEmailFromAed < ActiveRecord::Migration
  def change
    remove_column :aeds, :email, :string
  end
end
