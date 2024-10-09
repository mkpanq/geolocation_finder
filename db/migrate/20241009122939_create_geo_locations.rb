class CreateGeoLocations < ActiveRecord::Migration[7.2]
  def change
    create_table :geo_locations, id: :uuid do |t|
      t.string :query, null: false
      t.string :ip, null: false
      t.string :domain, null: false
      t.string :continent
      t.string :country
      t.string :country_code
      t.string :region
      t.string :region_code
      t.string :city
      t.string :zip
      t.string :timezone
      t.string :lattitude
      t.string :longitude
      t.string :isp_name
      t.string :org_name

      t.timestamps
    end

    add_index :geo_locations, :query, unique: true
    add_index :geo_locations, :ip
    add_index :geo_locations, :domain
  end
end
