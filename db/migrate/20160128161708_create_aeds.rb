class CreateAeds < ActiveRecord::Migration
  def change
    create_table :aeds do |t|
      t.string :aed_type
      t.string :facility_name
      t.string :address_line_1
      t.string :address_line_2
      t.string :post_code
      t.string :ward
      t.integer :aed_count
      t.text :aed_location
      t.string :latitude
      t.string :longitude
      t.string :email
      t.string :phone
      t.timestamps null: false
    end
  end
end
