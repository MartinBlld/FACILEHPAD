class ChangeDecimalToFloat < ActiveRecord::Migration[7.0]
  def change
change_column :etablissements, :prix_hp_cs, :float, using: 'prix_hp_cs::float'
change_column :etablissements, :prix_hp_cd, :float, using: 'prix_hp_cd::float'
change_column :etablissements, :prix_hp_cs_ash, :float, using: 'prix_hp_cs_ash::float'
change_column :etablissements, :prix_hp_cd_ash, :float, using: 'prix_hp_cd_ash::float'
change_column :etablissements, :prix_ht_cs, :float, using: 'prix_ht_cs::float'
change_column :etablissements, :prix_ht_cd, :float, using: 'prix_ht_cd::float'
change_column :etablissements, :prix_ht_cs_ash, :float, using: 'prix_ht_cs_ash::float'
change_column :etablissements, :prix_ht_cd_ash, :float, using: 'prix_ht_cd_ash::float'
change_column :etablissements, :tarif_prestation_sup_1, :float, using: 'tarif_prestation_sup_1::float'
change_column :etablissements, :tarif_dependance_gir_12, :float, using: 'tarif_dependance_gir_12::float'
change_column :etablissements, :tarif_dependance_gir_34, :float, using: 'tarif_dependance_gir_34::float'
change_column :etablissements, :tarif_dependance_gir_56, :float, using: 'tarif_dependance_gir_56::float'





  end
end
