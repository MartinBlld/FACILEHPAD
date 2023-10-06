class ChangeLatandLongInFloat < ActiveRecord::Migration[7.0]
  def change
    change_column :prospect_forms, :latitude_de_recherche, :float
    change_column :prospect_forms, :longitude_de_recherche, :float
  end
end
