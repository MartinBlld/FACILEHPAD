class AddTransitOptionsToEtablissementProposition < ActiveRecord::Migration[7.0]


  def change
    add_column :etablissement_propositions, :transit_option, :string
    add_column :etablissement_propositions, :routing_preference, :string
  end
end
