class Proposition < ApplicationRecord
  belongs_to :prospect_form
  has_many :etablissement_propositions, dependent: :destroy
  has_many :etablissements, through: :etablissement_propositions

  validates :prospect_form_id, presence: true

  def self.create_for_prospect_form(prospect_form)
    # Vérifier que le rayon de recherche est une valeur numérique valide
    if prospect_form.rayon_de_recherche.blank? || !prospect_form.rayon_de_recherche.is_a?(Numeric)
      # Gérer le cas où le rayon de recherche est manquant ou invalide
      # Vous pouvez lever une exception, ajouter un message d'erreur, etc.
      raise ArgumentError, "Rayon de recherche manquant ou invalide"
    end

    etablissements_proches = Etablissement.near(
      [prospect_form.latitude_de_recherche, prospect_form.longitude_de_recherche],
      prospect_form.rayon_de_recherche
    ).limit(7)

    if etablissements_proches.empty?
      etablissements_proches = Etablissement.near(
        [prospect_form.latitude_de_recherche, prospect_form.longitude_de_recherche],
        prospect_form.rayon_de_recherche + 10
      )
    end

    # Créer une nouvelle proposition
    proposition = self.create(prospect_form: prospect_form)

    # Créer des EtablissementPropositions pour chaque établissement proche
    etablissements_proches.each do |etablissement|
      EtablissementProposition.create(proposition: proposition, etablissement: etablissement)
    end

    proposition
  end
end
