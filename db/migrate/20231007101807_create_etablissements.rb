class CreateEtablissements < ActiveRecord::Migration[7.0]
  def change
    create_table :etablissements do |t|
        t.string :siret
        t.string :raison_sociale
        t.string :adresse
        t.string :telephone
        t.date :date_maj
        t.string :latitude
        t.string :longitude
        t.string :status
      t.timestamps
    end
  end
end
