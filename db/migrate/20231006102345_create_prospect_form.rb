class CreateProspectForm < ActiveRecord::Migration[7.0]
  def change
    create_table :prospect_forms do |t|
      t.string :email
      t.string :telephone
      t.string :echelle_gir
      t.string :ville_actuelle_senior
      t.string :adresse_de_recherche
      t.integer :code_postal
      t.integer :latitude_de_recherche
      t.integer :longitude_de_recherche
      t.integer :rayon_de_recherche
      t.integer :nombre_de_places
      t.string :services_indispensables
      t.string :services_souhaites
      t.string :type_de_residence
      t.string :confession_de_la_residence
      t.string :type_de_chambre
      t.string :animal_de_compagnie
      t.string :besoins_alimentaires
      t.string :etat_de_sante
      t.string :conditions_medicales_particulieres
      t.string :maladie_degenerative
      t.string :meubles_et_objets_personnels
      t.string :besoins_spécifiques_aménagement
      t.string :fréquence_des_visites
      t.string :besoins_spécifiques_visiteurs
      t.string :interets_pour_sorties
      t.string :interets_pour_activites
      t.string :etat_du_dossier_administratif
      t.integer :budget_mensuel
      t.string :aides_financieres_déjà_obtenues_ou_en_cours
      t.string :aides_financieres_a_demander
      t.string :commentaires



      t.timestamps
    end
  end
end
