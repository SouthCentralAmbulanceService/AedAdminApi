class AddFloatToLatLong < ActiveRecord::Migration
  def change
    change_table :aeds do |t|
      t.remove :latitude, :longitude
      t.float :latitude
      t.float :longitude
    end
  end
end
