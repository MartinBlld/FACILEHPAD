class AddStatusToProspect < ActiveRecord::Migration[7.0]
  def change
    add_column :prospect_forms, :status, :string
  end
end
