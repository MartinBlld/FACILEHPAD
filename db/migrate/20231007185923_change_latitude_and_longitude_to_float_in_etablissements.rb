class ChangeLatitudeAndLongitudeToFloatInEtablissements < ActiveRecord::Migration[7.0]
  def up
    change_column :etablissements, :latitude, :float, using: 'latitude::float'
    change_column :etablissements, :longitude, :float, using: 'longitude::float'
  end

  def down
    change_column :etablissements, :latitude, :string
    change_column :etablissements, :longitude, :string
  end
end
