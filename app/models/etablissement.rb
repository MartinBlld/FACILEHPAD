class Etablissement < ApplicationRecord
  validates :finesset, uniqueness: true, allow_nil: true
  validates :prestation_inc_1, :prestation_inc_2, :prestation_inc_3,
  :prestation_inc_4, :prestation_inc_5, :prestation_inc_6,
  :prestation_inc_7, :prestation_inc_8, :prestation_inc_9,
  :prestation_inc_10, :prestation_inc_11,
  :prestation_sup_1, :prestation_sup_2, :prestation_sup_3,
  :prestation_sup_4, :prestation_sup_5, :prestation_sup_6,
  :prestation_sup_7, :prestation_sup_8, :prestation_sup_9,
  :prestation_sup_10, :prestation_sup_11,
  numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }, allow_nil: true

  before_save :normalize_prestations

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode


  SERVICE_DESCRIPTIONS = {
    prestation_inc_1: "Entretien du linge du résident non délicat",
    prestation_inc_2: "Marquage du linge",
    prestation_inc_3: "Fourniture de produits d’hygiène corporelle",
    prestation_inc_4: "Mise à disposition d’un poste de téléphonie dans la chambre",
    prestation_inc_5: "Appels téléphoniques entrants non facturés en sus",
    prestation_inc_6: "Appels téléphoniques sortants non facturés en sus",
    prestation_inc_7: "Mise à disposition d’un poste de télévision dans la chambre",
    prestation_inc_8: "Internet dans la chambre (abonnement/accès au réseau Wifi)",
    prestation_inc_9: "Prestations de coiffure (shampoing, coupe)",
    prestation_inc_10: "Prestations esthétiques de base",
    prestation_inc_11: "Prestations de pédicurie-podologie (hors prescription médicale)",
    prestation_sup_1: "Entretien du linge du résident non délicat [Supplémentaire]",
    prestation_sup_2: "Marquage du linge [Supplémentaire]",
    prestation_sup_3: "Fourniture de produits d’hygiène corporelle [Supplémentaire]",
    prestation_sup_4: "Mise à disposition d’un poste de téléphonie dans la chambre [Supplémentaire]",
    prestation_sup_5: "Appels téléphoniques entrants [Supplémentaire]",
    prestation_sup_6: "Appels téléphoniques sortants [Supplémentaire]",
    prestation_sup_7: "Mise à disposition d’un poste de télévision dans la chambre [Supplémentaire]",
    prestation_sup_8: "Internet dans la chambre (abonnement/accès au réseau Wifi) [Supplémentaire]",
    prestation_sup_9: "Prestations de coiffure (shampoing, coupe) [Supplémentaire]",
    prestation_sup_10: "Prestations esthétiques de base [Supplémentaire]",
    prestation_sup_11: "Prestations de pédicurie-podologie (hors prescription médicale) [Supplémentaire]",
    autre_prestation_inc: "Autre prestation incluse",
    autres_prestation_sup: "Autres prestations supplémentaires",
    # ... ajoutez toutes vos descriptions de services ici ...
  }.freeze


  PRICE_DESCRIPTIONS = {
    prix_hp_cs: "Prix de l’hébergement permanent en chambre seule",
    prix_hp_cd: "Prix de l’hébergement permanent en chambre double",
    prix_hp_cs_ash: "Prix de l’hébergement permanent en chambre seule pour personne bénéficiaire de l’ASH",
    prix_hp_cd_ash: "Prix de l’hébergement permanent en chambre double pour personne bénéficiaire de l’ASH",
    prix_ht_cs: "Prix de l’hébergement temporaire en chambre seule",
    prix_ht_cd: "Prix de l’hébergement temporaire en chambre double",
    prix_ht_cs_ash: "Prix de l’hébergement temporaire en chambre seule pour personne bénéficiaire de l’ASH",
    prix_ht_cd_ash: "Prix de l’hébergement temporaire en chambre double pour personne bénéficiaire de l’ASH",
    tarif_dependance_gir_12: "Tarif dépendance GIR 1-2",
    tarif_dependance_gir_34: "Tarif dépendance GIR 3-4",
    tarif_dependance_gir_56: "Tarif dépendance GIR 5-6",
    # ... ajoutez toutes vos descriptions de prix ici ...
  }.freeze

  def available_services
    available_standard_services.merge(available_supplementary_services)
  end

  def available_standard_services
    SERVICE_DESCRIPTIONS.select do |attribute, _|
      self[attribute] == "1"
    end
  end

  def available_supplementary_services
    {
      autre_prestation_inc: "Autre prestation incluse",
      autres_prestation_sup: "Autres prestations supplémentaires"
    }.select do |attribute, _|
      !self[attribute].nil? && !self[attribute].strip.empty?
    end
  end

  def prix_minimum
    if self.prix_hp_cs.nil?|| self.tarif_dependance_gir_56.nil?
      prix = "Prix impossible à calculer"
    else
      prix = (self.prix_hp_cs+ self.tarif_dependance_gir_56) * 30
    end
  end

  def prix_fonction_gir(gir)
    if self.prix_hp_cs.nil?
      prix = "Prix impossible à calculer"
    else
      case gir
      when 'GIR 1-2'
        prix = (self.prix_hp_cs + self.tarif_dependance_gir_12) * 30
      when 'GIR 3-4'
        prix = (self.prix_hp_cs + self.tarif_dependance_gir_34) * 30
      when 'GIR 5-6'
        prix = (self.prix_hp_cs + self.tarif_dependance_gir_56) * 30
      else
        prix = "GIR non reconnu"
      end
    end
    prix  # Retourne la valeur de prix
  end





private

  def normalize_prestations
    attributes.each do |name, value|
    self[name] = 0 if name.start_with?('prestation_inc_', 'prestation_sup_') && value.nil?
    end
  end

end
