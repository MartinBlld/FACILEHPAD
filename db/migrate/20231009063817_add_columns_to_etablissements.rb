class AddColumnsToEtablissements < ActiveRecord::Migration[7.0]
  def change
    add_column :etablissements, :finesset, :string
    add_column :etablissements, :prix_hp_cs, :decimal
    add_column :etablissements, :prix_hp_cd, :decimal
    add_column :etablissements, :prix_hp_cs_ash, :decimal
    add_column :etablissements, :prix_hp_cd_ash, :decimal
    add_column :etablissements, :prix_ht_cs, :decimal
    add_column :etablissements, :prix_ht_cd, :decimal
    add_column :etablissements, :prix_ht_cs_ash, :decimal
    add_column :etablissements, :prix_ht_cd_ash, :decimal
    add_column :etablissements, :prestation_inc_1, :integer, default: 0
    add_column :etablissements, :prestation_inc_2, :integer, default: 0
    add_column :etablissements, :prestation_inc_3, :integer, default: 0
    add_column :etablissements, :prestation_inc_4, :integer, default: 0
    add_column :etablissements, :prestation_inc_5, :integer, default: 0
    add_column :etablissements, :prestation_inc_6, :integer, default: 0
    add_column :etablissements, :prestation_inc_7, :integer, default: 0
    add_column :etablissements, :prestation_inc_8, :integer, default: 0
    add_column :etablissements, :prestation_inc_9, :integer, default: 0
    add_column :etablissements, :prestation_inc_10, :integer, default: 0
    add_column :etablissements, :prestation_inc_11, :integer, default: 0
    add_column :etablissements, :autre_prestation_inc, :text

    add_column :etablissements, :prestation_sup_1, :integer, default: 0
    add_column :etablissements, :tarif_prestation_sup_1, :decimal
    add_column :etablissements, :unite_de_tarif_prestation_sup_1, :text
    add_column :etablissements, :prestation_sup_2, :integer, default: 0
    add_column :etablissements, :prestation_sup_3, :integer, default: 0
    add_column :etablissements, :prestation_sup_4, :integer, default: 0
    add_column :etablissements, :prestation_sup_5, :integer, default: 0
    add_column :etablissements, :prestation_sup_6, :integer, default: 0
    add_column :etablissements, :prestation_sup_7, :integer, default: 0
    add_column :etablissements, :prestation_sup_8, :integer, default: 0
    add_column :etablissements, :prestation_sup_9, :integer, default: 0
    add_column :etablissements, :prestation_sup_10, :integer, default: 0
    add_column :etablissements, :prestation_sup_11, :integer, default: 0
    add_column :etablissements, :autres_prestation_sup, :text
    add_column :etablissements, :tarif_dependance_gir_12, :decimal
    add_column :etablissements, :tarif_dependance_gir_34, :decimal
    add_column :etablissements, :tarif_dependance_gir_56, :decimal
    add_column :etablissements, :date_maj_prix, :datetime
  end
end
