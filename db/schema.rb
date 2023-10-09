# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_10_09_151002) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "etablissements", force: :cascade do |t|
    t.string "siret"
    t.string "raison_sociale"
    t.string "adresse"
    t.string "telephone"
    t.date "date_maj"
    t.float "latitude"
    t.float "longitude"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "finesset"
    t.float "prix_hp_cs"
    t.float "prix_hp_cd"
    t.float "prix_hp_cs_ash"
    t.float "prix_hp_cd_ash"
    t.float "prix_ht_cs"
    t.float "prix_ht_cd"
    t.float "prix_ht_cs_ash"
    t.float "prix_ht_cd_ash"
    t.integer "prestation_inc_1", default: 0
    t.integer "prestation_inc_2", default: 0
    t.integer "prestation_inc_3", default: 0
    t.integer "prestation_inc_4", default: 0
    t.integer "prestation_inc_5", default: 0
    t.integer "prestation_inc_6", default: 0
    t.integer "prestation_inc_7", default: 0
    t.integer "prestation_inc_8", default: 0
    t.integer "prestation_inc_9", default: 0
    t.integer "prestation_inc_10", default: 0
    t.integer "prestation_inc_11", default: 0
    t.text "autre_prestation_inc"
    t.integer "prestation_sup_1", default: 0
    t.float "tarif_prestation_sup_1"
    t.text "unite_de_tarif_prestation_sup_1"
    t.integer "prestation_sup_2", default: 0
    t.integer "prestation_sup_3", default: 0
    t.integer "prestation_sup_4", default: 0
    t.integer "prestation_sup_5", default: 0
    t.integer "prestation_sup_6", default: 0
    t.integer "prestation_sup_7", default: 0
    t.integer "prestation_sup_8", default: 0
    t.integer "prestation_sup_9", default: 0
    t.integer "prestation_sup_10", default: 0
    t.integer "prestation_sup_11", default: 0
    t.text "autres_prestation_sup"
    t.float "tarif_dependance_gir_12"
    t.float "tarif_dependance_gir_34"
    t.float "tarif_dependance_gir_56"
    t.datetime "date_maj_prix"
  end

  create_table "prospect_forms", force: :cascade do |t|
    t.string "email"
    t.string "telephone"
    t.string "echelle_gir"
    t.string "ville_actuelle_senior"
    t.string "adresse_de_recherche"
    t.integer "code_postal"
    t.float "latitude_de_recherche"
    t.float "longitude_de_recherche"
    t.integer "rayon_de_recherche"
    t.integer "nombre_de_places"
    t.string "services_indispensables"
    t.string "services_souhaites"
    t.string "type_de_residence"
    t.string "confession_de_la_residence"
    t.string "type_de_chambre"
    t.string "animal_de_compagnie"
    t.string "besoins_alimentaires"
    t.string "etat_de_sante"
    t.string "conditions_medicales_particulieres"
    t.string "maladie_degenerative"
    t.string "meubles_et_objets_personnels"
    t.string "besoins_spécifiques_aménagement"
    t.string "fréquence_des_visites"
    t.string "besoins_spécifiques_visiteurs"
    t.string "interets_pour_sorties"
    t.string "interets_pour_activites"
    t.string "etat_du_dossier_administratif"
    t.integer "budget_mensuel"
    t.string "aides_financieres_déjà_obtenues_ou_en_cours"
    t.string "aides_financieres_a_demander"
    t.string "commentaires"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "connaissance_gir"
    t.string "status"
    t.boolean "revenu_mensuel_mini"
  end

end
