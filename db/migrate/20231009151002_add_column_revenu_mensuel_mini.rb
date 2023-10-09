class AddColumnRevenuMensuelMini < ActiveRecord::Migration[7.0]
  def change
    add_column :prospect_forms, :revenu_mensuel_mini, :boolean
  end
end
