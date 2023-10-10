class AddTravelTimeToProspectForm < ActiveRecord::Migration[7.0]
  def change
    add_column :prospect_forms, :temps_de_trajet_maximum_en_minutes, :integer
    add_column :prospect_forms, :moyen_de_transport, :string
  end
end
