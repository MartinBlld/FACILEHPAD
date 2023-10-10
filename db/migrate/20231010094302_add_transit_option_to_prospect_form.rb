class AddTransitOptionToProspectForm < ActiveRecord::Migration[7.0]
  def change
    add_column :prospect_forms, :transit_option, :string
  end
end
