class Proposition < ApplicationRecord
  belongs_to :prospect_form
  has_many :etablissement_propositions, dependent: :destroy
  has_many :etablissements, through: :etablissement_propositions

  def self.create_for_prospect_form(prospect_form)
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
