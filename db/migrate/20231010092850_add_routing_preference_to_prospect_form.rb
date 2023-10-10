class AddRoutingPreferenceToProspectForm < ActiveRecord::Migration[7.0]
  def change
    add_column :prospect_forms, :routing_preference, :string
  end
end
