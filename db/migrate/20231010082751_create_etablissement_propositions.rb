class CreateEtablissementPropositions < ActiveRecord::Migration[7.0]
  def change
    create_table :etablissement_propositions do |t|
      t.references :etablissement, null: false, foreign_key: true
      t.references :proposition, null: false, foreign_key: true
      t.integer :distance_etablissement_prospect
      t.integer :temps_de_transport_en_secondes
      t.text :temps_de_trajet_affichable
      t.string :moyen_de_transport
      t.string :classement
      t.timestamps
    end
  end
end
