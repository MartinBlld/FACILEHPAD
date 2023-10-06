class AddKnowingGir < ActiveRecord::Migration[7.0]
  def change
    add_column :prospect_forms, :connaissance_gir, :boolean
  end
end
